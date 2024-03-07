-- Name: AppointmentDetailsAudit AppointmentDetailsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."AppointmentDetailsAudit"
    ADD CONSTRAINT "AppointmentDetailsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: AppointmentHeadersAudit AppointmentHeadersAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."AppointmentHeadersAudit"
    ADD CONSTRAINT "AppointmentHeadersAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: OperatoriesAudit OperatoriesAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."OperatoriesAudit"
    ADD CONSTRAINT "OperatoriesAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: PatientsAudit PatientsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: ProvidersAudit ProvidersAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: TreatmentPlansAudit TreatmentPlansAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."TreatmentPlansAudit"
    ADD CONSTRAINT "TreatmentPlansAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: AppointmentsAudit AppointmentsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."AppointmentsAudit"
    ADD CONSTRAINT "AppointmentsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: OperatoriesAudit OperatoriesAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."OperatoriesAudit"
    ADD CONSTRAINT "OperatoriesAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: PatientProceduresAudit PatientProceduresAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PatientProceduresAudit"
    ADD CONSTRAINT "PatientProceduresAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: PatientsAudit PatientsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: PracticeProceduresAudit PracticeProceduresAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PracticeProceduresAudit"
    ADD CONSTRAINT "PracticeProceduresAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: ProductionCollectionsAudit ProductionCollectionsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProductionCollectionsAudit"
    ADD CONSTRAINT "ProductionCollectionsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: ProvidersAudit ProvidersAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: AppointmentsAudit AppointmentsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."AppointmentsAudit"
    ADD CONSTRAINT "AppointmentsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: PatientsAudit PatientsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: ProvidersAudit ProvidersAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: TreatmentsAudit TreatmentsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."TreatmentsAudit"
    ADD CONSTRAINT "TreatmentsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: AnonymizedImageMetadata AnonymizedImageMetadata_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."AnonymizedImageMetadata"
    ADD CONSTRAINT "AnonymizedImageMetadata_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id);


--
-- Name: AnonymizedImageMetadata AnonymizedImageMetadata_phiImageMetadataId_fkey; Type: FK CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."AnonymizedImageMetadata"
    ADD CONSTRAINT "AnonymizedImageMetadata_phiImageMetadataId_fkey" FOREIGN KEY ("phiImageMetadataId") REFERENCES "Phi"."PhiImageMetadata"(id);


--
-- Name: FolderHashToChartNum FolderHashToChartNum_practiceId_fkey; Type: FK CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."FolderHashToChartNum"
    ADD CONSTRAINT "FolderHashToChartNum_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"("videaId");


--
-- Name: ImageManifests ImageManifests_estimatedVisitId_fkey; Type: FK CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."ImageManifests"
    ADD CONSTRAINT "ImageManifests_estimatedVisitId_fkey" FOREIGN KEY ("estimatedVisitId") REFERENCES public."EstimatedVisit"(id);


