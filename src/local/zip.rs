// https://github.com/zip-rs/zip/blob/master/examples/write_dir.rs
use std::io::{self, prelude::*};
use std::io::{Seek, Write};
use std::iter::Iterator;
use zip::write::FileOptions;

use anyhow::{anyhow, Context, Result};
use std::fs::{self, File};
use std::path::{Path, PathBuf};
use walkdir::{DirEntry, WalkDir};

fn zip_dir<T>(
    it: &mut dyn Iterator<Item = DirEntry>,
    src_dir: &Path,
    writer: T,
    method: zip::CompressionMethod,
) -> Result<()>
where
    T: Write + Seek,
{
    let mut zip = zip::ZipWriter::new(writer);
    let options = FileOptions::default()
        .compression_method(method)
        .unix_permissions(0o755); // Adjust permissions as needed

    let mut buffer = Vec::new();
    for entry in it {
        let path = entry.path();
        // Adjusted to include the source directory's name in the archive
        let name = Path::new(&src_dir.file_name().unwrap()).join(path.strip_prefix(src_dir)?);
        let name_str = name
            .to_str()
            .ok_or(anyhow!("Error getting file for zipping"))?;
        if path.is_file() {
            zip.start_file(name_str, options)?;
            let mut f = File::open(path)?;

            f.read_to_end(&mut buffer)?;
            zip.write_all(&buffer)?;
            buffer.clear();
        } else if name.as_os_str() != src_dir.file_name().unwrap() {
            // Add directories, except the root source directory
            zip.add_directory(name_str, options)?;
        }
    }
    zip.finish()?;
    Ok(())
}

pub fn compress(src_dir: &str, dst_file: &str) -> Result<()> {
    let src_path = Path::new(src_dir);
    if !src_path.is_dir() {
        return Err(anyhow!("Source directory not found"));
    }

    let file = File::create(dst_file)?;

    let walkdir = WalkDir::new(src_dir).into_iter();
    zip_dir(
        &mut walkdir.filter_map(|e| e.ok()),
        src_path,
        file,
        zip::CompressionMethod::Deflated,
    )?;

    Ok(())
}

pub fn decompress(fname: &str) -> Result<PathBuf> {
    let file = fs::File::open(fname)?;

    let mut archive = zip::ZipArchive::new(file)?;
    let mut parent: Option<PathBuf> = None;

    for i in 0..archive.len() {
        let mut file = archive.by_index(i)?;
        let outpath = match file.enclosed_name() {
            Some(path) => path.to_owned(),
            None => continue,
        };

        if (*file.name()).ends_with('/') {
            fs::create_dir_all(&outpath)?;
            let path = outpath.to_str().context("getting root path")?;
            let split_path = path.split("/").nth(0).context("getting parent path")?;
            parent = Some(PathBuf::from(split_path));
        } else {
            if let Some(p) = outpath.parent() {
                if !p.exists() {
                    fs::create_dir_all(p)?;
                }
            }
            let mut outfile = fs::File::create(&outpath)?;
            io::copy(&mut file, &mut outfile)?;
        }

        #[cfg(unix)]
        {
            use std::os::unix::fs::PermissionsExt;

            if let Some(mode) = file.unix_mode() {
                fs::set_permissions(&outpath, fs::Permissions::from_mode(mode))?;
            }
        }
    }

    let parent_folder = parent.context("getting parent dir")?;

    Ok(parent_folder)
}