--
-- Name: ImageManifests ImageManifests_patientId_fkey; Type: FK CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."ImageManifests"
    ADD CONSTRAINT "ImageManifests_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: AppointmentsAudit AppointmentsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."AppointmentsAudit"
    ADD CONSTRAINT "AppointmentsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: OperatoriesAudit OperatoriesAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."OperatoriesAudit"
    ADD CONSTRAINT "OperatoriesAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: PatientsAudit PatientsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: ProcedureLogsAudit ProcedureLogsAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProcedureLogsAudit"
    ADD CONSTRAINT "ProcedureLogsAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: ProvidersAudit ProvidersAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: AnalysesHistory AnalysesHistory_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."AnalysesHistory"
    ADD CONSTRAINT "AnalysesHistory_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Analyses Analyses_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Analyses"
    ADD CONSTRAINT "Analyses_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Analyses Analyses_rawResponseId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Analyses"
    ADD CONSTRAINT "Analyses_rawResponseId_fkey" FOREIGN KEY ("rawResponseId") REFERENCES analyses."RawResponses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BoneLevels BoneLevels_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."BoneLevels"
    ADD CONSTRAINT "BoneLevels_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BoneLevels BoneLevels_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."BoneLevels"
    ADD CONSTRAINT "BoneLevels_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Calculus Calculus_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Calculus"
    ADD CONSTRAINT "Calculus_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Calculus Calculus_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Calculus"
    ADD CONSTRAINT "Calculus_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Caries Caries_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Caries"
    ADD CONSTRAINT "Caries_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Caries Caries_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Caries"
    ADD CONSTRAINT "Caries_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Crowns Crowns_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Crowns"
    ADD CONSTRAINT "Crowns_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Crowns Crowns_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Crowns"
    ADD CONSTRAINT "Crowns_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Fillings Fillings_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Fillings"
    ADD CONSTRAINT "Fillings_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Fillings Fillings_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Fillings"
    ADD CONSTRAINT "Fillings_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Findings Findings_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Findings"
    ADD CONSTRAINT "Findings_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FmxSummary FmxSummary_estimatedVisitId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."FmxSummary"
    ADD CONSTRAINT "FmxSummary_estimatedVisitId_fkey" FOREIGN KEY ("estimatedVisitId") REFERENCES public."EstimatedVisit"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RawResponses RawResponses_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."RawResponses"
    ADD CONSTRAINT "RawResponses_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RootCanals RootCanals_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."RootCanals"
    ADD CONSTRAINT "RootCanals_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RootCanals RootCanals_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."RootCanals"
    ADD CONSTRAINT "RootCanals_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Roots Roots_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Roots"
    ADD CONSTRAINT "Roots_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Roots Roots_toothId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Roots"
    ADD CONSTRAINT "Roots_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES analyses."Teeth"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Teeth Teeth_analysesId_fkey; Type: FK CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Teeth"
    ADD CONSTRAINT "Teeth_analysesId_fkey" FOREIGN KEY ("analysesId") REFERENCES analyses."Analyses"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AnalyzedImages AnalyzedImages_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnalyzedImages"
    ADD CONSTRAINT "AnalyzedImages_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: CdtCodesToAnalysesLabels CdtCodesToAnalysesLabels_cdtCode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CdtCodesToAnalysesLabels"
    ADD CONSTRAINT "CdtCodesToAnalysesLabels_cdtCode_fkey" FOREIGN KEY ("cdtCode") REFERENCES public."CdtCodes"("cdtCode");


--
-- Name: CdtCodesToAnalysesLabels CdtCodesToAnalysesLabels_labelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CdtCodesToAnalysesLabels"
    ADD CONSTRAINT "CdtCodesToAnalysesLabels_labelId_fkey" FOREIGN KEY ("labelId") REFERENCES analyses."Labels"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DataDigestMeta DataDigestMeta_dataDigestId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigestMeta"
    ADD CONSTRAINT "DataDigestMeta_dataDigestId_fkey" FOREIGN KEY ("dataDigestId") REFERENCES public."DataDigest"(id);


--
-- Name: DataUploadAudit DataUploadAudit_dataUploadTriggerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataUploadAudit"
    ADD CONSTRAINT "DataUploadAudit_dataUploadTriggerId_fkey" FOREIGN KEY ("dataUploadTriggerId") REFERENCES public."DataUploadTriggers"(id);


--
-- Name: DataUploadAudit DataUploadAudit_practiceVideaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataUploadAudit"
    ADD CONSTRAINT "DataUploadAudit_practiceVideaId_fkey" FOREIGN KEY ("practiceVideaId") REFERENCES public."Practices"("videaId");


--
-- Name: EstimatedVisit EstimatedVisit_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstimatedVisit"
    ADD CONSTRAINT "EstimatedVisit_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: ExternalLocationSecrets ExternalLocationSecrets_provisionedEntityId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExternalLocationSecrets"
    ADD CONSTRAINT "ExternalLocationSecrets_provisionedEntityId_fkey" FOREIGN KEY ("provisionedEntityId") REFERENCES public."ProvisionedEntities"(id);


--
-- Name: HuddlePatientData HuddlePatientData_pmsPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HuddlePatientData"
    ADD CONSTRAINT "HuddlePatientData_pmsPatientId_fkey" FOREIGN KEY ("pmsPatientId") REFERENCES public."PmsPatients"(id);


--
-- Name: ImageAnalysisMirrors ImageAnalysisMirrors_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageAnalysisMirrors"
    ADD CONSTRAINT "ImageAnalysisMirrors_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id);


--
-- Name: ImageCatalog ImageCatalog_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageCatalog"
    ADD CONSTRAINT "ImageCatalog_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id);


--
-- Name: ImagingPatientIdentifiers ImagingPatientIdentifiers_imagingPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientIdentifiers"
    ADD CONSTRAINT "ImagingPatientIdentifiers_imagingPatientId_fkey" FOREIGN KEY ("imagingPatientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: ImagingPatientIdentifiers ImagingPatientIdentifiers_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientIdentifiers"
    ADD CONSTRAINT "ImagingPatientIdentifiers_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: ImagingPatientsSources ImagingPatientsSources_imagingPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientsSources"
    ADD CONSTRAINT "ImagingPatientsSources_imagingPatientId_fkey" FOREIGN KEY ("imagingPatientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: IntegrationJobAudit IntegrationJobAudit_integrationJobRunId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationJobAudit"
    ADD CONSTRAINT "IntegrationJobAudit_integrationJobRunId_fkey" FOREIGN KEY ("integrationJobRunId") REFERENCES public."IntegrationJobRuns"(id);


--
-- Name: MagicLink MagicLink_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MagicLink"
    ADD CONSTRAINT "MagicLink_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrganizationPreferences OrganizationPreferences_organizationId_Organizations_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationPreferences"
    ADD CONSTRAINT "OrganizationPreferences_organizationId_Organizations_fk" FOREIGN KEY ("organizationId") REFERENCES public."Organizations"("videaId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Organizations Organizations_stagingPracticeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Organizations"
    ADD CONSTRAINT "Organizations_stagingPracticeId_fkey" FOREIGN KEY ("vaultPracticeId") REFERENCES public."Practices"(id);


--
-- Name: PatientIdMatches PatientIdMatches_imagingPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PatientIdMatches"
    ADD CONSTRAINT "PatientIdMatches_imagingPatientId_fkey" FOREIGN KEY ("imagingPatientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: PatientIdMatches PatientIdMatches_pmsPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PatientIdMatches"
    ADD CONSTRAINT "PatientIdMatches_pmsPatientId_fkey" FOREIGN KEY ("pmsPatientId") REFERENCES public."PmsPatients"(id);


--
-- Name: PatientIdMatches PatientIdMatches_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PatientIdMatches"
    ADD CONSTRAINT "PatientIdMatches_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PmsAppointmentToTreatments PmsAppointmentToTreatments_appointmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointmentToTreatments"
    ADD CONSTRAINT "PmsAppointmentToTreatments_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES public."PmsAppointments"(id);


--
-- Name: PmsAppointmentToTreatments PmsAppointmentToTreatments_treatmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointmentToTreatments"
    ADD CONSTRAINT "PmsAppointmentToTreatments_treatmentId_fkey" FOREIGN KEY ("treatmentId") REFERENCES public."PmsTreatments"(id);


--
-- Name: PmsAppointments PmsAppointments_operatoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments"
    ADD CONSTRAINT "PmsAppointments_operatoryId_fkey" FOREIGN KEY ("operatoryId") REFERENCES public."PmsOperatories"(id);


--
-- Name: PmsAppointments PmsAppointments_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments"
    ADD CONSTRAINT "PmsAppointments_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."PmsPatients"(id);


--
-- Name: PmsAppointments PmsAppointments_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments"
    ADD CONSTRAINT "PmsAppointments_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PmsAppointments PmsAppointments_providerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments"
    ADD CONSTRAINT "PmsAppointments_providerId_fkey" FOREIGN KEY ("providerId") REFERENCES public."PmsProviders"(id);


--
-- Name: PmsOperatories PmsOperatories_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsOperatories"
    ADD CONSTRAINT "PmsOperatories_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PmsPatientViewCounts PmsPatientViewCounts_pmsPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatientViewCounts"
    ADD CONSTRAINT "PmsPatientViewCounts_pmsPatientId_fkey" FOREIGN KEY ("pmsPatientId") REFERENCES public."PmsPatients"(id);


--
-- Name: PmsPatientViewCounts PmsPatientViewCounts_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatientViewCounts"
    ADD CONSTRAINT "PmsPatientViewCounts_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PmsPatients PmsPatients_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatients"
    ADD CONSTRAINT "PmsPatients_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organizations"(id);


--
-- Name: PmsPatients PmsPatients_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatients"
    ADD CONSTRAINT "PmsPatients_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PmsProviders PmsProviders_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsProviders"
    ADD CONSTRAINT "PmsProviders_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organizations"(id);


--
-- Name: PmsProviders PmsProviders_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsProviders"
    ADD CONSTRAINT "PmsProviders_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PmsTreatmentStatusHistory PmsTreatmentStatusHistory_pmsTreatmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatmentStatusHistory"
    ADD CONSTRAINT "PmsTreatmentStatusHistory_pmsTreatmentId_fkey" FOREIGN KEY ("pmsTreatmentId") REFERENCES public."PmsTreatments"(id);


--
-- Name: PmsTreatments PmsTreatments_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatments"
    ADD CONSTRAINT "PmsTreatments_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."PmsPatients"(id);


--
-- Name: PmsTreatments PmsTreatments_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatments"
    ADD CONSTRAINT "PmsTreatments_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: PracticePreferences PracticePreferences_practiceId_Practices_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PracticePreferences"
    ADD CONSTRAINT "PracticePreferences_practiceId_Practices_fk" FOREIGN KEY ("practiceId") REFERENCES public."Practices"("videaId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Practices Practices_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Practices"
    ADD CONSTRAINT "Practices_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organizations"(id);


--
-- Name: ProvisionedEntities ProvisionedEntities_parentEntityId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProvisionedEntities"
    ADD CONSTRAINT "ProvisionedEntities_parentEntityId_fkey" FOREIGN KEY ("parentEntityId") REFERENCES public."ProvisionedEntities"(id);


--
-- Name: QuarantineImages QuarantineImages_imageManifestId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuarantineImages"
    ADD CONSTRAINT "QuarantineImages_imageManifestId_fkey" FOREIGN KEY ("imageManifestId") REFERENCES "NonPhi"."ImageManifests"(id);


--
-- Name: UnifiedAppointments UnifiedAppointments_estimatedVisitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_estimatedVisitId_fkey" FOREIGN KEY ("estimatedVisitId") REFERENCES public."EstimatedVisit"(id);


--
-- Name: UnifiedAppointments UnifiedAppointments_imagingPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_imagingPatientId_fkey" FOREIGN KEY ("imagingPatientId") REFERENCES public."ImagingPatients"(id);


--
-- Name: UnifiedAppointments UnifiedAppointments_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organizations"(id);


--
-- Name: UnifiedAppointments UnifiedAppointments_pmsAppointmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_pmsAppointmentId_fkey" FOREIGN KEY ("pmsAppointmentId") REFERENCES public."PmsAppointments"(id);


--
-- Name: UnifiedAppointments UnifiedAppointments_pmsPatientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_pmsPatientId_fkey" FOREIGN KEY ("pmsPatientId") REFERENCES public."PmsPatients"(id);


--
-- Name: UnifiedAppointments UnifiedAppointments_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: UserEvents UserEvents_estimatedVisitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEvents"
    ADD CONSTRAINT "UserEvents_estimatedVisitId_fkey" FOREIGN KEY ("estimatedVisitId") REFERENCES public."EstimatedVisit"(id);


--
-- Name: UtilizationMetrics UtilizationMetrics_practiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UtilizationMetrics"
    ADD CONSTRAINT "UtilizationMetrics_practiceId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"(id);


--
-- Name: VideaPathologyTypes VideaPathologyTypes_videaModelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaPathologyTypes"
    ADD CONSTRAINT "VideaPathologyTypes_videaModelId_fkey" FOREIGN KEY ("videaModelId") REFERENCES public."VideaAIModels"(id);


--
-- Name: EstimatedVisit estimated_visit_practice_videaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstimatedVisit"
    ADD CONSTRAINT "estimated_visit_practice_videaId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"("videaId");


--
-- Name: ImagingPatients imaging_patients_practice_videaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients"
    ADD CONSTRAINT "imaging_patients_practice_videaId_fkey" FOREIGN KEY ("practiceId") REFERENCES public."Practices"("videaId");


--
