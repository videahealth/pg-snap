--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5 (Debian 15.5-1.pgdg110+1)
-- Dumped by pg_dump version 15.5 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Denticon; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Denticon";


ALTER SCHEMA "Denticon" OWNER TO postgres;

--
-- Name: DentrixAscend; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "DentrixAscend";


ALTER SCHEMA "DentrixAscend" OWNER TO postgres;

--
-- Name: DentrixCore; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "DentrixCore";


ALTER SCHEMA "DentrixCore" OWNER TO postgres;

--
-- Name: DentrixEnterprise11.0; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "DentrixEnterprise11.0";


ALTER SCHEMA "DentrixEnterprise11.0" OWNER TO postgres;

--
-- Name: DentrixEnterprise8.0; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "DentrixEnterprise8.0";


ALTER SCHEMA "DentrixEnterprise8.0" OWNER TO postgres;

--
-- Name: NonPhi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "NonPhi";


ALTER SCHEMA "NonPhi" OWNER TO postgres;

--
-- Name: OpenDental; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "OpenDental";


ALTER SCHEMA "OpenDental" OWNER TO postgres;

--
-- Name: Phi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Phi";


ALTER SCHEMA "Phi" OWNER TO postgres;

--
-- Name: analyses; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA analyses;


ALTER SCHEMA analyses OWNER TO postgres;

--
-- Name: partman; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA partman;


ALTER SCHEMA partman OWNER TO postgres;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: enum_AppointmentsAudit_status; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_AppointmentsAudit_status" AS ENUM (
    'LATE',
    'HERE',
    'READY',
    'CHAIR',
    'COMPLETED',
    'CONFIRMED',
    'UNCONFIRMED',
    'NO_SHOW',
    'BROKEN',
    'LEFT_MESSAGE',
    'CHECKOUT'
);


ALTER TYPE "DentrixAscend"."enum_AppointmentsAudit_status" OWNER TO postgres;

--
-- Name: enum_Appointments_status; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_Appointments_status" AS ENUM (
    'LATE',
    'HERE',
    'READY',
    'CHAIR',
    'COMPLETED',
    'CONFIRMED',
    'UNCONFIRMED',
    'NO_SHOW',
    'BROKEN',
    'LEFT_MESSAGE',
    'CHECKOUT'
);


ALTER TYPE "DentrixAscend"."enum_Appointments_status" OWNER TO postgres;

--
-- Name: enum_PatientProceduresAudit_state; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PatientProceduresAudit_state" AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'INVALIDATED'
);


ALTER TYPE "DentrixAscend"."enum_PatientProceduresAudit_state" OWNER TO postgres;

--
-- Name: enum_PatientProceduresAudit_status; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PatientProceduresAudit_status" AS ENUM (
    'COMPLETED',
    'EXISTING',
    'TREATMENT_PLAN'
);


ALTER TYPE "DentrixAscend"."enum_PatientProceduresAudit_status" OWNER TO postgres;

--
-- Name: enum_PatientProcedures_state; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PatientProcedures_state" AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'INVALIDATED'
);


ALTER TYPE "DentrixAscend"."enum_PatientProcedures_state" OWNER TO postgres;

--
-- Name: enum_PatientProcedures_status; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PatientProcedures_status" AS ENUM (
    'COMPLETED',
    'EXISTING',
    'TREATMENT_PLAN'
);


ALTER TYPE "DentrixAscend"."enum_PatientProcedures_status" OWNER TO postgres;

--
-- Name: enum_PatientsAudit_status; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PatientsAudit_status" AS ENUM (
    'NEW',
    'ACTIVE',
    'NON-PATIENT',
    'INACTIVE',
    'DUPLICATE'
);


ALTER TYPE "DentrixAscend"."enum_PatientsAudit_status" OWNER TO postgres;

--
-- Name: enum_Patients_status; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_Patients_status" AS ENUM (
    'NEW',
    'ACTIVE',
    'NON-PATIENT',
    'INACTIVE',
    'DUPLICATE'
);


ALTER TYPE "DentrixAscend"."enum_Patients_status" OWNER TO postgres;

--
-- Name: enum_PracticeProceduresAudit_category; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PracticeProceduresAudit_category" AS ENUM (
    'DIAGNOSTIC',
    'PREVENTIVE',
    'RESTORATIVE',
    'ENDODONTICS',
    'PERIODONTICS',
    'PROSTHREMOV',
    'MAXILLOPROSTH',
    'IMPLANTSERV',
    'PROSTHOFIXED',
    'ORALSURGERY',
    'ORTHODONTICS',
    'ADJUNCTSERV',
    'MULTICODES',
    'PRODUCTS'
);


ALTER TYPE "DentrixAscend"."enum_PracticeProceduresAudit_category" OWNER TO postgres;

--
-- Name: enum_PracticeProceduresAudit_treatmentArea; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PracticeProceduresAudit_treatmentArea" AS ENUM (
    'TOOTH',
    'MOUTH',
    'SURFACE',
    'QUADRANT',
    'ROOT',
    'MULTICODES',
    'ARCH',
    'SEXTANT',
    'RANGE'
);


ALTER TYPE "DentrixAscend"."enum_PracticeProceduresAudit_treatmentArea" OWNER TO postgres;

--
-- Name: enum_PracticeProcedures_category; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PracticeProcedures_category" AS ENUM (
    'DIAGNOSTIC',
    'PREVENTIVE',
    'RESTORATIVE',
    'ENDODONTICS',
    'PERIODONTICS',
    'PROSTHREMOV',
    'MAXILLOPROSTH',
    'IMPLANTSERV',
    'PROSTHOFIXED',
    'ORALSURGERY',
    'ORTHODONTICS',
    'ADJUNCTSERV',
    'MULTICODES',
    'PRODUCTS'
);


ALTER TYPE "DentrixAscend"."enum_PracticeProcedures_category" OWNER TO postgres;

--
-- Name: enum_PracticeProcedures_treatmentArea; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_PracticeProcedures_treatmentArea" AS ENUM (
    'TOOTH',
    'MOUTH',
    'SURFACE',
    'QUADRANT',
    'ROOT',
    'MULTICODES',
    'ARCH',
    'SEXTANT',
    'RANGE'
);


ALTER TYPE "DentrixAscend"."enum_PracticeProcedures_treatmentArea" OWNER TO postgres;

--
-- Name: enum_ProvidersAudit_specialty; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_ProvidersAudit_specialty" AS ENUM (
    'DENTALPUBLICHEALTH',
    'DENTALSPECIALTY',
    'DENTIST',
    'DENTAL',
    'ENDODONTICS',
    'FEDERALLYQUALIFIEDHEALTHCENTER',
    'GENERALPRACTICE',
    'HYGIENIST',
    'MULTISPECIALTY',
    'ORTHODONTICS',
    'ORALMAXILLOFACIALPATHOLOGY',
    'ORALMAXILLOFACIALRADIOLOGY',
    'ORALMAXILLOFACIALSURGERY',
    'PEDIATRICDENTISTRY',
    'PERIODONTICS',
    'PROSTHODONTICS',
    'SINGLESPECIALTY'
);


ALTER TYPE "DentrixAscend"."enum_ProvidersAudit_specialty" OWNER TO postgres;

--
-- Name: enum_Providers_specialty; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_Providers_specialty" AS ENUM (
    'DENTALPUBLICHEALTH',
    'DENTALSPECIALTY',
    'DENTIST',
    'DENTAL',
    'ENDODONTICS',
    'FEDERALLYQUALIFIEDHEALTHCENTER',
    'GENERALPRACTICE',
    'HYGIENIST',
    'MULTISPECIALTY',
    'ORTHODONTICS',
    'ORALMAXILLOFACIALPATHOLOGY',
    'ORALMAXILLOFACIALRADIOLOGY',
    'ORALMAXILLOFACIALSURGERY',
    'PEDIATRICDENTISTRY',
    'PERIODONTICS',
    'PROSTHODONTICS',
    'SINGLESPECIALTY'
);


ALTER TYPE "DentrixAscend"."enum_Providers_specialty" OWNER TO postgres;

--
-- Name: enum_generic_contactMethods; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_generic_contactMethods" AS ENUM (
    'CALL ME',
    'TEXT ME',
    'EMAIL ME'
);


ALTER TYPE "DentrixAscend"."enum_generic_contactMethods" OWNER TO postgres;

--
-- Name: enum_generic_genders; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend".enum_generic_genders AS ENUM (
    'M',
    'F',
    'O'
);


ALTER TYPE "DentrixAscend".enum_generic_genders OWNER TO postgres;

--
-- Name: enum_generic_languageTypes; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend"."enum_generic_languageTypes" AS ENUM (
    'ENGLISH',
    'SPANISH',
    'ARABIC',
    'ARMENIAN',
    'BENGALI',
    'BOSNIAN',
    'CAMBODIAN',
    'CHINESE_MANDARIN',
    'CHINESE_CANTONESE',
    'FRENCH',
    'GERMAN',
    'GREEK',
    'HEBREW',
    'HINDI',
    'ITALIAN',
    'JAPANESE',
    'KOREAN',
    'LAOTIAN',
    'POLISH',
    'PORTUGUESE',
    'RUSSIAN',
    'SOMALI',
    'TAGALOG',
    'VIETNAMESE'
);


ALTER TYPE "DentrixAscend"."enum_generic_languageTypes" OWNER TO postgres;

--
-- Name: enum_generic_states; Type: TYPE; Schema: DentrixAscend; Owner: postgres
--

CREATE TYPE "DentrixAscend".enum_generic_states AS ENUM (
    'AA',
    'AE',
    'AP',
    'AL',
    'AK',
    'AS',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CNMI',
    'CT',
    'DE',
    'DC',
    'FM',
    'FL',
    'FSM',
    'GA',
    'GU',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MH',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'MP',
    'OH',
    'OK',
    'OR',
    'PW',
    'PA',
    'PR',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VI',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY'
);


ALTER TYPE "DentrixAscend".enum_generic_states OWNER TO postgres;

--
-- Name: enum_CustomerTreatments_pmsType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_CustomerTreatments_pmsType" AS ENUM (
    'DENTRIX',
    'OPEN_DENTAL',
    'DENTRIX_ASCEND'
);


ALTER TYPE public."enum_CustomerTreatments_pmsType" OWNER TO postgres;

--
-- Name: enum_CustomerTreatments_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_CustomerTreatments_status" AS ENUM (
    'COMPLETED',
    'PLANNED',
    'OTHER',
    'SCHEDULED'
);


ALTER TYPE public."enum_CustomerTreatments_status" OWNER TO postgres;

--
-- Name: enum_CustomerTreatments_treatmentCategory; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_CustomerTreatments_treatmentCategory" AS ENUM (
    'RESTORATIVE',
    'OTHER',
    'PREVENTITIVE',
    'ENDODONTICS',
    'DIAGNOSTIC',
    'PROSTHODONTICS, REMOVABLE',
    'MAXILLOFACIAL PROSTHETICS',
    'IMPLANT SERVICES',
    'PROSTHODONTICS, SERVICES',
    'ORAL & MAXILLOFACIAL SURGERY',
    'ORTHODONTICS',
    'ADJUNCTIVE GENERAL SERVICES',
    'PERIODONTICS'
);


ALTER TYPE public."enum_CustomerTreatments_treatmentCategory" OWNER TO postgres;

--
-- Name: enum_CustomerTreatments_treatmentType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_CustomerTreatments_treatmentType" AS ENUM (
    'FILLING',
    'CROWN',
    'OTHER',
    'SRP',
    'PERIO MAINTENANCE',
    'PERIO OTHER'
);


ALTER TYPE public."enum_CustomerTreatments_treatmentType" OWNER TO postgres;

--
-- Name: enum_DataDigest_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_DataDigest_status" AS ENUM (
    'DRAFT',
    'PUBLISHED',
    'ARCHIVED'
);


ALTER TYPE public."enum_DataDigest_status" OWNER TO postgres;

--
-- Name: enum_DataUploadAudit_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_DataUploadAudit_type" AS ENUM (
    'Treatments',
    'Patients',
    'Providers',
    'Appointments'
);


ALTER TYPE public."enum_DataUploadAudit_type" OWNER TO postgres;

--
-- Name: enum_DataUploadTriggers_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_DataUploadTriggers_status" AS ENUM (
    'NOT_STARTED',
    'PROCESSING',
    'COMPLETED',
    'FAILED'
);


ALTER TYPE public."enum_DataUploadTriggers_status" OWNER TO postgres;

--
-- Name: enum_DataUploadTriggers_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_DataUploadTriggers_type" AS ENUM (
    'HISTORICAL',
    'DAILY',
    'CONTINUOUS'
);


ALTER TYPE public."enum_DataUploadTriggers_type" OWNER TO postgres;

--
-- Name: enum_EntityAliases_entityType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_EntityAliases_entityType" AS ENUM (
    'LOCATION',
    'ORGANIZATION'
);


ALTER TYPE public."enum_EntityAliases_entityType" OWNER TO postgres;

--
-- Name: enum_ExternalAccessTokens_tokenOwnerType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_ExternalAccessTokens_tokenOwnerType" AS ENUM (
    'LOCATION',
    'PARTNER'
);


ALTER TYPE public."enum_ExternalAccessTokens_tokenOwnerType" OWNER TO postgres;

--
-- Name: enum_ImagingPatientsSources_imagingPatientSource; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_ImagingPatientsSources_imagingPatientSource" AS ENUM (
    'DDAI',
    'STANDALONE'
);


ALTER TYPE public."enum_ImagingPatientsSources_imagingPatientSource" OWNER TO postgres;

--
-- Name: enum_InsightsAggregateMetrics_constructType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_InsightsAggregateMetrics_constructType" AS ENUM (
    'ORGANIZATION',
    'PRACTICE'
);


ALTER TYPE public."enum_InsightsAggregateMetrics_constructType" OWNER TO postgres;

--
-- Name: enum_InsightsAggregateMetrics_temporalIntervalType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_InsightsAggregateMetrics_temporalIntervalType" AS ENUM (
    'MONTH',
    'YEAR'
);


ALTER TYPE public."enum_InsightsAggregateMetrics_temporalIntervalType" OWNER TO postgres;

--
-- Name: enum_OpenDentalCustomerKeys_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_OpenDentalCustomerKeys_status" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public."enum_OpenDentalCustomerKeys_status" OWNER TO postgres;

--
-- Name: enum_PatientIdMatches_matchMethod; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PatientIdMatches_matchMethod" AS ENUM (
    'DIRECT_MATCH',
    'IMAGE_PATIENT_ID',
    'PERSONAL_DETAILS',
    'IMAGE_CHART_NUM'
);


ALTER TYPE public."enum_PatientIdMatches_matchMethod" OWNER TO postgres;

--
-- Name: enum_PmsAppointments_pmsIntegrationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsAppointments_pmsIntegrationType" AS ENUM (
    'DENTRIX',
    'DENTRIX_ASCEND',
    'OPEN_DENTAL',
    'DENTICON',
    'DENTRIX_ENTERPRISE'
);


ALTER TYPE public."enum_PmsAppointments_pmsIntegrationType" OWNER TO postgres;

--
-- Name: enum_PmsOperatories_pmsIntegrationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsOperatories_pmsIntegrationType" AS ENUM (
    'DENTRIX',
    'DENTRIX_ASCEND',
    'OPEN_DENTAL',
    'DENTICON',
    'DENTRIX_ENTERPRISE'
);


ALTER TYPE public."enum_PmsOperatories_pmsIntegrationType" OWNER TO postgres;

--
-- Name: enum_PmsPatients_pmsIntegrationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsPatients_pmsIntegrationType" AS ENUM (
    'DENTRIX',
    'DENTRIX_ASCEND',
    'OPEN_DENTAL',
    'DENTICON',
    'DENTRIX_ENTERPRISE'
);


ALTER TYPE public."enum_PmsPatients_pmsIntegrationType" OWNER TO postgres;

--
-- Name: enum_PmsProviders_pmsIntegrationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsProviders_pmsIntegrationType" AS ENUM (
    'DENTRIX',
    'DENTRIX_ASCEND',
    'OPEN_DENTAL',
    'DENTICON',
    'DENTRIX_ENTERPRISE'
);


ALTER TYPE public."enum_PmsProviders_pmsIntegrationType" OWNER TO postgres;

--
-- Name: enum_PmsTreatments_category; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsTreatments_category" AS ENUM (
    'PREVENTITIVE',
    'RESTORATIVE',
    'ENDODONTICS',
    'DIAGNOSTIC',
    'PERIODONTICS',
    'PROSTHODONTICS, REMOVABLE',
    'MAXILLOFACIAL PROSTHETICS',
    'IMPLANT SERVICES',
    'PROSTHODONTICS, SERVICES',
    'ORAL & MAXILLOFACIAL SURGERY',
    'ORTHODONTICS',
    'ADJUNCTIVE GENERAL SERVICES',
    'OTHER'
);


ALTER TYPE public."enum_PmsTreatments_category" OWNER TO postgres;

--
-- Name: enum_PmsTreatments_pmsIntegrationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsTreatments_pmsIntegrationType" AS ENUM (
    'DENTRIX',
    'DENTRIX_ASCEND',
    'OPEN_DENTAL',
    'DENTICON',
    'DENTRIX_ENTERPRISE'
);


ALTER TYPE public."enum_PmsTreatments_pmsIntegrationType" OWNER TO postgres;

--
-- Name: enum_PmsTreatments_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_PmsTreatments_status" AS ENUM (
    'COMPLETED',
    'PLANNED',
    'SCHEDULED',
    'OTHER',
    'REJECTED'
);


ALTER TYPE public."enum_PmsTreatments_status" OWNER TO postgres;

--
-- Name: enum_Practices_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_Practices_status" AS ENUM (
    'Active',
    'Inactive',
    'Trial'
);


ALTER TYPE public."enum_Practices_status" OWNER TO postgres;

--
-- Name: enum_ProvisionedEntities_entityType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_ProvisionedEntities_entityType" AS ENUM (
    'LOCATION',
    'ORGANIZATION'
);


ALTER TYPE public."enum_ProvisionedEntities_entityType" OWNER TO postgres;

--
-- Name: enum_UserEvents_eventName; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_UserEvents_eventName" AS ENUM (
    'patient.view'
);


ALTER TYPE public."enum_UserEvents_eventName" OWNER TO postgres;

--
-- Name: enum_UserWatchLists_watchListType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_UserWatchLists_watchListType" AS ENUM (
    'Practice',
    'Provider'
);


ALTER TYPE public."enum_UserWatchLists_watchListType" OWNER TO postgres;

--
-- Name: enum_UtilizationMetrics_intervalType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_UtilizationMetrics_intervalType" AS ENUM (
    'DAY',
    'WEEK'
);


ALTER TYPE public."enum_UtilizationMetrics_intervalType" OWNER TO postgres;

--
-- Name: update_practice_configuration(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_practice_configuration() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        target_videaId VARCHAR(255);
    BEGIN
        -- Determine the target_videaId based on which table triggered the update
        IF TG_TABLE_NAME = 'ProvisionedEntities' OR TG_TABLE_NAME = 'EntityAliases' THEN
            target_videaId := NEW."videaId";
        ELSIF TG_TABLE_NAME = 'ProductKeys' THEN
            target_videaId := NEW."practiceId";
        ELSIF TG_TABLE_NAME = 'Practices' THEN
            target_videaId := NEW."videaId";
        END IF;

        -- Update the configuration field in the Practices table for the given row
        UPDATE "Practices"
        SET configuration = subquery.configuration
        FROM (
            SELECT
                pr."videaId",
                CASE
                    WHEN (pe."videaId" IS NOT NULL OR ea."videaId" IS NOT NULL) AND pk."practiceId" IS NOT NULL THEN 'Both'
                    WHEN pe."videaId" IS NOT NULL OR ea."videaId" IS NOT NULL THEN 'DDAI'
                    WHEN pk."practiceId" IS NOT NULL THEN 'Standalone'
                    ELSE NULL
                END AS configuration
            FROM
                "Practices" pr
            LEFT JOIN
                "ProvisionedEntities" pe ON pr."videaId" = pe."videaId"
            LEFT JOIN
                "EntityAliases" ea ON pr."videaId" = ea."videaId"
            LEFT JOIN
                "ProductKeys" pk ON pr."videaId" = pk."practiceId"
            WHERE pr."videaId" = target_videaId
        ) AS subquery
        WHERE
            "Practices"."videaId" = subquery."videaId";

        RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.update_practice_configuration() OWNER TO postgres;

--
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."updatedAt" = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AppointmentDetails; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."AppointmentDetails" (
    id bigint NOT NULL,
    "apptId" bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint,
    "treatmentPlanId" bigint,
    "providerId" bigint,
    status character varying(255),
    code character varying(255),
    "adaCode" character varying(255),
    description character varying(255),
    tooth character varying(255),
    surface character varying(255),
    fee bigint,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."AppointmentDetails" OWNER TO postgres;

--
-- Name: COLUMN "AppointmentDetails".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."AppointmentDetails".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: AppointmentDetailsAudit; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."AppointmentDetailsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "apptId" bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint,
    "treatmentPlanId" bigint,
    "providerId" bigint,
    status character varying(255),
    code character varying(255),
    "adaCode" character varying(255),
    description character varying(255),
    tooth character varying(255),
    surface character varying(255),
    fee bigint,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."AppointmentDetailsAudit" OWNER TO postgres;

--
-- Name: COLUMN "AppointmentDetailsAudit"."integrationJobRunId"; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."AppointmentDetailsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "Denticon"."AppointmentDetails". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "AppointmentDetailsAudit".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."AppointmentDetailsAudit".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: AppointmentHeaders; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."AppointmentHeaders" (
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint NOT NULL,
    "patientId" character varying(255) NOT NULL,
    "appointmentDate" timestamp with time zone NOT NULL,
    "appointmentLength" character varying(255) NOT NULL,
    "providerId" bigint,
    "operatoryId" character varying(255),
    "isNewPatient" boolean,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "isMissed" boolean,
    "isCancelled" boolean,
    "isPosted" boolean,
    "isBlocked" boolean,
    "cancelledOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."AppointmentHeaders" OWNER TO postgres;

--
-- Name: COLUMN "AppointmentHeaders".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."AppointmentHeaders".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: AppointmentHeadersAudit; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."AppointmentHeadersAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint NOT NULL,
    "patientId" character varying(255) NOT NULL,
    "providerId" bigint NOT NULL,
    "operatoryId" character varying(255) NOT NULL,
    "appointmentDate" timestamp with time zone NOT NULL,
    "appointmentLength" character varying(255) NOT NULL,
    "isNewPatient" boolean,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "isMissed" boolean,
    "isCancelled" boolean,
    "isPosted" boolean,
    "isBlocked" boolean,
    "cancelledOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."AppointmentHeadersAudit" OWNER TO postgres;

--
-- Name: COLUMN "AppointmentHeadersAudit"."integrationJobRunId"; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."AppointmentHeadersAudit"."integrationJobRunId" IS 'This is the only additional column compared to "Denticon"."AppointmentHeaders". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "AppointmentHeadersAudit".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."AppointmentHeadersAudit".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: Operatories; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."Operatories" (
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint NOT NULL,
    description character varying(255),
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."Operatories" OWNER TO postgres;

--
-- Name: COLUMN "Operatories".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."Operatories".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: OperatoriesAudit; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."OperatoriesAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint NOT NULL,
    description character varying(255),
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."OperatoriesAudit" OWNER TO postgres;

--
-- Name: COLUMN "OperatoriesAudit"."integrationJobRunId"; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."OperatoriesAudit"."integrationJobRunId" IS 'This is the only additional column compared to "Denticon"."Operatories". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "OperatoriesAudit".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."OperatoriesAudit".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: Patients; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."Patients" (
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint,
    "firstName" character varying(255),
    "lastName" character varying(255),
    "birthDate" timestamp with time zone,
    sex character varying(255),
    active boolean,
    address character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    "denticonCreatedOn" timestamp with time zone,
    "denticonLastChangedOn" timestamp with time zone,
    nickname character varying(255),
    email character varying(255),
    address2 character varying(255),
    homephone character varying(255),
    workphone character varying(255),
    cellphone character varying(255),
    "mStatus" character varying(255),
    "chartNo" character varying(255),
    "firstVisitDate" timestamp with time zone,
    "lastVisitDate" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."Patients" OWNER TO postgres;

--
-- Name: COLUMN "Patients".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."Patients".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: PatientsAudit; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."PatientsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "officeId" bigint,
    "firstName" character varying(255),
    "lastName" character varying(255),
    "birthDate" timestamp with time zone,
    sex character varying(255),
    active boolean,
    address character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    "denticonCreatedOn" timestamp with time zone,
    "denticonLastChangedOn" timestamp with time zone,
    nickname character varying(255),
    email character varying(255),
    address2 character varying(255),
    homephone character varying(255),
    workphone character varying(255),
    cellphone character varying(255),
    "mStatus" character varying(255),
    "chartNo" character varying(255),
    "firstVisitDate" timestamp with time zone,
    "lastVisitDate" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."PatientsAudit" OWNER TO postgres;

--
-- Name: COLUMN "PatientsAudit"."integrationJobRunId"; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."PatientsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "Denticon"."Patients". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PatientsAudit".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."PatientsAudit".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: Providers; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."Providers" (
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "shortId" character varying(255),
    title character varying(255),
    "firstName" character varying(255),
    "lastName" character varying(255),
    "specialtyId" character varying(255),
    address character varying(255),
    address2 character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    email character varying(255),
    phone character varying(255),
    "providerType" character varying(255),
    active boolean,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."Providers" OWNER TO postgres;

--
-- Name: COLUMN "Providers".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."Providers".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: ProvidersAudit; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."ProvidersAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "shortId" character varying(255),
    title character varying(255),
    "firstName" character varying(255),
    "lastName" character varying(255),
    "specialtyId" character varying(255),
    address character varying(255),
    address2 character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    email character varying(255),
    phone character varying(255),
    "providerType" character varying(255),
    active boolean,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."ProvidersAudit" OWNER TO postgres;

--
-- Name: COLUMN "ProvidersAudit"."integrationJobRunId"; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."ProvidersAudit"."integrationJobRunId" IS 'This is the only additional column compared to "Denticon"."Providers". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "ProvidersAudit".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."ProvidersAudit".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: TreatmentPlans; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."TreatmentPlans" (
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "officeId" bigint,
    "providerId" bigint,
    "planNumber" bigint,
    "phaseId" bigint,
    "orderId" bigint,
    status character varying(255),
    "isVisible" boolean,
    "propDate" timestamp with time zone,
    "acceptedDate" timestamp with time zone,
    "scheduledDate" timestamp with time zone,
    "startDate" timestamp with time zone,
    "finishDate" timestamp with time zone,
    "isScheduled" boolean,
    "isCompleted" boolean,
    code character varying(255),
    "adaCode" character varying(255),
    description character varying(255),
    tooth character varying(255),
    surface character varying(255),
    fee bigint,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."TreatmentPlans" OWNER TO postgres;

--
-- Name: COLUMN "TreatmentPlans".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."TreatmentPlans".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: TreatmentPlansAudit; Type: TABLE; Schema: Denticon; Owner: postgres
--

CREATE TABLE "Denticon"."TreatmentPlansAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "practiceGroupId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "officeId" bigint,
    "providerId" bigint,
    "planNumber" bigint,
    "phaseId" bigint,
    "orderId" bigint,
    status character varying(255),
    "isVisible" boolean,
    "propDate" timestamp with time zone,
    "acceptedDate" timestamp with time zone,
    "scheduledDate" timestamp with time zone,
    "startDate" timestamp with time zone,
    "finishDate" timestamp with time zone,
    "isScheduled" boolean,
    "isCompleted" boolean,
    code character varying(255),
    "adaCode" character varying(255),
    description character varying(255),
    tooth character varying(255),
    surface character varying(255),
    fee bigint,
    "denticonCreatedOn" timestamp with time zone,
    "denticonModifiedOn" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Denticon"."TreatmentPlansAudit" OWNER TO postgres;

--
-- Name: COLUMN "TreatmentPlansAudit"."integrationJobRunId"; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."TreatmentPlansAudit"."integrationJobRunId" IS 'This is the only additional column compared to "Denticon"."TreatmentPlans". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "TreatmentPlansAudit".id; Type: COMMENT; Schema: Denticon; Owner: postgres
--

COMMENT ON COLUMN "Denticon"."TreatmentPlansAudit".id IS 'Does not auto-increment, instead carries Denticon''s native id';


--
-- Name: Appointments; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."Appointments" (
    id bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "operatoryId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "providerId" bigint NOT NULL,
    "ascendLastModified" timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    "statusId" integer NOT NULL,
    title character varying(255) NOT NULL,
    start timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    confirmed timestamp with time zone,
    "leftMessage" timestamp with time zone,
    "needsFollowup" boolean NOT NULL,
    "needsPremedicate" boolean NOT NULL,
    status "DentrixAscend"."enum_Appointments_status" NOT NULL,
    note text,
    "bookedOnline" boolean NOT NULL,
    "patientProcedures" jsonb,
    "practiceProcedures" jsonb,
    visits jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."Appointments" OWNER TO postgres;

--
-- Name: COLUMN "Appointments".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Appointments".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id';


--
-- Name: COLUMN "Appointments"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Appointments"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: AppointmentsAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."AppointmentsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "operatoryId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "providerId" bigint NOT NULL,
    "ascendLastModified" timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    "statusId" integer NOT NULL,
    title character varying(255) NOT NULL,
    start timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    confirmed timestamp with time zone,
    "leftMessage" timestamp with time zone,
    "needsFollowup" boolean NOT NULL,
    "needsPremedicate" boolean NOT NULL,
    status "DentrixAscend"."enum_AppointmentsAudit_status" NOT NULL,
    note text,
    "bookedOnline" boolean NOT NULL,
    "patientProcedures" jsonb,
    "practiceProcedures" jsonb,
    visits jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."AppointmentsAudit" OWNER TO postgres;

--
-- Name: COLUMN "AppointmentsAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."AppointmentsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixAscend"."PatientProcedures". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "AppointmentsAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."AppointmentsAudit".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id. This is the other 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "AppointmentsAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."AppointmentsAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: Operatories; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."Operatories" (
    id bigint NOT NULL,
    name character varying(255),
    "shortName" character varying(255) NOT NULL,
    active boolean NOT NULL,
    "locationId" bigint NOT NULL,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."Operatories" OWNER TO postgres;

--
-- Name: COLUMN "Operatories".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Operatories".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id';


--
-- Name: COLUMN "Operatories"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Operatories"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: OperatoriesAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."OperatoriesAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    name character varying(255),
    "shortName" character varying(255) NOT NULL,
    active boolean NOT NULL,
    "locationId" bigint NOT NULL,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."OperatoriesAudit" OWNER TO postgres;

--
-- Name: COLUMN "OperatoriesAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."OperatoriesAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixAscend"."Operatories". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "OperatoriesAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."OperatoriesAudit".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id. This is the other 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "OperatoriesAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."OperatoriesAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: PatientProcedures; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."PatientProcedures" (
    id bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "practiceProcedureId" bigint NOT NULL,
    "renderingProvider" bigint NOT NULL,
    "entryDate" date NOT NULL,
    "serviceDate" date NOT NULL,
    "ascendLastModified" timestamp with time zone NOT NULL,
    unlock boolean NOT NULL,
    amount numeric(10,2) NOT NULL,
    "billToInsurance" boolean NOT NULL,
    status "DentrixAscend"."enum_PatientProcedures_status" NOT NULL,
    state "DentrixAscend"."enum_PatientProcedures_state" NOT NULL,
    "autoCalculateEstimateEnabled" boolean,
    notes text,
    "treatmentPlannedDate" date,
    "procedureTeeth" jsonb,
    "insuranceClaims" jsonb,
    "patientConditions" jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."PatientProcedures" OWNER TO postgres;

--
-- Name: COLUMN "PatientProcedures".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientProcedures".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id';


--
-- Name: COLUMN "PatientProcedures"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientProcedures"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: PatientProceduresAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."PatientProceduresAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "locationId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "practiceProcedureId" bigint NOT NULL,
    "renderingProvider" bigint NOT NULL,
    "entryDate" date NOT NULL,
    "serviceDate" date NOT NULL,
    "ascendLastModified" timestamp with time zone NOT NULL,
    unlock boolean NOT NULL,
    amount numeric(10,2) NOT NULL,
    "billToInsurance" boolean NOT NULL,
    status "DentrixAscend"."enum_PatientProceduresAudit_status" NOT NULL,
    state "DentrixAscend"."enum_PatientProceduresAudit_state" NOT NULL,
    "autoCalculateEstimateEnabled" boolean,
    notes text,
    "treatmentPlannedDate" date,
    "procedureTeeth" json,
    "insuranceClaims" json,
    "patientConditions" json,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."PatientProceduresAudit" OWNER TO postgres;

--
-- Name: COLUMN "PatientProceduresAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientProceduresAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixAscend"."PatientProcedures". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PatientProceduresAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientProceduresAudit".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id. This is the other 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PatientProceduresAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientProceduresAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: Patients; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."Patients" (
    id bigint NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    gender "DentrixAscend".enum_generic_genders NOT NULL,
    "dateOfBirth" date NOT NULL,
    status "DentrixAscend"."enum_Patients_status" NOT NULL,
    "firstVisitDate" date,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    state "DentrixAscend".enum_generic_states,
    "postalCode" character varying(255),
    phones jsonb,
    email character varying(255),
    "contactMethod" "DentrixAscend"."enum_generic_contactMethods",
    "languageType" "DentrixAscend"."enum_generic_languageTypes" NOT NULL,
    "primaryContact" bigint,
    "primaryGuarantor" bigint,
    "preferredLocation" bigint,
    "primaryProvider" bigint,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."Patients" OWNER TO postgres;

--
-- Name: COLUMN "Patients".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Patients".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id';


--
-- Name: COLUMN "Patients"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Patients"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: PatientsAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."PatientsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    gender "DentrixAscend".enum_generic_genders NOT NULL,
    "dateOfBirth" date NOT NULL,
    status "DentrixAscend"."enum_PatientsAudit_status" NOT NULL,
    "firstVisitDate" date,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    state "DentrixAscend".enum_generic_states,
    "postalCode" character varying(255),
    phones jsonb,
    email character varying(255),
    "contactMethod" "DentrixAscend"."enum_generic_contactMethods",
    "languageType" "DentrixAscend"."enum_generic_languageTypes" NOT NULL,
    "primaryContact" bigint,
    "primaryGuarantor" bigint,
    "preferredLocation" bigint,
    "primaryProvider" bigint,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."PatientsAudit" OWNER TO postgres;

--
-- Name: COLUMN "PatientsAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixAscend"."PatientProcedures". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PatientsAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientsAudit".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id. This is the other 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PatientsAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PatientsAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: PracticeProcedures; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."PracticeProcedures" (
    id bigint NOT NULL,
    "adaCode" character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    "abbreviatedDescription" character varying(255) NOT NULL,
    category "DentrixAscend"."enum_PracticeProcedures_category" NOT NULL,
    "treatmentArea" "DentrixAscend"."enum_PracticeProcedures_treatmentArea" NOT NULL,
    fee numeric(10,2) NOT NULL,
    "isTreatmentInfoRequired" boolean NOT NULL,
    "codeVersion" integer NOT NULL,
    "chartingSymbol" character varying(255),
    favorite boolean NOT NULL,
    "billToInsurance" boolean NOT NULL,
    active boolean NOT NULL,
    "hasProsthesis" boolean NOT NULL,
    "aliasCode" character varying(255),
    "codeExtension" character varying(255),
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."PracticeProcedures" OWNER TO postgres;

--
-- Name: COLUMN "PracticeProcedures".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PracticeProcedures".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id';


--
-- Name: COLUMN "PracticeProcedures"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PracticeProcedures"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: PracticeProceduresAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."PracticeProceduresAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "adaCode" character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    "abbreviatedDescription" character varying(255) NOT NULL,
    category "DentrixAscend"."enum_PracticeProceduresAudit_category" NOT NULL,
    "treatmentArea" "DentrixAscend"."enum_PracticeProceduresAudit_treatmentArea" NOT NULL,
    fee numeric(10,2) NOT NULL,
    "isTreatmentInfoRequired" boolean NOT NULL,
    "codeVersion" integer NOT NULL,
    "chartingSymbol" character varying(255),
    favorite boolean NOT NULL,
    "billToInsurance" boolean NOT NULL,
    active boolean NOT NULL,
    "hasProsthesis" boolean NOT NULL,
    "aliasCode" character varying(255),
    "codeExtension" character varying(255),
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."PracticeProceduresAudit" OWNER TO postgres;

--
-- Name: COLUMN "PracticeProceduresAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PracticeProceduresAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixAscend"."PracticeProcedures". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PracticeProceduresAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PracticeProceduresAudit".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id. This is the other 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "PracticeProceduresAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."PracticeProceduresAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: ProductionCollections; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."ProductionCollections" (
    id integer NOT NULL,
    "locationId" bigint NOT NULL,
    "serviceDate" date NOT NULL,
    "locationName" character varying(255) NOT NULL,
    "serviceLocationId" bigint NOT NULL,
    "serviceLocationName" character varying(255) NOT NULL,
    "providerId" bigint NOT NULL,
    "providerName" character varying(255) NOT NULL,
    "transactionDate" date NOT NULL,
    "patientId" bigint NOT NULL,
    "patientName" character varying(255) NOT NULL,
    "primaryGuarantorId" bigint NOT NULL,
    "primaryGuarantorName" character varying(255) NOT NULL,
    "transactionCategory" character varying(255) NOT NULL,
    "transactionSubCategory" character varying(255) NOT NULL,
    "collectionProduction" character varying(255) NOT NULL,
    amount numeric(10,2) NOT NULL,
    "chartNumber" character varying(255),
    "insuranceCarrier" character varying(255),
    "insurancePlan" character varying(255),
    "patientLedgerId" bigint,
    "primaryProvider" character varying(255),
    "procedureCategory" character varying(255),
    "procedureCode" character varying(255),
    tags character varying(255),
    "transactionId" bigint,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."ProductionCollections" OWNER TO postgres;

--
-- Name: COLUMN "ProductionCollections".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProductionCollections".id IS 'Autoincremented instead of storing IDs from Dentrix Ascend directly';


--
-- Name: COLUMN "ProductionCollections"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProductionCollections"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: ProductionCollectionsAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."ProductionCollectionsAudit" (
    id integer NOT NULL,
    "integrationJobRunId" integer NOT NULL,
    "locationId" bigint NOT NULL,
    "serviceDate" date NOT NULL,
    "locationName" character varying(255) NOT NULL,
    "serviceLocationId" bigint NOT NULL,
    "serviceLocationName" character varying(255) NOT NULL,
    "providerId" bigint NOT NULL,
    "providerName" character varying(255) NOT NULL,
    "transactionDate" date NOT NULL,
    "patientId" bigint NOT NULL,
    "patientName" character varying(255) NOT NULL,
    "primaryGuarantorId" bigint NOT NULL,
    "primaryGuarantorName" character varying(255) NOT NULL,
    "transactionCategory" character varying(255) NOT NULL,
    "transactionSubCategory" character varying(255) NOT NULL,
    "collectionProduction" character varying(255) NOT NULL,
    amount numeric(10,2) NOT NULL,
    "chartNumber" character varying(255),
    "insuranceCarrier" character varying(255),
    "insurancePlan" character varying(255),
    "patientLedgerId" bigint,
    "primaryProvider" character varying(255),
    "procedureCategory" character varying(255),
    "procedureCode" character varying(255),
    tags character varying(255),
    "transactionId" bigint,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."ProductionCollectionsAudit" OWNER TO postgres;

--
-- Name: COLUMN "ProductionCollectionsAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProductionCollectionsAudit".id IS 'Autoincremented instead of storing IDs from Dentrix Ascend directly';


--
-- Name: COLUMN "ProductionCollectionsAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProductionCollectionsAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: ProductionCollectionsAudit_id_seq; Type: SEQUENCE; Schema: DentrixAscend; Owner: postgres
--

CREATE SEQUENCE "DentrixAscend"."ProductionCollectionsAudit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DentrixAscend"."ProductionCollectionsAudit_id_seq" OWNER TO postgres;

--
-- Name: ProductionCollectionsAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: DentrixAscend; Owner: postgres
--

ALTER SEQUENCE "DentrixAscend"."ProductionCollectionsAudit_id_seq" OWNED BY "DentrixAscend"."ProductionCollectionsAudit".id;


--
-- Name: ProductionCollections_id_seq; Type: SEQUENCE; Schema: DentrixAscend; Owner: postgres
--

CREATE SEQUENCE "DentrixAscend"."ProductionCollections_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DentrixAscend"."ProductionCollections_id_seq" OWNER TO postgres;

--
-- Name: ProductionCollections_id_seq; Type: SEQUENCE OWNED BY; Schema: DentrixAscend; Owner: postgres
--

ALTER SEQUENCE "DentrixAscend"."ProductionCollections_id_seq" OWNED BY "DentrixAscend"."ProductionCollections".id;


--
-- Name: Providers; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."Providers" (
    id bigint NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    "shortName" character varying(255) NOT NULL,
    title character varying(255),
    specialty "DentrixAscend"."enum_Providers_specialty" NOT NULL,
    address1 character varying(255) NOT NULL,
    address2 character varying(255),
    city character varying(255) NOT NULL,
    state "DentrixAscend".enum_generic_states NOT NULL,
    "postalCode" character varying(255) NOT NULL,
    active boolean NOT NULL,
    "isPrimaryProvider" boolean NOT NULL,
    "isNonPersonEntity" boolean NOT NULL,
    "signatureOnFile" boolean NOT NULL,
    "feeScheduleId" bigint,
    "insuranceCarriers" jsonb,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."Providers" OWNER TO postgres;

--
-- Name: COLUMN "Providers".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Providers".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id';


--
-- Name: COLUMN "Providers"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."Providers"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: ProvidersAudit; Type: TABLE; Schema: DentrixAscend; Owner: postgres
--

CREATE TABLE "DentrixAscend"."ProvidersAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    "shortName" character varying(255) NOT NULL,
    title character varying(255),
    specialty "DentrixAscend"."enum_ProvidersAudit_specialty" NOT NULL,
    address1 character varying(255) NOT NULL,
    address2 character varying(255),
    city character varying(255) NOT NULL,
    state "DentrixAscend".enum_generic_states NOT NULL,
    "postalCode" character varying(255) NOT NULL,
    active boolean NOT NULL,
    "isPrimaryProvider" boolean NOT NULL,
    "isNonPersonEntity" boolean NOT NULL,
    "signatureOnFile" boolean NOT NULL,
    "feeScheduleId" bigint,
    "insuranceCarriers" jsonb,
    "ascendLastModified" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "DentrixAscend"."ProvidersAudit" OWNER TO postgres;

--
-- Name: COLUMN "ProvidersAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProvidersAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixAscend"."Providers". It is 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "ProvidersAudit".id; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProvidersAudit".id IS 'Does not auto-increment, instead carries Dentrix Ascend''s native id. This is the other 1/2 of this table''s composite primary key.';


--
-- Name: COLUMN "ProvidersAudit"."ascendLastModified"; Type: COMMENT; Schema: DentrixAscend; Owner: postgres
--

COMMENT ON COLUMN "DentrixAscend"."ProvidersAudit"."ascendLastModified" IS 'Dentrix Ascend maintains its own updated timestamp, which is distinct from our own createdAt/updatedAt fields';


--
-- Name: Appointments; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."Appointments" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "appointmentId" integer NOT NULL,
    "practiceId" integer NOT NULL,
    "startHour" smallint,
    "modifiedDate" timestamp with time zone,
    "operatoryId" character varying(255),
    "providerId" character varying(255),
    broken boolean,
    "brokenDate" date,
    "patientId" integer,
    "patientName" character varying(255),
    "patientGuid" character varying(255),
    "patientPhone" character varying(255),
    "newpatientAddressId" integer,
    "statusId" smallint,
    amount numeric,
    "addtnlProviderId" character varying(255),
    followup smallint,
    "procedureCodes" jsonb,
    "createDate" date,
    "createdByUser" character varying(255),
    "originDate" character varying(255),
    reason character varying(255),
    "appointmentDate" character varying(255),
    length integer,
    "operatoryTitle" character varying(255)
);


ALTER TABLE "DentrixCore"."Appointments" OWNER TO postgres;

--
-- Name: COLUMN "Appointments"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Appointments"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "Appointments"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Appointments"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: AppointmentsAudit; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."AppointmentsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT '2023-04-25 18:05:17.213303+00'::timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT '2023-04-25 18:05:17.213303+00'::timestamp with time zone NOT NULL,
    "appointmentId" integer,
    "practiceId" integer NOT NULL,
    "startHour" smallint,
    "modifiedDate" timestamp with time zone,
    "operatoryId" character varying(255),
    "providerId" character varying(255),
    broken boolean,
    "brokenDate" date,
    "patientId" integer,
    "patientName" character varying(255),
    "patientGuid" character varying(255),
    "patientPhone" character varying(255),
    "newpatientAddressId" integer,
    "statusId" smallint,
    amount numeric,
    "addtnlProviderId" character varying(255),
    followup smallint,
    "procedureCodes" jsonb,
    "createDate" date,
    "createdByUser" character varying(255),
    "originDate" character varying(255),
    reason character varying(255),
    "appointmentDate" character varying(255),
    length integer,
    "operatoryTitle" character varying(255)
);


ALTER TABLE "DentrixCore"."AppointmentsAudit" OWNER TO postgres;

--
-- Name: Appointments_id_seq; Type: SEQUENCE; Schema: DentrixCore; Owner: postgres
--

CREATE SEQUENCE "DentrixCore"."Appointments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DentrixCore"."Appointments_id_seq" OWNER TO postgres;

--
-- Name: Appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: DentrixCore; Owner: postgres
--

ALTER SEQUENCE "DentrixCore"."Appointments_id_seq" OWNED BY "DentrixCore"."Appointments".id;


--
-- Name: Patients; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."Patients" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "patientId" integer NOT NULL,
    "practiceId" integer NOT NULL,
    "preferredName" character varying(255),
    "patientGuid" character varying(255),
    "lastName" character varying(255),
    "firstName" character varying(255),
    "middleInitial" character varying(255),
    gender smallint,
    title character varying(255),
    "guarantorId" integer,
    "guarantorGuid" character varying(255),
    "addressLine" character varying(255),
    city character varying(255),
    state character varying(255),
    zipcode character varying(255),
    "primaryProviderId" character varying(255),
    "secondaryProviderId" character varying(255),
    status smallint,
    "birthDate" character varying(255),
    "firstVistDate" character varying(255),
    "lastVisitDate" character varying(255),
    "lastMissedAppointment" character varying(255),
    "privacyFlags" smallint,
    "modifiedTimeStamp" character varying(255),
    "doNotBillInsFlag" boolean,
    email character varying(255),
    "employerId" integer,
    "insGroupName" character varying(255),
    "maxCoverageForPerson" integer,
    "maxCoverageForFamily" integer,
    "payorId" character varying(255),
    "primaryProviderLastName" character varying(255),
    "primaryProviderFirstName" character varying(255),
    "primaryInsuranceCarrierId" integer,
    "primaryInsuranceCarrierName" character varying(255),
    "secondaryProviderFirstName" character varying(255),
    "secondaryProviderLastName" character varying(255),
    "sourceOfPayment" character varying(255),
    "workPhone" character varying(255),
    "homePhone" character varying(255),
    "chartNum" character varying(255)
);


ALTER TABLE "DentrixCore"."Patients" OWNER TO postgres;

--
-- Name: COLUMN "Patients"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Patients"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "Patients"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Patients"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: PatientsAudit; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."PatientsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "patientId" integer NOT NULL,
    "practiceId" integer NOT NULL,
    "preferredName" character varying(255),
    "patientGuid" character varying(255),
    "lastName" character varying(255),
    "firstName" character varying(255),
    "middleInitial" character varying(255),
    gender smallint,
    title character varying(255),
    "guarantorId" integer,
    "guarantorGuid" character varying(255),
    "addressLine" character varying(255),
    city character varying(255),
    state character varying(255),
    zipcode character varying(255),
    "primaryProviderId" character varying(255),
    "secondaryProviderId" character varying(255),
    status smallint,
    "birthDate" character varying(255),
    "firstVistDate" character varying(255),
    "lastVisitDate" character varying(255),
    "lastMissedAppointment" character varying(255),
    "privacyFlags" smallint,
    "modifiedTimeStamp" character varying(255),
    "doNotBillInsFlag" boolean,
    email character varying(255),
    "employerId" integer,
    "insGroupName" character varying(255),
    "maxCoverageForPerson" integer,
    "maxCoverageForFamily" integer,
    "payorId" character varying(255),
    "primaryProviderLastName" character varying(255),
    "primaryProviderFirstName" character varying(255),
    "primaryInsuranceCarrierId" integer,
    "primaryInsuranceCarrierName" character varying(255),
    "secondaryProviderFirstName" character varying(255),
    "secondaryProviderLastName" character varying(255),
    "sourceOfPayment" character varying(255),
    "workPhone" character varying(255),
    "homePhone" character varying(255),
    "chartNum" character varying(255)
);


ALTER TABLE "DentrixCore"."PatientsAudit" OWNER TO postgres;

--
-- Name: COLUMN "PatientsAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."PatientsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixCore"."Appointments"';


--
-- Name: COLUMN "PatientsAudit".id; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."PatientsAudit".id IS 'Does not auto-increment. This is a reference to "id" in "DentrixCore"."Appointments"';


--
-- Name: COLUMN "PatientsAudit"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."PatientsAudit"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "PatientsAudit"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."PatientsAudit"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: Patients_id_seq; Type: SEQUENCE; Schema: DentrixCore; Owner: postgres
--

CREATE SEQUENCE "DentrixCore"."Patients_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DentrixCore"."Patients_id_seq" OWNER TO postgres;

--
-- Name: Patients_id_seq; Type: SEQUENCE OWNED BY; Schema: DentrixCore; Owner: postgres
--

ALTER SEQUENCE "DentrixCore"."Patients_id_seq" OWNED BY "DentrixCore"."Patients".id;


--
-- Name: Providers; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."Providers" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" integer NOT NULL,
    "providerId" character varying(255),
    "providerFirstName" character varying(255),
    "providerLastName" character varying(255),
    mi character varying(255),
    suffix character varying(255),
    "workPhone" character varying(255),
    "workPhoneExt" character varying(255),
    tin character varying(255),
    npi character varying(255),
    "addressLine1" character varying(255),
    "addressLine2" character varying(255),
    city character varying(255),
    state character varying(255),
    "zipCode" character varying(255),
    ssn character varying(255),
    "stateId" character varying(255),
    "medicaidId" character varying(255),
    "drugId" character varying(255),
    "isSecondaryProvider" boolean,
    "specialtyId" character varying(255),
    "blueCrossId" character varying(255),
    "isNonPerson" boolean,
    "isBlueShield" boolean,
    inactive boolean,
    "provNum" character varying(255),
    "otherId" character varying(255)
);


ALTER TABLE "DentrixCore"."Providers" OWNER TO postgres;

--
-- Name: COLUMN "Providers"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Providers"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "Providers"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Providers"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "Providers"."provNum"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Providers"."provNum" IS 'Described as Provider #';


--
-- Name: COLUMN "Providers"."otherId"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Providers"."otherId" IS 'Described as Other ID';


--
-- Name: ProvidersAudit; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."ProvidersAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" integer NOT NULL,
    "providerId" character varying(255),
    "providerFirstName" character varying(255),
    "providerLastName" character varying(255),
    mi character varying(255),
    suffix character varying(255),
    "workPhone" character varying(255),
    "workPhoneExt" character varying(255),
    tin character varying(255),
    npi character varying(255),
    "addressLine1" character varying(255),
    "addressLine2" character varying(255),
    city character varying(255),
    state character varying(255),
    "zipCode" character varying(255),
    ssn character varying(255),
    "stateId" character varying(255),
    "medicaidId" character varying(255),
    "drugId" character varying(255),
    "isSecondaryProvider" boolean,
    "specialtyId" character varying(255),
    "blueCrossId" character varying(255),
    "isNonPerson" boolean,
    "isBlueShield" boolean,
    inactive boolean,
    "provNum" character varying(255),
    "otherId" character varying(255)
);


ALTER TABLE "DentrixCore"."ProvidersAudit" OWNER TO postgres;

--
-- Name: COLUMN "ProvidersAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."ProvidersAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixCore"."Providers"';


--
-- Name: COLUMN "ProvidersAudit".id; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."ProvidersAudit".id IS 'Does not auto-increment. This is a reference to "id" in "DentrixCore"."Providers"';


--
-- Name: COLUMN "ProvidersAudit"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."ProvidersAudit"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "ProvidersAudit"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."ProvidersAudit"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "ProvidersAudit"."provNum"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."ProvidersAudit"."provNum" IS 'Described as Provider #';


--
-- Name: COLUMN "ProvidersAudit"."otherId"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."ProvidersAudit"."otherId" IS 'Described as Other ID';


--
-- Name: Providers_id_seq; Type: SEQUENCE; Schema: DentrixCore; Owner: postgres
--

CREATE SEQUENCE "DentrixCore"."Providers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DentrixCore"."Providers_id_seq" OWNER TO postgres;

--
-- Name: Providers_id_seq; Type: SEQUENCE OWNED BY; Schema: DentrixCore; Owner: postgres
--

ALTER SEQUENCE "DentrixCore"."Providers_id_seq" OWNED BY "DentrixCore"."Providers".id;


--
-- Name: Treatments; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."Treatments" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" integer NOT NULL,
    "treatmentId" integer NOT NULL,
    "patientId" integer,
    "patientFirstName" character varying(255),
    "patientLastName" character varying(255),
    "patientGuid" character varying(255),
    "procedureDate" character varying(255),
    "adaProcedureCode" character varying(255),
    "practiceProcedureCodeId" character varying(255),
    "treatmentCategory" character varying(255),
    "treatmentCategoryDescription" character varying(255),
    "appointmentId" character varying(255),
    amount numeric,
    "currencyCode" character varying(255),
    status character varying(255),
    "practicionerId" character varying(255),
    "surfaceString" character varying(255),
    surfm smallint,
    surfo boolean,
    surfd boolean,
    surff boolean,
    surfl boolean,
    surf5 boolean,
    "toothRangeStart" character varying(255),
    "toothRangeEnd" character varying(255),
    "providerId" character varying(255),
    "providerFirstName" character varying(255),
    "providerLastName" character varying(255),
    "completionDate" character varying(255),
    "diagnoseCode" character varying(255),
    "entryDate" character varying(255),
    "lastModifiedTimeStamp" character varying(255)
);


ALTER TABLE "DentrixCore"."Treatments" OWNER TO postgres;

--
-- Name: COLUMN "Treatments"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Treatments"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "Treatments"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."Treatments"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: TreatmentsAudit; Type: TABLE; Schema: DentrixCore; Owner: postgres
--

CREATE TABLE "DentrixCore"."TreatmentsAudit" (
    "integrationJobRunId" integer NOT NULL,
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" integer NOT NULL,
    "treatmentId" integer NOT NULL,
    "patientId" integer,
    "patientFirstName" character varying(255),
    "patientLastName" character varying(255),
    "patientGuid" character varying(255),
    "procedureDate" character varying(255),
    "adaProcedureCode" character varying(255),
    "practiceProcedureCodeId" character varying(255),
    "treatmentCategory" character varying(255),
    "treatmentCategoryDescription" character varying(255),
    "appointmentId" character varying(255),
    amount numeric,
    "currencyCode" character varying(255),
    status character varying(255),
    "practicionerId" character varying(255),
    "surfaceString" character varying(255),
    surfm smallint,
    surfo boolean,
    surfd boolean,
    surff boolean,
    surfl boolean,
    surf5 boolean,
    "toothRangeStart" character varying(255),
    "toothRangeEnd" character varying(255),
    "providerId" character varying(255),
    "providerFirstName" character varying(255),
    "providerLastName" character varying(255),
    "completionDate" character varying(255),
    "diagnoseCode" character varying(255),
    "entryDate" character varying(255),
    "lastModifiedTimeStamp" character varying(255)
);


ALTER TABLE "DentrixCore"."TreatmentsAudit" OWNER TO postgres;

--
-- Name: COLUMN "TreatmentsAudit"."integrationJobRunId"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."TreatmentsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "DentrixCore"."Treatments"';


--
-- Name: COLUMN "TreatmentsAudit".id; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."TreatmentsAudit".id IS 'Does not auto-increment. This is a reference to "id" in "DentrixCore"."Treatments"';


--
-- Name: COLUMN "TreatmentsAudit"."createdAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."TreatmentsAudit"."createdAt" IS 'This is a reference to our internal operations';


--
-- Name: COLUMN "TreatmentsAudit"."updatedAt"; Type: COMMENT; Schema: DentrixCore; Owner: postgres
--

COMMENT ON COLUMN "DentrixCore"."TreatmentsAudit"."updatedAt" IS 'This is a reference to our internal operations';


--
-- Name: Treatments_id_seq; Type: SEQUENCE; Schema: DentrixCore; Owner: postgres
--

CREATE SEQUENCE "DentrixCore"."Treatments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DentrixCore"."Treatments_id_seq" OWNER TO postgres;

--
-- Name: Treatments_id_seq; Type: SEQUENCE OWNED BY; Schema: DentrixCore; Owner: postgres
--

ALTER SEQUENCE "DentrixCore"."Treatments_id_seq" OWNED BY "DentrixCore"."Treatments".id;


--
-- Name: DDB_APPT_BASE; Type: TABLE; Schema: DentrixEnterprise11.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise11.0"."DDB_APPT_BASE" (
    "APPTID" integer NOT NULL,
    "APPTDB" integer NOT NULL,
    "PATID" integer,
    "PATDB" integer,
    "OPID" integer,
    "OPDB" integer,
    "PRPROVID" integer,
    "PRPROVDB" integer,
    "SCPROVID" integer,
    "SCPROVDB" integer,
    "NEWPATADDRESSID" integer,
    "NEWPATADDRESSDB" integer,
    "APPTDATE" timestamp with time zone,
    "SMALLAPPTID" smallint,
    "CLASS" integer,
    "PATNAME" character varying(255),
    "APPTLEN" integer,
    "AMOUNT" integer,
    "BROKENDATE" timestamp with time zone,
    "FLAG" integer,
    "PHONE" character varying(255),
    "APPTREASON" character varying(255),
    "TIME_HOUR" smallint,
    "TIME_MINUTE" smallint,
    "STATUS" integer,
    "APPTTYPE" integer,
    "TIMEBLOCK" integer,
    "FOLLOWUP" integer,
    "APPTCLASS" integer,
    "CREATEDATE" timestamp with time zone,
    "OPTYPE" integer,
    "PRPROVTYPE" integer,
    "SCPROVTYPE" integer,
    "PATTERN" character varying(255),
    "PROCCODEID" character varying(255),
    "PROCCODEDB" character varying(255),
    "PROCCODETYPE" character varying(255),
    "PREFNAME" character varying(255),
    "TITLE" character varying(255),
    "CHART" character varying(255),
    "WKPHONE" character varying(255),
    "HASAPPTNOTE" smallint,
    "HASMEDALERT" smallint,
    "PatAlert" smallint,
    "OPERATORID" integer,
    "OPERATORDB" integer,
    "DDB_LAST_MOD" timestamp with time zone,
    "LAST_VERIFIED_PRI" timestamp with time zone,
    "LAST_VERIFIED_SEC" timestamp with time zone,
    "PrivacyFlags" smallint,
    "AutoUpdateCC" smallint,
    "RVU" integer,
    "ReferralID" integer,
    "ReferralDB" integer,
    "ReferralType" smallint,
    "ApptExtID" character varying(255),
    "PatExtID" character varying(255),
    "EntrySystem" character varying(255),
    "LastUpdateMethod" character varying(255),
    "LastUpdateSystem" character varying(255),
    "VisitNumber" character varying(255),
    "OVERRIDEUSERID" character varying(255),
    "PermDescript" character varying(255),
    "LateFlag" smallint,
    "BROKENREASON" character varying(255),
    "LastUpdateOperatorID" integer,
    "LastUpdateOperatorDB" integer,
    "ApptStartUTCDateTime" timestamp with time zone,
    "ApptEndUTCDateTime" timestamp with time zone,
    "BirthDate" timestamp with time zone,
    "WasScheduled" smallint NOT NULL,
    "WasEnabledForEventsStatus" smallint NOT NULL,
    "MOBILEPHONE" character varying(255),
    "EMAILADDRESS" character varying(255),
    "EStatus" integer NOT NULL
);


ALTER TABLE "DentrixEnterprise11.0"."DDB_APPT_BASE" OWNER TO postgres;

--
-- Name: DDB_APPT_PROCCODE_BASE; Type: TABLE; Schema: DentrixEnterprise11.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise11.0"."DDB_APPT_PROCCODE_BASE" (
    "APPTPROCID" bigint NOT NULL,
    "APPTPROCDB" integer NOT NULL,
    "APPTID" integer,
    "APPTDB" integer NOT NULL,
    "PROCCODEID" integer,
    "PROCCODEDB" integer,
    "PROCCODETYPE" smallint,
    "DDB_LAST_MOD" timestamp with time zone NOT NULL
);


ALTER TABLE "DentrixEnterprise11.0"."DDB_APPT_PROCCODE_BASE" OWNER TO postgres;

--
-- Name: DDB_APPT_SCHEDULE_BASE; Type: TABLE; Schema: DentrixEnterprise11.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise11.0"."DDB_APPT_SCHEDULE_BASE" (
    "ApptScheduleID" integer NOT NULL,
    "ApptScheduleDB" integer NOT NULL,
    "ClinicId" integer NOT NULL,
    "ClinicDb" integer NOT NULL,
    "RscID" integer NOT NULL,
    "RscDB" integer NOT NULL,
    "RscType" integer NOT NULL,
    "RscDate" date NOT NULL,
    "ApptWeekDay" integer,
    "DayType" smallint NOT NULL,
    "TimeRange" smallint NOT NULL,
    "StartTime" time without time zone NOT NULL,
    "EndTime" time without time zone NOT NULL,
    "DDB_Last_Mod" timestamp with time zone NOT NULL,
    "Inactive" boolean NOT NULL
);


ALTER TABLE "DentrixEnterprise11.0"."DDB_APPT_SCHEDULE_BASE" OWNER TO postgres;

--
-- Name: DDB_PAT_BASE; Type: TABLE; Schema: DentrixEnterprise11.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise11.0"."DDB_PAT_BASE" (
    "PATID" integer NOT NULL,
    "PATDB" integer NOT NULL,
    "FAMILYID" integer NOT NULL,
    "GUARID" integer NOT NULL,
    "GUARDB" integer NOT NULL,
    "PRINSUREDID" integer,
    "PRINSUREDDB" integer,
    "SCINSUREDID" integer,
    "SCINSUREDDB" integer,
    "ADDRESSID" integer,
    "ADDRESSDB" integer,
    "EMPID" integer,
    "EMPDB" integer,
    "CLAIMINFID" integer,
    "CLAIMINFDB" integer,
    "PRPROVID" integer,
    "PRPROVDB" integer,
    "SCPROVID" integer,
    "SCPROVDB" integer,
    "REFTOID" integer,
    "REFTODB" integer,
    "REFBYDOCID" integer,
    "REFBYDOCDB" integer,
    "REFBYPATID" integer,
    "REFBYPATDB" integer,
    "PRMEDINSID" integer,
    "PRMEDINSDB" integer,
    "SCMEDINSID" integer,
    "SCMEDINSDB" integer,
    "LASTNAME" character varying(255),
    "FIRSTNAME" character varying(255),
    "PREFNAME" character varying(255),
    "SALUTATION" character varying(255),
    "WKEXT" character varying(255),
    "BESTTIME" character varying(255),
    "CHART" character varying(255),
    "CHARTDB" integer,
    "SS" character varying(255),
    "SSNDB" integer,
    "GUARFLG" smallint,
    "INSPFLG" smallint,
    "HEADHFLG" smallint,
    "GENDER" smallint,
    "STATUS" smallint,
    "FAMPOS" smallint,
    "PREMED" smallint,
    "BIRTHDATE" timestamp with time zone,
    "FIRSTVISITDATE" timestamp with time zone,
    "LASTVISITDATE" timestamp with time zone,
    "REFTODATE" timestamp with time zone,
    "CONSENTDATE" timestamp with time zone,
    "PRINSREL" smallint,
    "SCINSREL" smallint,
    "PRBENEFITS" integer,
    "SCBENEFITS" integer,
    "WKPHONE" character varying(255),
    "FEESCHFLAG" integer,
    "MISSEDAPPT" integer,
    "LASTMISSEDAPPT" timestamp with time zone,
    "TITLE" character varying(255),
    "ID2" character varying(255),
    "TITLEFLG" smallint,
    "EZDWPATID" integer,
    "EMAILADDRESS" character varying(255),
    "DRIVERSLICENSE" character varying(255),
    "FAX" character varying(255),
    "PAGER" character varying(255),
    "OTHERPHONE" character varying(255),
    "PRDED" integer,
    "PRDED2" integer,
    "PRDED3" integer,
    "SCDED" integer,
    "SCDED2" integer,
    "SCDED3" integer,
    "PRDEDUCTLT" integer,
    "PRDEDUCTLT2" integer,
    "PRDEDUCTLT3" integer,
    "SCDEDUCTLT" integer,
    "SCDEDUCTLT2" integer,
    "SCDEDUCTLT3" integer,
    "MEDALERT" character varying(255),
    "FEESCHEDID" integer,
    "FEESCHEDDB" integer,
    "PRMEDINSREL" smallint,
    "SCMEDINSREL" smallint,
    "PrInsCDADepCode" smallint,
    "ScInsCDADepCode" smallint,
    "ConsultFlag" smallint,
    "TOAFlag" smallint,
    "DefaultClinic" integer,
    "OperatorID" integer,
    "OperatorDB" integer,
    "UPLASTNAME" character varying(255),
    "UPFIRSTNAME" character varying(255),
    "UPCHART" character varying(255),
    "ACTIVE" smallint,
    "PATALERT" smallint,
    "Suffix" character varying(255),
    "CountyName" character varying(255),
    "EmpStatus" character varying(255),
    "Race" smallint,
    "FamIncome" integer,
    "ExternalStatus" character varying(255),
    "PatExtID" character varying(255),
    "GuarantorExtID" character varying(255),
    "EntrySystem" character varying(255),
    "EntryDateTime" timestamp with time zone,
    "LastUpdateMethod" character varying(255),
    "LastUpdateSystem" character varying(255),
    "VisitNumber" character varying(255),
    "PATIMAGEID" integer NOT NULL,
    "INITPROVID" integer,
    "INITPROVDB" integer,
    "RELIGION" smallint,
    "RVUID" integer,
    "RVUDB" integer,
    "MedHistoryViewDate" timestamp with time zone,
    "DDB_LAST_MOD" timestamp with time zone,
    "PatClass" character varying(255),
    "PatFacility" character varying(255),
    "PatAlias_LastName" character varying(255),
    "PatAlias_FirstName" character varying(255),
    "PatAlias_MiddleName" character varying(255),
    "PatAlias_Suffix" character varying(255),
    "PatAlias_Prefix" character varying(255),
    "MotherMaiden_LName" character varying(255),
    "MotherMaiden_FName" character varying(255),
    "MotherMaiden_MName" character varying(255),
    "MotherMaiden_Suffix" character varying(255),
    "MotherMaiden_Prefix" character varying(255),
    "PatientDeathDate" timestamp with time zone,
    "Language" smallint,
    "PovertyLevel" smallint,
    "WorkerStatus" smallint,
    "HomelessStatus" smallint,
    "PrivacyFlags" smallint,
    "PATCOPIED" smallint,
    "Veteran" smallint,
    "GUIDID" character varying(255),
    "TertDentInsuredID" integer,
    "TertDentInsuredDB" integer,
    "QuatDentInsuredID" integer,
    "QuatDentInsuredDB" integer,
    "TertInsRel" smallint,
    "QuatInsRel" smallint,
    "TertInsCDADepCode" smallint,
    "QuatInsCDADepCode" smallint,
    "OVERRIDEUSERID" character varying(255),
    "PermDescript" character varying(255),
    "EthnicityID" integer,
    "UDPatCatID" integer,
    "ExtPatIDType" character varying(255),
    "ExtGuarIDType" character varying(255),
    "PatExtID2" character varying(255),
    "ExtPatID2Type" character varying(255),
    "PatType" character varying(255),
    "AccountStatus" character varying(255),
    "FinancialClassID" smallint,
    "PatAccountNumber" character varying(255),
    "DeclinedEmail" integer,
    "CommunicationPref" smallint NOT NULL,
    "SmokingStatusID" integer,
    "SmokingStatusDB" integer,
    "RxAutoRefill" smallint,
    "OtherRace" smallint,
    "HousingStatus" smallint,
    "FamSize" integer,
    "SexualOrientation" integer,
    "GenderIdentity" integer,
    "HohIncome" integer,
    "IncomeRecurr" integer,
    "PATEXTIDTYPEID" integer,
    "PATEXTIDTYPEDB" integer,
    "CONFIDENTIAL_STATE" boolean NOT NULL,
    "MiddleName" character varying(255),
    "MI" character varying(255),
    "ConfidentialCodeID" integer,
    "ConfidentialCodeDB" integer,
    "OrganDonorCode" boolean,
    "VipCode" boolean NOT NULL,
    "SensitivityFlag" boolean NOT NULL,
    "BirthPlaceCountryID" integer,
    "BirthPlaceCountryDB" integer,
    "MultipleBirthFlag" boolean,
    "MultipleBirthOrder" smallint,
    "DNACode" boolean NOT NULL,
    "BloodTypeVerCode" character varying(255),
    "HOMEPHONE" character varying(255),
    "HOMEPHONEEXT" character varying(255),
    "WORKEMAIL" character varying(255),
    "OtherEthnicityId" integer,
    "NextOfKinID" integer,
    "NextOfKinDB" integer,
    "EmergencyID" integer,
    "EmergencyDB" integer,
    "GuardianID" integer,
    "GuardianDB" integer,
    "SponsorID" integer,
    "SponsorDB" integer,
    "CreationReasonID" integer,
    "DoDUpdateAuth" boolean NOT NULL,
    "DoDUpdateAuthText" character varying(255),
    "PrInsSubRel" smallint,
    "ScInsSubRel" smallint,
    "TertInsSubRel" smallint,
    "QuatInsSubRel" smallint,
    "PrMedInsSubRel" smallint,
    "ScMedInsSubRel" smallint,
    "InmateID" integer,
    "InmateDB" integer,
    "FamExtID" character varying(255),
    "OriginalPatId" integer,
    "OriginalPatDb" integer
);


ALTER TABLE "DentrixEnterprise11.0"."DDB_PAT_BASE" OWNER TO postgres;

--
-- Name: DDB_PROC_CODE_BASE; Type: TABLE; Schema: DentrixEnterprise11.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise11.0"."DDB_PROC_CODE_BASE" (
    "PROC_CODEID" integer NOT NULL,
    "PROC_CODEDB" integer NOT NULL,
    "ADACODE" character varying(255) NOT NULL,
    "CATEGORY" integer,
    "DESCRIPTION" character varying(255),
    "MINLEN" integer,
    "APPTTYPE" integer,
    "ALT1" character varying(255),
    "ALT2" character varying(255),
    "ALT3" character varying(255),
    "ALT4" character varying(255),
    "AUTORECALL" integer,
    "AUTORECALLDB" integer,
    "CHARTSHOW" integer,
    "CONDITION" smallint,
    "FOLLOWUP" smallint,
    "LABEXPENSE" integer,
    "MAPCODE1" character varying(255),
    "MAPCODE2" character varying(255),
    "MAPCODE3" character varying(255),
    "MAPCODE4" character varying(255),
    "MAPCODE5" character varying(255),
    "MAPSURFACES" integer,
    "MAT_EXPENSE" integer,
    "MOUTH_RANGE1" integer,
    "MOUTH_RANGE2" integer,
    "MTS_FLAG" smallint,
    "NOTE_TO_CLIN" integer,
    "NOTEKEY" integer,
    "NOTINSRELATED" integer,
    "PAINTCODE" integer,
    "PRINTNOTEONWALKOUT" integer,
    "REPLACE_TOOTH" integer,
    "RVU" integer,
    "VALIDTEETH" character varying(255),
    "MCENABLED" smallint,
    "MCPERM" smallint,
    "MCTYPE" smallint,
    "MCPASSVALUE" smallint,
    "MCNESTFLAG" smallint,
    "MCCURCODE" smallint,
    "MCINFOCOMPLETE" character varying(255),
    "MCINFO" character varying(255),
    "TIMEPATTERN" character varying(255),
    "MEDCROSSCODEFLAG" smallint,
    "DBI_FLAG" smallint,
    "DIAGNOSTICFLAG" smallint,
    "DIAGCODE" smallint,
    "TREATFLAG" smallint,
    "NOTE_APPEND_FLAG" smallint,
    "ANTCODE" character varying(255),
    "POSTCODE" character varying(255),
    "PRIMCODE" character varying(255),
    "PERMCODE" character varying(255),
    "DDB_LAST_MOD" timestamp with time zone,
    "Send_in_HL7" smallint,
    "LaymanDescript" character varying(255),
    "CompletedDateReqFlag" smallint,
    "PROVID" integer NOT NULL,
    "PROVDB" integer NOT NULL,
    "isDefProv" smallint NOT NULL,
    "MPROVID" integer NOT NULL,
    "MPROVDB" integer NOT NULL,
    "IsActive" boolean NOT NULL,
    "IsRequireUdi" boolean NOT NULL,
    "IsRequireAttachment" boolean NOT NULL,
    "IsApptWorkflowValidationNotRequired" boolean
);


ALTER TABLE "DentrixEnterprise11.0"."DDB_PROC_CODE_BASE" OWNER TO postgres;

--
-- Name: DDB_RSC_BASE; Type: TABLE; Schema: DentrixEnterprise11.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise11.0"."DDB_RSC_BASE" (
    "URSCID" integer NOT NULL,
    "RSCDB" integer NOT NULL,
    "RSCID" character varying(255) NOT NULL,
    "RSCTYPE" integer NOT NULL,
    "IDNUM" integer,
    "NAME_LAST" character varying(255),
    "NAME_FIRST" character varying(255),
    "NAME_INITIAL" character varying(255),
    "NAME_TITLE" character varying(255),
    "PRACTITLE" character varying(255),
    "STREET" character varying(255),
    "STREET2" character varying(255),
    "CITY" character varying(255),
    "STATE" character varying(255),
    "ZIP" character varying(255),
    "COUNTRY" character varying(255),
    "PHONE" character varying(255),
    "EXT" character varying(255),
    "SS" character varying(255),
    "STATEID" character varying(255),
    "ADA" character varying(255),
    "MEDICAID" character varying(255),
    "DRUGID" character varying(255),
    "CLASS" integer,
    "ECFUSER" integer,
    "CLAIMSIGN" integer,
    "STATEMENTINFO" smallint,
    "Unused1" integer,
    "DEPOSITSLIP" character varying(255),
    "CDAFEE1" integer,
    "CDAFEE2" integer,
    "CDAFEE3" integer,
    "CDAFEE4" integer,
    "CDAFEE5" integer,
    "ID1" character varying(255),
    "ID2" character varying(255),
    "ID3" character varying(255),
    "PROVIDERNUM" character varying(255),
    "OFFICENUM" character varying(255),
    "FEESCHID" integer,
    "FEESCHDB" integer,
    "RSCINFO" character varying(255),
    "ASSIGNRSC" character varying(255),
    "AsgnRscDB" character varying(255),
    "DefInstructorID" integer,
    "DefInstructorDB" integer,
    "StudentFlag" smallint,
    "DefaultClinic" integer,
    "UserLoginName" character varying(255),
    "RVUID" integer,
    "RVUDB" integer,
    "FinancialLocCode" character varying(255),
    "DDB_LAST_MOD" timestamp with time zone,
    "BILLINGPROVID" integer,
    "BILLINGPROVDB" integer,
    "MERCHANTID" character varying(255),
    "MedicareNum" character varying(255),
    "AdditionalID1" character varying(255),
    "AdditionalID2" character varying(255),
    "AdditionalID3" character varying(255),
    "RscExtID" character varying(255),
    "ActiveFlag" smallint,
    "EntrySystem" character varying(255),
    "EntryDateTime" timestamp with time zone,
    "LastUpdateMethod" character varying(255),
    "LastUpdateSystem" character varying(255),
    "UseClinicTin" smallint,
    "ID4" character varying(255),
    "AdminContactID" integer,
    "AdminContactDB" integer,
    "SpecialtyID" integer,
    "SpecialtyDB" integer,
    "IsNonPerson" smallint,
    "BlueState" smallint,
    "TRYNUM" integer,
    "LOCKOUTFLAG" integer,
    "PSWCHANGEDATE" timestamp with time zone,
    "LASTTRYDATE" timestamp with time zone,
    "OtherID" character varying(255),
    "HideSSN" boolean,
    "OVERRIDEUSERID" character varying(255),
    "PermDescript" character varying(255),
    "ProvCompleteOption" integer,
    "UPIN" character varying(255),
    "DeaSchedule2" smallint,
    "DeaSchedule3" smallint,
    "DeaSchedule4" smallint,
    "DeaSchedule5" smallint,
    "Suffix" character varying(255),
    "Email" character varying(255),
    "Fax" character varying(255),
    "DeaExpiration" timestamp with time zone,
    "StateLicenseState" character varying(255),
    "StateLicenseExpiration" timestamp with time zone,
    "TimeZoneID" integer,
    "ClinicNPI" character varying(255),
    "IsSetupOnPortal" smallint NOT NULL,
    "AllowMessaging" smallint NOT NULL,
    "AppRoleID" integer NOT NULL,
    "TimeZoneAbbreviation" smallint NOT NULL,
    "UserDomain" character varying(255),
    "RSCGUID" character varying(255)
);


ALTER TABLE "DentrixEnterprise11.0"."DDB_RSC_BASE" OWNER TO postgres;

--
-- Name: DDB_APPT_BASE; Type: TABLE; Schema: DentrixEnterprise8.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise8.0"."DDB_APPT_BASE" (
    "APPTID" integer NOT NULL,
    "APPTDB" integer NOT NULL,
    "PATID" integer,
    "PATDB" integer,
    "OPID" integer,
    "OPDB" integer,
    "PRPROVID" integer,
    "PRPROVDB" integer,
    "SCPROVID" integer,
    "SCPROVDB" integer,
    "NEWPATADDRESSID" integer,
    "NEWPATADDRESSDB" integer,
    "APPTDATE" timestamp with time zone,
    "SMALLAPPTID" smallint,
    "CLASS" integer,
    "PATNAME" character varying(255),
    "APPTLEN" integer,
    "AMOUNT" integer,
    "BROKENDATE" timestamp with time zone,
    "FLAG" integer,
    "PHONE" character varying(255),
    "APPTREASON" character varying(255),
    "TIME_HOUR" smallint,
    "TIME_MINUTE" smallint,
    "STATUS" integer,
    "APPTTYPE" integer,
    "TIMEBLOCK" integer,
    "FOLLOWUP" integer,
    "APPTCLASS" integer,
    "CREATEDATE" timestamp with time zone,
    "OPTYPE" integer,
    "PRPROVTYPE" integer,
    "SCPROVTYPE" integer,
    "PATTERN" character varying(255),
    "PROCCODEID" character varying(255),
    "PROCCODEDB" character varying(255),
    "PROCCODETYPE" character varying(255),
    "PREFNAME" character varying(255),
    "TITLE" character varying(255),
    "CHART" character varying(255),
    "WKPHONE" character varying(255),
    "HASAPPTNOTE" smallint,
    "HASMEDALERT" smallint,
    "PatAlert" smallint,
    "OPERATORID" integer,
    "OPERATORDB" integer,
    "DDB_LAST_MOD" timestamp with time zone,
    "LAST_VERIFIED_PRI" timestamp with time zone,
    "LAST_VERIFIED_SEC" timestamp with time zone,
    "PrivacyFlags" smallint,
    "AutoUpdateCC" smallint,
    "RVU" integer,
    "ReferralID" integer,
    "ReferralDB" integer,
    "ReferralType" smallint,
    "ApptExtID" character varying(255),
    "PatExtID" character varying(255),
    "EntrySystem" character varying(255),
    "LastUpdateMethod" character varying(255),
    "LastUpdateSystem" character varying(255),
    "VisitNumber" character varying(255),
    "OVERRIDEUSERID" character varying(255),
    "PermDescript" character varying(255),
    "LateFlag" smallint,
    "BROKENREASON" character varying(255),
    "LastUpdateOperatorID" integer,
    "LastUpdateOperatorDB" integer,
    "ApptStartUTCDateTime" timestamp with time zone,
    "ApptEndUTCDateTime" timestamp with time zone
);


ALTER TABLE "DentrixEnterprise8.0"."DDB_APPT_BASE" OWNER TO postgres;

--
-- Name: DDB_APPT_SCHEDULE_BASE; Type: TABLE; Schema: DentrixEnterprise8.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise8.0"."DDB_APPT_SCHEDULE_BASE" (
    "ApptScheduleID" integer NOT NULL,
    "ApptScheduleDB" integer NOT NULL,
    "ClinicId" integer NOT NULL,
    "ClinicDb" integer NOT NULL,
    "RscID" integer NOT NULL,
    "RscDB" integer NOT NULL,
    "RscType" integer NOT NULL,
    "RscDate" date NOT NULL,
    "ApptWeekDay" integer,
    "DayType" smallint NOT NULL,
    "TimeRange" smallint NOT NULL,
    "StartTime" time without time zone NOT NULL,
    "EndTime" time without time zone NOT NULL,
    "DDB_Last_Mod" timestamp with time zone NOT NULL
);


ALTER TABLE "DentrixEnterprise8.0"."DDB_APPT_SCHEDULE_BASE" OWNER TO postgres;

--
-- Name: DDB_PAT_BASE; Type: TABLE; Schema: DentrixEnterprise8.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise8.0"."DDB_PAT_BASE" (
    "PATID" integer NOT NULL,
    "PATDB" integer NOT NULL,
    "FAMILYID" integer NOT NULL,
    "GUARID" integer NOT NULL,
    "GUARDB" integer NOT NULL,
    "PRINSUREDID" integer,
    "PRINSUREDDB" integer,
    "SCINSUREDID" integer,
    "SCINSUREDDB" integer,
    "ADDRESSID" integer,
    "ADDRESSDB" integer,
    "EMPID" integer,
    "EMPDB" integer,
    "CLAIMINFID" integer,
    "CLAIMINFDB" integer,
    "PRPROVID" integer,
    "PRPROVDB" integer,
    "SCPROVID" integer,
    "SCPROVDB" integer,
    "REFTOID" integer,
    "REFTODB" integer,
    "REFBYDOCID" integer,
    "REFBYDOCDB" integer,
    "REFBYPATID" integer,
    "REFBYPATDB" integer,
    "PRMEDINSID" integer,
    "PRMEDINSDB" integer,
    "SCMEDINSID" integer,
    "SCMEDINSDB" integer,
    "LASTNAME" character varying(255),
    "FIRSTNAME" character varying(255),
    "PREFNAME" character varying(255),
    "SALUTATION" character varying(255),
    "WKEXT" character varying(255),
    "BESTTIME" character varying(255),
    "CHART" character varying(255),
    "CHARTDB" integer,
    "SS" character varying(255),
    "SSNDB" integer,
    "GUARFLG" smallint,
    "INSPFLG" smallint,
    "HEADHFLG" smallint,
    "GENDER" smallint,
    "STATUS" smallint,
    "FAMPOS" smallint,
    "PREMED" smallint,
    "BIRTHDATE" timestamp with time zone,
    "FIRSTVISITDATE" timestamp with time zone,
    "LASTVISITDATE" timestamp with time zone,
    "REFTODATE" timestamp with time zone,
    "CONSENTDATE" timestamp with time zone,
    "PRINSREL" smallint,
    "SCINSREL" smallint,
    "PRBENEFITS" integer,
    "SCBENEFITS" integer,
    "WKPHONE" character varying(255),
    "FEESCHFLAG" integer,
    "MISSEDAPPT" integer,
    "LASTMISSEDAPPT" timestamp with time zone,
    "TITLE" character varying(255),
    "ID2" character varying(255),
    "TITLEFLG" smallint,
    "EZDWPATID" integer,
    "EMAILADDRESS" character varying(255),
    "DRIVERSLICENSE" character varying(255),
    "FAX" character varying(255),
    "PAGER" character varying(255),
    "OTHERPHONE" character varying(255),
    "PRDED" integer,
    "PRDED2" integer,
    "PRDED3" integer,
    "SCDED" integer,
    "SCDED2" integer,
    "SCDED3" integer,
    "PRDEDUCTLT" integer,
    "PRDEDUCTLT2" integer,
    "PRDEDUCTLT3" integer,
    "SCDEDUCTLT" integer,
    "SCDEDUCTLT2" integer,
    "SCDEDUCTLT3" integer,
    "MEDALERT" character varying(255),
    "FEESCHEDID" integer,
    "FEESCHEDDB" integer,
    "PRMEDINSREL" smallint,
    "SCMEDINSREL" smallint,
    "PrInsCDADepCode" smallint,
    "ScInsCDADepCode" smallint,
    "ConsultFlag" smallint,
    "TOAFlag" smallint,
    "DefaultClinic" integer,
    "OperatorID" integer,
    "OperatorDB" integer,
    "UPLASTNAME" character varying(255),
    "UPFIRSTNAME" character varying(255),
    "UPCHART" character varying(255),
    "ACTIVE" smallint,
    "PATALERT" smallint,
    "Suffix" character varying(255),
    "CountyName" character varying(255),
    "EmpStatus" character varying(255),
    "Race" smallint,
    "FamIncome" integer,
    "ExternalStatus" character varying(255),
    "PatExtID" character varying(255),
    "GuarantorExtID" character varying(255),
    "EntrySystem" character varying(255),
    "EntryDateTime" timestamp with time zone,
    "LastUpdateMethod" character varying(255),
    "LastUpdateSystem" character varying(255),
    "VisitNumber" character varying(255),
    "PATIMAGEID" integer NOT NULL,
    "INITPROVID" integer,
    "INITPROVDB" integer,
    "RELIGION" smallint,
    "RVUID" integer,
    "RVUDB" integer,
    "MedHistoryViewDate" timestamp with time zone,
    "DDB_LAST_MOD" timestamp with time zone,
    "PatClass" character varying(255),
    "PatFacility" character varying(255),
    "PatAlias_LastName" character varying(255),
    "PatAlias_FirstName" character varying(255),
    "PatAlias_MiddleName" character varying(255),
    "PatAlias_Suffix" character varying(255),
    "PatAlias_Prefix" character varying(255),
    "MotherMaiden_LName" character varying(255),
    "MotherMaiden_FName" character varying(255),
    "MotherMaiden_MName" character varying(255),
    "MotherMaiden_Suffix" character varying(255),
    "MotherMaiden_Prefix" character varying(255),
    "PatientDeathDate" timestamp with time zone,
    "Language" smallint,
    "PovertyLevel" smallint,
    "WorkerStatus" smallint,
    "HomelessStatus" smallint,
    "PrivacyFlags" smallint,
    "PATCOPIED" smallint,
    "Veteran" smallint,
    "GUIDID" character varying(255),
    "TertDentInsuredID" integer,
    "TertDentInsuredDB" integer,
    "QuatDentInsuredID" integer,
    "QuatDentInsuredDB" integer,
    "TertInsRel" smallint,
    "QuatInsRel" smallint,
    "TertInsCDADepCode" smallint,
    "QuatInsCDADepCode" smallint,
    "OVERRIDEUSERID" character varying(255),
    "PermDescript" character varying(255),
    "EthnicityID" integer,
    "UDPatCatID" integer,
    "ExtPatIDType" character varying(255),
    "ExtGuarIDType" character varying(255),
    "PatExtID2" character varying(255),
    "ExtPatID2Type" character varying(255),
    "PatType" character varying(255),
    "AccountStatus" character varying(255),
    "FinancialClassID" smallint,
    "PatAccountNumber" character varying(255),
    "DeclinedEmail" integer,
    "CommunicationPref" smallint NOT NULL,
    "SmokingStatusID" integer,
    "SmokingStatusDB" integer,
    "RxAutoRefill" smallint,
    "OtherRace" smallint,
    "HousingStatus" smallint,
    "FamSize" integer,
    "SexualOrientation" integer,
    "GenderIdentity" integer,
    "HohIncome" integer,
    "IncomeRecurr" integer,
    "PATEXTIDTYPEID" integer,
    "PATEXTIDTYPEDB" integer,
    "CONFIDENTIAL_STATE" boolean NOT NULL,
    "MiddleName" character varying(255),
    "MI" character varying(255),
    "ConfidentialCodeID" integer,
    "ConfidentialCodeDB" integer,
    "OrganDonorCode" boolean,
    "VipCode" boolean NOT NULL,
    "SensitivityFlag" boolean NOT NULL,
    "BirthPlaceCountryID" integer,
    "BirthPlaceCountryDB" integer,
    "MultipleBirthFlag" boolean,
    "MultipleBirthOrder" smallint,
    "DNACode" boolean NOT NULL,
    "BloodTypeVerCode" character varying(255),
    "HOMEPHONE" character varying(255),
    "HOMEPHONEEXT" character varying(255),
    "WORKEMAIL" character varying(255),
    "OtherEthnicityId" integer,
    "NextOfKinID" integer,
    "NextOfKinDB" integer,
    "EmergencyID" integer,
    "EmergencyDB" integer,
    "GuardianID" integer,
    "GuardianDB" integer,
    "SponsorID" integer,
    "SponsorDB" integer,
    "CreationReasonID" integer,
    "DoDUpdateAuth" boolean NOT NULL,
    "DoDUpdateAuthText" character varying(255),
    "PrInsSubRel" smallint,
    "ScInsSubRel" smallint,
    "TertInsSubRel" smallint,
    "QuatInsSubRel" smallint,
    "PrMedInsSubRel" smallint,
    "ScMedInsSubRel" smallint,
    "InmateID" integer,
    "InmateDB" integer,
    "FamExtID" character varying(255)
);


ALTER TABLE "DentrixEnterprise8.0"."DDB_PAT_BASE" OWNER TO postgres;

--
-- Name: DDB_PROC_CODE_BASE; Type: TABLE; Schema: DentrixEnterprise8.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise8.0"."DDB_PROC_CODE_BASE" (
    "PROC_CODEID" integer NOT NULL,
    "PROC_CODEDB" integer NOT NULL,
    "ADACODE" character varying(255) NOT NULL,
    "CATEGORY" integer,
    "DESCRIPTION" character varying(255),
    "MINLEN" integer,
    "APPTTYPE" integer,
    "ALT1" character varying(255),
    "ALT2" character varying(255),
    "ALT3" character varying(255),
    "ALT4" character varying(255),
    "AUTORECALL" integer,
    "AUTORECALLDB" integer,
    "CHARTSHOW" integer,
    "CONDITION" smallint,
    "FOLLOWUP" smallint,
    "LABEXPENSE" integer,
    "MAPCODE1" character varying(255),
    "MAPCODE2" character varying(255),
    "MAPCODE3" character varying(255),
    "MAPCODE4" character varying(255),
    "MAPCODE5" character varying(255),
    "MAPSURFACES" integer,
    "MAT_EXPENSE" integer,
    "MOUTH_RANGE1" integer,
    "MOUTH_RANGE2" integer,
    "MTS_FLAG" smallint,
    "NOTE_TO_CLIN" integer,
    "NOTEKEY" integer,
    "NOTINSRELATED" integer,
    "PAINTCODE" integer,
    "PRINTNOTEONWALKOUT" integer,
    "REPLACE_TOOTH" integer,
    "RVU" integer,
    "VALIDTEETH" character varying(255),
    "MCENABLED" smallint,
    "MCPERM" smallint,
    "MCTYPE" smallint,
    "MCPASSVALUE" smallint,
    "MCNESTFLAG" smallint,
    "MCCURCODE" smallint,
    "MCINFOCOMPLETE" character varying(255),
    "MCINFO" character varying(255),
    "TIMEPATTERN" character varying(255),
    "MEDCROSSCODEFLAG" smallint,
    "DBI_FLAG" smallint,
    "DIAGNOSTICFLAG" smallint,
    "DIAGCODE" smallint,
    "TREATFLAG" smallint,
    "NOTE_APPEND_FLAG" smallint,
    "ANTCODE" character varying(255),
    "POSTCODE" character varying(255),
    "PRIMCODE" character varying(255),
    "PERMCODE" character varying(255),
    "DDB_LAST_MOD" timestamp with time zone,
    "Send_in_HL7" smallint,
    "LaymanDescript" character varying(255),
    "CompletedDateReqFlag" smallint,
    "PROVID" integer NOT NULL,
    "PROVDB" integer NOT NULL,
    "isDefProv" smallint NOT NULL,
    "MPROVID" integer NOT NULL,
    "MPROVDB" integer NOT NULL
);


ALTER TABLE "DentrixEnterprise8.0"."DDB_PROC_CODE_BASE" OWNER TO postgres;

--
-- Name: DDB_RSC_BASE; Type: TABLE; Schema: DentrixEnterprise8.0; Owner: postgres
--

CREATE TABLE "DentrixEnterprise8.0"."DDB_RSC_BASE" (
    "URSCID" integer NOT NULL,
    "RSCDB" integer NOT NULL,
    "RSCID" character varying(255) NOT NULL,
    "RSCTYPE" integer NOT NULL,
    "IDNUM" integer,
    "NAME_LAST" character varying(255),
    "NAME_FIRST" character varying(255),
    "NAME_INITIAL" character varying(255),
    "NAME_TITLE" character varying(255),
    "PRACTITLE" character varying(255),
    "STREET" character varying(255),
    "STREET2" character varying(255),
    "CITY" character varying(255),
    "STATE" character varying(255),
    "ZIP" character varying(255),
    "COUNTRY" character varying(255),
    "PHONE" character varying(255),
    "EXT" character varying(255),
    "SS" character varying(255),
    "STATEID" character varying(255),
    "ADA" character varying(255),
    "MEDICAID" character varying(255),
    "DRUGID" character varying(255),
    "CLASS" integer,
    "ECFUSER" integer,
    "CLAIMSIGN" integer,
    "STATEMENTINFO" smallint,
    "Unused1" integer,
    "DEPOSITSLIP" character varying(255),
    "CDAFEE1" integer,
    "CDAFEE2" integer,
    "CDAFEE3" integer,
    "CDAFEE4" integer,
    "CDAFEE5" integer,
    "ID1" character varying(255),
    "ID2" character varying(255),
    "ID3" character varying(255),
    "PROVIDERNUM" character varying(255),
    "OFFICENUM" character varying(255),
    "FEESCHID" integer,
    "FEESCHDB" integer,
    "RSCINFO" character varying(255),
    "ASSIGNRSC" character varying(255),
    "AsgnRscDB" character varying(255),
    "DefInstructorID" integer,
    "DefInstructorDB" integer,
    "StudentFlag" smallint,
    "DefaultClinic" integer,
    "UserLoginName" character varying(255),
    "RVUID" integer,
    "RVUDB" integer,
    "FinancialLocCode" character varying(255),
    "DDB_LAST_MOD" timestamp with time zone,
    "BILLINGPROVID" integer,
    "BILLINGPROVDB" integer,
    "MERCHANTID" character varying(255),
    "MedicareNum" character varying(255),
    "AdditionalID1" character varying(255),
    "AdditionalID2" character varying(255),
    "AdditionalID3" character varying(255),
    "RscExtID" character varying(255),
    "ActiveFlag" smallint,
    "EntrySystem" character varying(255),
    "EntryDateTime" timestamp with time zone,
    "LastUpdateMethod" character varying(255),
    "LastUpdateSystem" character varying(255),
    "UseClinicTin" smallint,
    "ID4" character varying(255),
    "AdminContactID" integer,
    "AdminContactDB" integer,
    "SpecialtyID" integer,
    "SpecialtyDB" integer,
    "IsNonPerson" smallint,
    "BlueState" smallint,
    "TRYNUM" integer,
    "LOCKOUTFLAG" integer,
    "PSWCHANGEDATE" timestamp with time zone,
    "LASTTRYDATE" timestamp with time zone,
    "OtherID" character varying(255),
    "HideSSN" boolean,
    "OVERRIDEUSERID" character varying(255),
    "PermDescript" character varying(255),
    "ProvCompleteOption" integer,
    "UPIN" character varying(255),
    "DeaSchedule2" smallint,
    "DeaSchedule3" smallint,
    "DeaSchedule4" smallint,
    "DeaSchedule5" smallint,
    "Suffix" character varying(255),
    "Email" character varying(255),
    "Fax" character varying(255),
    "DeaExpiration" timestamp with time zone,
    "StateLicenseState" character varying(255),
    "StateLicenseExpiration" timestamp with time zone,
    "TimeZoneID" integer,
    "ClinicNPI" character varying(255),
    "IsSetupOnPortal" smallint NOT NULL,
    "AllowMessaging" smallint NOT NULL,
    "AppRoleID" integer NOT NULL,
    "TimeZoneAbbreviation" smallint NOT NULL,
    "UserDomain" character varying(255)
);


ALTER TABLE "DentrixEnterprise8.0"."DDB_RSC_BASE" OWNER TO postgres;

--
-- Name: AnonymizedImageMetadata; Type: TABLE; Schema: NonPhi; Owner: postgres
--

CREATE TABLE "NonPhi"."AnonymizedImageMetadata" (
    id integer NOT NULL,
    "patientSex" character varying(255),
    manufacturer character varying(255),
    "manufacturerModelName" character varying(255),
    "deviceSerialNumber" character varying(255),
    "softwareVersions" character varying(255),
    "imageAcquisitionDate" character varying(255),
    "patientAge" integer,
    "bitsAllocated" integer,
    height integer,
    width integer,
    "imageType" character varying(255),
    modality character varying(255),
    "operatorsName" character varying(255),
    "otherPatientIDs" character varying(255),
    "patientId" character varying(255),
    "patientName" character varying(255),
    "patientFirstName" character varying(255),
    "patientLastName" character varying(255),
    "patientOrientation" character varying(255),
    "patientPosition" character varying(255),
    "sopClassUID" character varying(255),
    "sopInstanceUID" character varying(255),
    "seriesInstanceUID" character varying(255),
    "institutionName" character varying(255),
    "imageManifestId" integer NOT NULL,
    "phiImageMetadataId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "chartNum" character varying(255)
);


ALTER TABLE "NonPhi"."AnonymizedImageMetadata" OWNER TO postgres;

--
-- Name: AnonymizedImageMetadata_id_seq; Type: SEQUENCE; Schema: NonPhi; Owner: postgres
--

CREATE SEQUENCE "NonPhi"."AnonymizedImageMetadata_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "NonPhi"."AnonymizedImageMetadata_id_seq" OWNER TO postgres;

--
-- Name: AnonymizedImageMetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: NonPhi; Owner: postgres
--

ALTER SEQUENCE "NonPhi"."AnonymizedImageMetadata_id_seq" OWNED BY "NonPhi"."AnonymizedImageMetadata".id;


--
-- Name: FolderHashToChartNum; Type: TABLE; Schema: NonPhi; Owner: postgres
--

CREATE TABLE "NonPhi"."FolderHashToChartNum" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "chartNum" character varying(255) NOT NULL,
    "extractedFolderPath" character varying(255) NOT NULL,
    "folderHash" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE "NonPhi"."FolderHashToChartNum" OWNER TO postgres;

--
-- Name: ImageManifests; Type: TABLE; Schema: NonPhi; Owner: postgres
--

CREATE TABLE "NonPhi"."ImageManifests" (
    id integer NOT NULL,
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "patientId" integer,
    "phiRemotePath" text,
    source character varying(255) NOT NULL,
    "fileContentHash" character varying(255) NOT NULL,
    "fileName" character varying(255) NOT NULL,
    "inferredImageType" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "imageAcquiredAt" timestamp with time zone,
    "heightPx" integer,
    "widthPx" integer,
    "s3Paths" jsonb,
    "phiRemotePathVersion" character varying(255),
    "s3ResultsPath" text,
    "estimatedVisitId" integer,
    "imagePixelHash" text
);


ALTER TABLE "NonPhi"."ImageManifests" OWNER TO postgres;

--
-- Name: COLUMN "ImageManifests"."patientId"; Type: COMMENT; Schema: NonPhi; Owner: postgres
--

COMMENT ON COLUMN "NonPhi"."ImageManifests"."patientId" IS 'Patient null means we could not extract the metadata from file';


--
-- Name: ImageManifests_id_seq; Type: SEQUENCE; Schema: NonPhi; Owner: postgres
--

CREATE SEQUENCE "NonPhi"."ImageManifests_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "NonPhi"."ImageManifests_id_seq" OWNER TO postgres;

--
-- Name: ImageManifests_id_seq; Type: SEQUENCE OWNED BY; Schema: NonPhi; Owner: postgres
--

ALTER SEQUENCE "NonPhi"."ImageManifests_id_seq" OWNED BY "NonPhi"."ImageManifests".id;


--
-- Name: Appointments; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."Appointments" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "AptNum" character varying(255) NOT NULL,
    "PatNum" character varying(255) NOT NULL,
    "AptStatus" character varying(255),
    "Pattern" character varying(255),
    "ConfirmedCode" character varying(255),
    "ConfirmedDescription" character varying(255),
    "Op" character varying(255),
    "Note" text,
    "ProvNum" character varying(255),
    "provAbbr" character varying(255),
    "ProvHyg" character varying(255),
    "AptDateTime" character varying(255),
    "IsNewPatient" character varying(255),
    "ProcDescript" character varying(255),
    "ClinicNum" character varying(255),
    "IsHygiene" character varying(255),
    "DateTStamp" character varying(255),
    "Priority" character varying(255),
    "AppointmentTypeNum" character varying(255)
);


ALTER TABLE "OpenDental"."Appointments" OWNER TO postgres;

--
-- Name: AppointmentsAudit; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."AppointmentsAudit" (
    id bigint NOT NULL,
    "integrationJobRunId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "AptNum" character varying(255) NOT NULL,
    "PatNum" character varying(255) NOT NULL,
    "AptStatus" character varying(255),
    "Pattern" character varying(255),
    "ConfirmedCode" character varying(255),
    "ConfirmedDescription" character varying(255),
    "Op" character varying(255),
    "Note" text,
    "ProvNum" character varying(255),
    "provAbbr" character varying(255),
    "ProvHyg" character varying(255),
    "AptDateTime" character varying(255),
    "IsNewPatient" character varying(255),
    "ProcDescript" character varying(255),
    "ClinicNum" character varying(255),
    "IsHygiene" character varying(255),
    "DateTStamp" character varying(255),
    "Priority" character varying(255),
    "AppointmentTypeNum" character varying(255)
);


ALTER TABLE "OpenDental"."AppointmentsAudit" OWNER TO postgres;

--
-- Name: COLUMN "AppointmentsAudit"."integrationJobRunId"; Type: COMMENT; Schema: OpenDental; Owner: postgres
--

COMMENT ON COLUMN "OpenDental"."AppointmentsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "OpenDental"."Appointments".';


--
-- Name: AppointmentsAudit_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."AppointmentsAudit_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."AppointmentsAudit_id_seq" OWNER TO postgres;

--
-- Name: AppointmentsAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."AppointmentsAudit_id_seq" OWNED BY "OpenDental"."AppointmentsAudit".id;


--
-- Name: Appointments_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."Appointments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."Appointments_id_seq" OWNER TO postgres;

--
-- Name: Appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."Appointments_id_seq" OWNED BY "OpenDental"."Appointments".id;


--
-- Name: Operatories; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."Operatories" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "OperatoryNum" character varying(255) NOT NULL,
    "OpName" character varying(255),
    "Abbrev" character varying(255),
    "ItemOrder" integer,
    "IsHidden" boolean,
    "ProvDentist" character varying(255),
    "ProvHygienist" character varying(255),
    "IsHygiene" boolean,
    "ClinicNum" character varying(255),
    "SetProspective" boolean,
    "IsWebSched" boolean
);


ALTER TABLE "OpenDental"."Operatories" OWNER TO postgres;

--
-- Name: OperatoriesAudit; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."OperatoriesAudit" (
    id bigint NOT NULL,
    "integrationJobRunId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "OperatoryNum" character varying(255) NOT NULL,
    "OpName" character varying(255),
    "Abbrev" character varying(255),
    "ItemOrder" integer,
    "IsHidden" boolean,
    "ProvDentist" character varying(255),
    "ProvHygienist" character varying(255),
    "IsHygiene" boolean,
    "ClinicNum" character varying(255),
    "SetProspective" boolean,
    "IsWebSched" boolean
);


ALTER TABLE "OpenDental"."OperatoriesAudit" OWNER TO postgres;

--
-- Name: COLUMN "OperatoriesAudit"."integrationJobRunId"; Type: COMMENT; Schema: OpenDental; Owner: postgres
--

COMMENT ON COLUMN "OpenDental"."OperatoriesAudit"."integrationJobRunId" IS 'This is the only additional column compared to "OpenDental"."Operatories".';


--
-- Name: OperatoriesAudit_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."OperatoriesAudit_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."OperatoriesAudit_id_seq" OWNER TO postgres;

--
-- Name: OperatoriesAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."OperatoriesAudit_id_seq" OWNED BY "OpenDental"."OperatoriesAudit".id;


--
-- Name: Operatories_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."Operatories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."Operatories_id_seq" OWNER TO postgres;

--
-- Name: Operatories_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."Operatories_id_seq" OWNED BY "OpenDental"."Operatories".id;


--
-- Name: Patients; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."Patients" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "PatNum" character varying(255) NOT NULL,
    "LName" character varying(255),
    "FName" character varying(255),
    "MiddleI" character varying(255),
    "Preferred" character varying(255),
    "PatStatus" character varying(255),
    "Gender" character varying(255),
    "Position" character varying(255),
    "Birthdate" character varying(255),
    "SSN" character varying(255),
    "Address" character varying(255),
    "Address2" character varying(255),
    "City" character varying(255),
    "State" character varying(255),
    "Zip" character varying(255),
    "HmPhone" character varying(255),
    "WkPhone" character varying(255),
    "WirelessPhone" character varying(255),
    "Guarantor" character varying(255),
    "Email" character varying(255),
    "EstBalance" double precision,
    "PriProv" character varying(255),
    "priProvAbbr" character varying(255),
    "SecProv" character varying(255),
    "secProvAbbr" character varying(255),
    "BillingType" character varying(255),
    "ImageFolder" character varying(255),
    "ChartNumber" character varying(255),
    "MedicaidID" character varying(255),
    "BalTotal" double precision,
    "DateFirstVisit" character varying(255),
    "ClinicNum" character varying(255),
    "clinicAbbr" character varying(255),
    "PreferConfirmMethod" character varying(255),
    "PreferContactMethod" character varying(255),
    "PreferRecallMethod" character varying(255),
    "Language" character varying(255),
    "siteDesc" character varying(255),
    "DateTStamp" character varying(255),
    "TxtMsgOk" character varying(255)
);


ALTER TABLE "OpenDental"."Patients" OWNER TO postgres;

--
-- Name: PatientsAudit; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."PatientsAudit" (
    id bigint NOT NULL,
    "integrationJobRunId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "PatNum" character varying(255) NOT NULL,
    "LName" character varying(255),
    "FName" character varying(255),
    "MiddleI" character varying(255),
    "Preferred" character varying(255),
    "PatStatus" character varying(255),
    "Gender" character varying(255),
    "Position" character varying(255),
    "Birthdate" character varying(255),
    "SSN" character varying(255),
    "Address" character varying(255),
    "Address2" character varying(255),
    "City" character varying(255),
    "State" character varying(255),
    "Zip" character varying(255),
    "HmPhone" character varying(255),
    "WkPhone" character varying(255),
    "WirelessPhone" character varying(255),
    "Guarantor" character varying(255),
    "Email" character varying(255),
    "EstBalance" double precision,
    "PriProv" character varying(255),
    "priProvAbbr" character varying(255),
    "SecProv" character varying(255),
    "secProvAbbr" character varying(255),
    "BillingType" character varying(255),
    "ImageFolder" character varying(255),
    "ChartNumber" character varying(255),
    "MedicaidID" character varying(255),
    "BalTotal" double precision,
    "DateFirstVisit" character varying(255),
    "ClinicNum" character varying(255),
    "clinicAbbr" character varying(255),
    "PreferConfirmMethod" character varying(255),
    "PreferContactMethod" character varying(255),
    "PreferRecallMethod" character varying(255),
    "Language" character varying(255),
    "siteDesc" character varying(255),
    "DateTStamp" character varying(255),
    "TxtMsgOk" character varying(255)
);


ALTER TABLE "OpenDental"."PatientsAudit" OWNER TO postgres;

--
-- Name: COLUMN "PatientsAudit"."integrationJobRunId"; Type: COMMENT; Schema: OpenDental; Owner: postgres
--

COMMENT ON COLUMN "OpenDental"."PatientsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "OpenDental"."Patients".';


--
-- Name: PatientsAudit_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."PatientsAudit_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."PatientsAudit_id_seq" OWNER TO postgres;

--
-- Name: PatientsAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."PatientsAudit_id_seq" OWNED BY "OpenDental"."PatientsAudit".id;


--
-- Name: Patients_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."Patients_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."Patients_id_seq" OWNER TO postgres;

--
-- Name: Patients_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."Patients_id_seq" OWNED BY "OpenDental"."Patients".id;


--
-- Name: ProcedureLogs; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."ProcedureLogs" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "ProcNum" character varying(255) NOT NULL,
    "PatNum" character varying(255) NOT NULL,
    "AptNum" character varying(255),
    "ProcDate" date NOT NULL,
    "ProcFee" numeric(10,2),
    "Surf" character varying(255),
    "ToothNum" character varying(255),
    "ToothRange" character varying(255),
    "Priority" character varying(255) NOT NULL,
    priority character varying(255),
    "ProcStatus" character varying(255),
    "ProvNum" character varying(255),
    "provAbbr" character varying(255),
    "Dx" character varying(255),
    "dxName" character varying(255),
    "PlannedAptNum" character varying(255),
    "ClinicNum" character varying(255),
    "CodeNum" character varying(255),
    "procCode" character varying(255),
    descript character varying(255),
    "UnitQty" integer,
    "BaseUnits" integer,
    "DateTStamp" timestamp with time zone
);


ALTER TABLE "OpenDental"."ProcedureLogs" OWNER TO postgres;

--
-- Name: ProcedureLogsAudit; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."ProcedureLogsAudit" (
    id bigint NOT NULL,
    "integrationJobRunId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "ProcNum" character varying(255) NOT NULL,
    "PatNum" character varying(255) NOT NULL,
    "AptNum" character varying(255),
    "ProcDate" date NOT NULL,
    "ProcFee" numeric(10,2),
    "Surf" character varying(255),
    "ToothNum" character varying(255),
    "ToothRange" character varying(255),
    "Priority" character varying(255) NOT NULL,
    priority character varying(255),
    "ProcStatus" character varying(255),
    "ProvNum" character varying(255),
    "provAbbr" character varying(255),
    "Dx" character varying(255),
    "dxName" character varying(255),
    "PlannedAptNum" character varying(255),
    "ClinicNum" character varying(255),
    "CodeNum" character varying(255),
    "procCode" character varying(255),
    descript character varying(255),
    "UnitQty" integer,
    "BaseUnits" integer,
    "DateTStamp" timestamp with time zone
);


ALTER TABLE "OpenDental"."ProcedureLogsAudit" OWNER TO postgres;

--
-- Name: COLUMN "ProcedureLogsAudit"."integrationJobRunId"; Type: COMMENT; Schema: OpenDental; Owner: postgres
--

COMMENT ON COLUMN "OpenDental"."ProcedureLogsAudit"."integrationJobRunId" IS 'This is the only additional column compared to "OpenDental"."Patients".';


--
-- Name: ProcedureLogsAudit_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."ProcedureLogsAudit_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."ProcedureLogsAudit_id_seq" OWNER TO postgres;

--
-- Name: ProcedureLogsAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."ProcedureLogsAudit_id_seq" OWNED BY "OpenDental"."ProcedureLogsAudit".id;


--
-- Name: ProcedureLogs_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."ProcedureLogs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."ProcedureLogs_id_seq" OWNER TO postgres;

--
-- Name: ProcedureLogs_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."ProcedureLogs_id_seq" OWNED BY "OpenDental"."ProcedureLogs".id;


--
-- Name: Providers; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."Providers" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "ProvNum" character varying(255) NOT NULL,
    "Abbr" character varying(255),
    "LName" character varying(255),
    "FName" character varying(255),
    "MI" character varying(255),
    "Suffix" character varying(255),
    "FeeSched" character varying(255),
    "Specialty" character varying(255),
    "SSN" character varying(255),
    "IsSecondary" boolean,
    "IsHidden" boolean,
    "UsingTIN" boolean,
    "DateTStamp" character varying(255),
    "IsNotPerson" boolean,
    "IsHiddenReport" boolean,
    "Birthdate" character varying(255),
    "SchedNote" character varying(255),
    "PreferredName" character varying(255),
    "provColor" character varying(255),
    "NationalProvID" character varying(255),
    "StateLicense" character varying(255)
);


ALTER TABLE "OpenDental"."Providers" OWNER TO postgres;

--
-- Name: ProvidersAudit; Type: TABLE; Schema: OpenDental; Owner: postgres
--

CREATE TABLE "OpenDental"."ProvidersAudit" (
    id bigint NOT NULL,
    "integrationJobRunId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "ProvNum" character varying(255) NOT NULL,
    "Abbr" character varying(255),
    "LName" character varying(255),
    "FName" character varying(255),
    "MI" character varying(255),
    "Suffix" character varying(255),
    "FeeSched" character varying(255),
    "Specialty" character varying(255),
    "SSN" character varying(255),
    "IsSecondary" boolean,
    "IsHidden" boolean,
    "UsingTIN" boolean,
    "DateTStamp" character varying(255),
    "IsNotPerson" boolean,
    "IsHiddenReport" boolean,
    "Birthdate" character varying(255),
    "SchedNote" character varying(255),
    "PreferredName" character varying(255),
    "provColor" character varying(255),
    "NationalProvID" character varying(255),
    "StateLicense" character varying(255)
);


ALTER TABLE "OpenDental"."ProvidersAudit" OWNER TO postgres;

--
-- Name: COLUMN "ProvidersAudit"."integrationJobRunId"; Type: COMMENT; Schema: OpenDental; Owner: postgres
--

COMMENT ON COLUMN "OpenDental"."ProvidersAudit"."integrationJobRunId" IS 'This is the only additional column compared to "OpenDental"."Providers".';


--
-- Name: ProvidersAudit_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."ProvidersAudit_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."ProvidersAudit_id_seq" OWNER TO postgres;

--
-- Name: ProvidersAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."ProvidersAudit_id_seq" OWNED BY "OpenDental"."ProvidersAudit".id;


--
-- Name: Providers_id_seq; Type: SEQUENCE; Schema: OpenDental; Owner: postgres
--

CREATE SEQUENCE "OpenDental"."Providers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OpenDental"."Providers_id_seq" OWNER TO postgres;

--
-- Name: Providers_id_seq; Type: SEQUENCE OWNED BY; Schema: OpenDental; Owner: postgres
--

ALTER SEQUENCE "OpenDental"."Providers_id_seq" OWNED BY "OpenDental"."Providers".id;


--
-- Name: PhiImageMetadata; Type: TABLE; Schema: Phi; Owner: postgres
--

CREATE TABLE "Phi"."PhiImageMetadata" (
    id integer NOT NULL,
    "otherPatientIDs" character varying(255),
    "patientId" character varying(255),
    "patientName" character varying(255),
    "patientFirstName" character varying(255),
    "patientLastName" character varying(255),
    "sopClassUID" character varying(255),
    "sopInstanceUID" character varying(255),
    "seriesInstanceUID" character varying(255),
    "institutionName" character varying(255),
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "patientBirthDate" timestamp with time zone
);


ALTER TABLE "Phi"."PhiImageMetadata" OWNER TO postgres;

--
-- Name: PhiImageMetadata_id_seq; Type: SEQUENCE; Schema: Phi; Owner: postgres
--

CREATE SEQUENCE "Phi"."PhiImageMetadata_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Phi"."PhiImageMetadata_id_seq" OWNER TO postgres;

--
-- Name: PhiImageMetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: Phi; Owner: postgres
--

ALTER SEQUENCE "Phi"."PhiImageMetadata_id_seq" OWNED BY "Phi"."PhiImageMetadata".id;


--
-- Name: Analyses; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Analyses" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "imageManifestId" integer NOT NULL,
    "rawResponseId" uuid,
    "modelHashes" jsonb,
    "mongoId" character varying(255),
    "mmPerPx" double precision
);


ALTER TABLE analyses."Analyses" OWNER TO postgres;

--
-- Name: AnalysesHistory; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."AnalysesHistory" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedBy" character varying(255),
    "deletedAt" timestamp with time zone,
    "imageManifestId" integer NOT NULL,
    data jsonb,
    note text,
    type character varying(255) NOT NULL
);


ALTER TABLE analyses."AnalysesHistory" OWNER TO postgres;

--
-- Name: BoneLevels; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."BoneLevels" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "toothId" uuid,
    "ablDistal" public.geometry(Point,90001),
    "ablMesial" public.geometry(Point,90001),
    "cejDistal" public.geometry(Point,90001),
    "cejMesial" public.geometry(Point,90001)
);


ALTER TABLE analyses."BoneLevels" OWNER TO postgres;

--
-- Name: Calculus; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Calculus" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "toothId" uuid,
    bounds public.geometry(Polygon,90001),
    outline public.geometry(MultiPolygon,90001)
);


ALTER TABLE analyses."Calculus" OWNER TO postgres;

--
-- Name: Caries; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Caries" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "toothId" uuid,
    severity character varying(255),
    category character varying(255),
    location character varying(255),
    bounds public.geometry(Polygon,90001),
    outline public.geometry(MultiPolygon,90001),
    "confidenceOutlineHigh" public.geometry(MultiPolygon,90001),
    "confidenceOutlineLow" public.geometry(MultiPolygon,90001),
    depth character(255),
    "findingIdentifier" character(255),
    "rootInvolvement" character(255)
);


ALTER TABLE analyses."Caries" OWNER TO postgres;

--
-- Name: ConfidenceThresholds; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."ConfidenceThresholds" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    label character varying(255) NOT NULL,
    tier0 real DEFAULT '1'::real NOT NULL,
    tier1 real NOT NULL,
    tier2 real NOT NULL,
    tier3 real NOT NULL,
    tier4 real NOT NULL,
    tier5 real NOT NULL,
    tier6 real NOT NULL,
    tier7 real DEFAULT '0'::real NOT NULL
);


ALTER TABLE analyses."ConfidenceThresholds" OWNER TO postgres;

--
-- Name: Crowns; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Crowns" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    label character varying(255) NOT NULL,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "operatingPoint" real,
    bounds public.geometry(Polygon,90001),
    attributes jsonb,
    "toothId" uuid,
    outline public.geometry(MultiPolygon,90001)
);


ALTER TABLE analyses."Crowns" OWNER TO postgres;

--
-- Name: Fillings; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Fillings" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    label character varying(255) NOT NULL,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "operatingPoint" real,
    bounds public.geometry(Polygon,90001),
    attributes jsonb,
    "toothId" uuid,
    outline public.geometry(MultiPolygon,90001)
);


ALTER TABLE analyses."Fillings" OWNER TO postgres;

--
-- Name: Findings; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Findings" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    label character varying(255) NOT NULL,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "operatingPoint" real,
    bounds public.geometry(Polygon,90001),
    attributes jsonb
);


ALTER TABLE analyses."Findings" OWNER TO postgres;

--
-- Name: FmxSummary; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."FmxSummary" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "estimatedVisitId" integer NOT NULL,
    "toothId" character varying(255) DEFAULT 'unknown'::character varying NOT NULL,
    dmf real,
    hash character(255) NOT NULL
);


ALTER TABLE analyses."FmxSummary" OWNER TO postgres;

--
-- Name: Labels; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Labels" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    label character varying(255) NOT NULL
);


ALTER TABLE analyses."Labels" OWNER TO postgres;

--
-- Name: RawResponses; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."RawResponses" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "imageManifestId" integer NOT NULL,
    response jsonb NOT NULL
);


ALTER TABLE analyses."RawResponses" OWNER TO postgres;

--
-- Name: RootCanals; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."RootCanals" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    label character varying(255) NOT NULL,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "operatingPoint" real,
    bounds public.geometry(Polygon,90001),
    attributes jsonb,
    "toothId" uuid,
    outline public.geometry(MultiPolygon,90001)
);


ALTER TABLE analyses."RootCanals" OWNER TO postgres;

--
-- Name: Roots; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Roots" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "toothId" uuid,
    type character varying(255),
    point public.geometry(Point,90001)
);


ALTER TABLE analyses."Roots" OWNER TO postgres;

--
-- Name: Teeth; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."Teeth" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "analysesId" uuid NOT NULL,
    "confidenceScore" real,
    "toothId" character varying(255) NOT NULL,
    enamel public.geometry(MultiPolygon,90001),
    "crownDentin" public.geometry(MultiPolygon,90001),
    "interproximalConcavities" public.geometry(MultiPolygon,90001),
    pulp public.geometry(MultiPolygon,90001),
    "rootDentin" public.geometry(MultiPolygon,90001),
    outline public.geometry(MultiPolygon,90001),
    dmf real,
    "isPartial" boolean,
    "isMissing" boolean
);


ALTER TABLE analyses."Teeth" OWNER TO postgres;

--
-- Name: UserValidations; Type: TABLE; Schema: analyses; Owner: postgres
--

CREATE TABLE analyses."UserValidations" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    status character varying(30) NOT NULL,
    description text,
    "updatedBy" character varying(30),
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "findingId" uuid NOT NULL,
    "findingType" character varying(255) NOT NULL
);


ALTER TABLE analyses."UserValidations" OWNER TO postgres;

--
-- Name: template_public_Events; Type: TABLE; Schema: partman; Owner: postgres
--

CREATE TABLE partman."template_public_Events" (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE partman."template_public_Events" OWNER TO postgres;

--
-- Name: AnalyzedImages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AnalyzedImages" (
    id integer NOT NULL,
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "patientId" integer,
    "externalImageId" character varying(255) NOT NULL,
    "videaImageId" character varying(255) NOT NULL,
    "imageCreatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "externalExamId" character varying(255),
    "imageMetaData" json,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "createdBy" character varying(255) NOT NULL,
    "updatedBy" character varying(255),
    "deletedBy" character varying(255)
);


ALTER TABLE public."AnalyzedImages" OWNER TO postgres;

--
-- Name: AnalyzedImages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AnalyzedImages_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AnalyzedImages_id_seq" OWNER TO postgres;

--
-- Name: AnalyzedImages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AnalyzedImages_id_seq" OWNED BY public."AnalyzedImages".id;


--
-- Name: CdtCodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CdtCodes" (
    "cdtCode" character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    category character varying(255) DEFAULT 'OTHER'::character varying NOT NULL,
    description character varying(255),
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."CdtCodes" OWNER TO postgres;

--
-- Name: COLUMN "CdtCodes"."cdtCode"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."CdtCodes"."cdtCode" IS 'standard code from ada';


--
-- Name: CdtCodesToAnalysesLabels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CdtCodesToAnalysesLabels" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone,
    "labelId" uuid NOT NULL,
    "cdtCode" character varying(255) NOT NULL,
    "isGeneralTreatment" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."CdtCodesToAnalysesLabels" OWNER TO postgres;

--
-- Name: COLUMN "CdtCodesToAnalysesLabels"."isGeneralTreatment"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."CdtCodesToAnalysesLabels"."isGeneralTreatment" IS 'indicates whether this treatment code should be considered at the entire mouth';


--
-- Name: ConnectorBackfillConfigs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ConnectorBackfillConfigs" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "machineName" character varying(255),
    "backfillEnabled" boolean DEFAULT false NOT NULL,
    "syncBandwidthLimit" integer DEFAULT 1 NOT NULL,
    "syncConcurrentRequestsLimit" integer DEFAULT 1 NOT NULL,
    "sourceDirectories" jsonb,
    "sourceFileExtensions" jsonb,
    "dtxDataUploadIntervalInSeconds" integer DEFAULT 6000 NOT NULL
);


ALTER TABLE public."ConnectorBackfillConfigs" OWNER TO postgres;

--
-- Name: ConnectorBackfillConfigs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ConnectorBackfillConfigs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ConnectorBackfillConfigs_id_seq" OWNER TO postgres;

--
-- Name: ConnectorBackfillConfigs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ConnectorBackfillConfigs_id_seq" OWNED BY public."ConnectorBackfillConfigs".id;


--
-- Name: CustomerProviders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CustomerProviders" (
    id integer NOT NULL,
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "customerProviderId" character varying(255) NOT NULL,
    "firstName" character varying(255),
    "lastName" character varying(255),
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);


ALTER TABLE public."CustomerProviders" OWNER TO postgres;

--
-- Name: CustomerProviders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CustomerProviders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CustomerProviders_id_seq" OWNER TO postgres;

--
-- Name: CustomerProviders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CustomerProviders_id_seq" OWNED BY public."CustomerProviders".id;


--
-- Name: CustomerTreatments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CustomerTreatments" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "customerTreatmentId" character varying(255) NOT NULL,
    "customerPatientId" character varying(255) NOT NULL,
    "procedureDate" timestamp with time zone NOT NULL,
    "adaProcedureCode" character varying(255) NOT NULL,
    "practiceProcedureCodeId" character varying(255),
    "treatmentCategory" public."enum_CustomerTreatments_treatmentCategory" DEFAULT 'OTHER'::public."enum_CustomerTreatments_treatmentCategory",
    "treatmentType" public."enum_CustomerTreatments_treatmentType" DEFAULT 'OTHER'::public."enum_CustomerTreatments_treatmentType",
    "appointmentId" character varying(255),
    amount numeric DEFAULT 0,
    "currencyCode" character varying(255) DEFAULT 'USD'::character varying,
    status public."enum_CustomerTreatments_status" DEFAULT 'OTHER'::public."enum_CustomerTreatments_status",
    "customerPracticionerId" character varying(255),
    "pmsType" public."enum_CustomerTreatments_pmsType" DEFAULT 'DENTRIX'::public."enum_CustomerTreatments_pmsType",
    "surfaceString" character varying(255),
    surfm numeric,
    surfo boolean,
    surfd boolean,
    surff boolean,
    surfl boolean,
    surf5 boolean,
    "toothRangeStart" numeric DEFAULT 0,
    "toothRangeEnd" numeric DEFAULT 0,
    "dentrixPatientGuid" character varying(255)
);


ALTER TABLE public."CustomerTreatments" OWNER TO postgres;

--
-- Name: CustomerTreatmentsAggregations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CustomerTreatmentsAggregations" (
    id integer NOT NULL,
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    year integer NOT NULL,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone NOT NULL,
    "aiFindingsCaries" integer NOT NULL,
    "restorativeTreatmentsCompleted" integer NOT NULL,
    "restorativeTreatmentsScheduled" integer NOT NULL,
    "restorativeTreatmentsPlanned" integer NOT NULL,
    "caseAcceptanceRate" numeric(10,4) NOT NULL,
    "aiDiagnosisRate" numeric(10,4) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "totalRestorativeRevenue" numeric,
    "lowCaseAcceptanceRate" boolean DEFAULT true,
    "lowAIDiagnosisRate" boolean DEFAULT true
);


ALTER TABLE public."CustomerTreatmentsAggregations" OWNER TO postgres;

--
-- Name: CustomerTreatmentsAggregations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CustomerTreatmentsAggregations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CustomerTreatmentsAggregations_id_seq" OWNER TO postgres;

--
-- Name: CustomerTreatmentsAggregations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CustomerTreatmentsAggregations_id_seq" OWNED BY public."CustomerTreatmentsAggregations".id;


--
-- Name: CustomerTreatments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CustomerTreatments_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CustomerTreatments_id_seq" OWNER TO postgres;

--
-- Name: CustomerTreatments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CustomerTreatments_id_seq" OWNED BY public."CustomerTreatments".id;


--
-- Name: DataDigest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DataDigest" (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    digest character varying(255) NOT NULL,
    version integer NOT NULL,
    status public."enum_DataDigest_status" NOT NULL,
    description character varying(255),
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."DataDigest" OWNER TO postgres;

--
-- Name: DataDigestMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DataDigestMeta" (
    id bigint NOT NULL,
    "dataDigestId" bigint,
    key character varying(255) NOT NULL,
    value jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."DataDigestMeta" OWNER TO postgres;

--
-- Name: DataDigestMeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DataDigestMeta_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DataDigestMeta_id_seq" OWNER TO postgres;

--
-- Name: DataDigestMeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DataDigestMeta_id_seq" OWNED BY public."DataDigestMeta".id;


--
-- Name: DataDigest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DataDigest_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DataDigest_id_seq" OWNER TO postgres;

--
-- Name: DataDigest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DataDigest_id_seq" OWNED BY public."DataDigest".id;


--
-- Name: DataUploadAudit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DataUploadAudit" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "dataUploadTriggerId" integer,
    "practiceVideaId" character varying(255),
    "s3Path" character varying(255),
    type public."enum_DataUploadAudit_type",
    "bullJobId" character varying(255),
    "legacyTreatments" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."DataUploadAudit" OWNER TO postgres;

--
-- Name: COLUMN "DataUploadAudit"."legacyTreatments"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."DataUploadAudit"."legacyTreatments" IS 'Whether this upload was done via the legacy treatments upload process';


--
-- Name: DataUploadAudit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DataUploadAudit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DataUploadAudit_id_seq" OWNER TO postgres;

--
-- Name: DataUploadAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DataUploadAudit_id_seq" OWNED BY public."DataUploadAudit".id;


--
-- Name: DataUploadTriggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DataUploadTriggers" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone,
    status public."enum_DataUploadTriggers_status" NOT NULL,
    "executionMachineName" character varying(255),
    priority smallint,
    type public."enum_DataUploadTriggers_type",
    description character varying(255),
    retries smallint DEFAULT 0,
    "videaId" character varying(255) DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public."DataUploadTriggers" OWNER TO postgres;

--
-- Name: COLUMN "DataUploadTriggers".description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."DataUploadTriggers".description IS 'Details the reason for the trigger or status of the trigger, especially in the case of a failure';


--
-- Name: COLUMN "DataUploadTriggers".retries; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."DataUploadTriggers".retries IS 'The number of times the trigger has been reset and returned.';


--
-- Name: DataUploadTriggers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DataUploadTriggers_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DataUploadTriggers_id_seq" OWNER TO postgres;

--
-- Name: DataUploadTriggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DataUploadTriggers_id_seq" OWNED BY public."DataUploadTriggers".id;


--
-- Name: DefaultPreferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DefaultPreferences" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "preferenceKey" text NOT NULL,
    "preferenceValue" jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBy" text,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."DefaultPreferences" OWNER TO postgres;

--
-- Name: EntityAliases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EntityAliases" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "entityType" public."enum_EntityAliases_entityType" NOT NULL,
    "externalId" character varying(255) NOT NULL,
    "videaId" character varying(255) NOT NULL
);


ALTER TABLE public."EntityAliases" OWNER TO postgres;

--
-- Name: EntityAliases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."EntityAliases_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."EntityAliases_id_seq" OWNER TO postgres;

--
-- Name: EntityAliases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."EntityAliases_id_seq" OWNED BY public."EntityAliases".id;


--
-- Name: EstimatedVisit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EstimatedVisit" (
    id integer NOT NULL,
    "imageCreatedAt" timestamp with time zone DEFAULT now(),
    "imageCount" integer DEFAULT 0 NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "patientId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."EstimatedVisit" OWNER TO postgres;

--
-- Name: EstimatedVisit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."EstimatedVisit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."EstimatedVisit_id_seq" OWNER TO postgres;

--
-- Name: EstimatedVisit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."EstimatedVisit_id_seq" OWNED BY public."EstimatedVisit".id;


--
-- Name: Events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events" (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
)
PARTITION BY RANGE ("createdAt");


ALTER TABLE public."Events" OWNER TO postgres;

--
-- Name: Events_archive; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_archive" (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_archive" OWNER TO postgres;

--
-- Name: Events_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Events_id_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Events_id_seq1" OWNER TO postgres;

--
-- Name: Events_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Events_id_seq1" OWNED BY public."Events".id;


--
-- Name: Events_default; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_default" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_default" OWNER TO postgres;

--
-- Name: Events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Events_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Events_id_seq" OWNER TO postgres;

--
-- Name: Events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Events_id_seq" OWNED BY public."Events_archive".id;


--
-- Name: Events_p2023_07_17; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_17" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_17" OWNER TO postgres;

--
-- Name: Events_p2023_07_18; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_18" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_18" OWNER TO postgres;

--
-- Name: Events_p2023_07_19; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_19" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_19" OWNER TO postgres;

--
-- Name: Events_p2023_07_20; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_20" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_20" OWNER TO postgres;

--
-- Name: Events_p2023_07_21; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_21" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_21" OWNER TO postgres;

--
-- Name: Events_p2023_07_22; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_22" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_22" OWNER TO postgres;

--
-- Name: Events_p2023_07_23; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_23" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_23" OWNER TO postgres;

--
-- Name: Events_p2023_07_24; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_24" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_24" OWNER TO postgres;

--
-- Name: Events_p2023_07_25; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_25" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_25" OWNER TO postgres;

--
-- Name: Events_p2023_07_26; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_26" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_26" OWNER TO postgres;

--
-- Name: Events_p2023_07_27; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_27" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_27" OWNER TO postgres;

--
-- Name: Events_p2023_07_28; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_28" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_28" OWNER TO postgres;

--
-- Name: Events_p2023_07_29; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_29" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_29" OWNER TO postgres;

--
-- Name: Events_p2023_07_30; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_30" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_30" OWNER TO postgres;

--
-- Name: Events_p2023_07_31; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_07_31" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_07_31" OWNER TO postgres;

--
-- Name: Events_p2023_08_01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_01" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_01" OWNER TO postgres;

--
-- Name: Events_p2023_08_02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_02" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_02" OWNER TO postgres;

--
-- Name: Events_p2023_08_03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_03" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_03" OWNER TO postgres;

--
-- Name: Events_p2023_08_04; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_04" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_04" OWNER TO postgres;

--
-- Name: Events_p2023_08_05; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_05" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_05" OWNER TO postgres;

--
-- Name: Events_p2023_08_06; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_06" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_06" OWNER TO postgres;

--
-- Name: Events_p2023_08_07; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_07" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_07" OWNER TO postgres;

--
-- Name: Events_p2023_08_08; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_08" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_08" OWNER TO postgres;

--
-- Name: Events_p2023_08_09; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_09" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_09" OWNER TO postgres;

--
-- Name: Events_p2023_08_10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_10" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_10" OWNER TO postgres;

--
-- Name: Events_p2023_08_11; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_11" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_11" OWNER TO postgres;

--
-- Name: Events_p2023_08_12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_12" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_12" OWNER TO postgres;

--
-- Name: Events_p2023_08_13; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_13" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_13" OWNER TO postgres;

--
-- Name: Events_p2023_08_14; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_14" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_14" OWNER TO postgres;

--
-- Name: Events_p2023_08_15; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_15" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_15" OWNER TO postgres;

--
-- Name: Events_p2023_08_16; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_16" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_16" OWNER TO postgres;

--
-- Name: Events_p2023_08_17; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_17" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_17" OWNER TO postgres;

--
-- Name: Events_p2023_08_18; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_18" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_18" OWNER TO postgres;

--
-- Name: Events_p2023_08_19; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_19" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_19" OWNER TO postgres;

--
-- Name: Events_p2023_08_20; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_20" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_20" OWNER TO postgres;

--
-- Name: Events_p2023_08_21; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_21" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_21" OWNER TO postgres;

--
-- Name: Events_p2023_08_22; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_22" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_22" OWNER TO postgres;

--
-- Name: Events_p2023_08_23; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_23" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_23" OWNER TO postgres;

--
-- Name: Events_p2023_08_24; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_24" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_24" OWNER TO postgres;

--
-- Name: Events_p2023_08_25; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_25" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_25" OWNER TO postgres;

--
-- Name: Events_p2023_08_26; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_26" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_26" OWNER TO postgres;

--
-- Name: Events_p2023_08_27; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_27" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_27" OWNER TO postgres;

--
-- Name: Events_p2023_08_28; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_28" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_28" OWNER TO postgres;

--
-- Name: Events_p2023_08_29; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_29" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_29" OWNER TO postgres;

--
-- Name: Events_p2023_08_30; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_30" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_30" OWNER TO postgres;

--
-- Name: Events_p2023_08_31; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_08_31" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_08_31" OWNER TO postgres;

--
-- Name: Events_p2023_09_01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_01" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_01" OWNER TO postgres;

--
-- Name: Events_p2023_09_02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_02" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_02" OWNER TO postgres;

--
-- Name: Events_p2023_09_03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_03" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_03" OWNER TO postgres;

--
-- Name: Events_p2023_09_04; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_04" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_04" OWNER TO postgres;

--
-- Name: Events_p2023_09_05; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_05" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_05" OWNER TO postgres;

--
-- Name: Events_p2023_09_06; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_06" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_06" OWNER TO postgres;

--
-- Name: Events_p2023_09_07; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_07" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_07" OWNER TO postgres;

--
-- Name: Events_p2023_09_08; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_08" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_08" OWNER TO postgres;

--
-- Name: Events_p2023_09_09; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_09" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_09" OWNER TO postgres;

--
-- Name: Events_p2023_09_10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_10" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_10" OWNER TO postgres;

--
-- Name: Events_p2023_09_11; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_11" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_11" OWNER TO postgres;

--
-- Name: Events_p2023_09_12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_12" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_12" OWNER TO postgres;

--
-- Name: Events_p2023_09_13; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_13" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_13" OWNER TO postgres;

--
-- Name: Events_p2023_09_14; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_14" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_14" OWNER TO postgres;

--
-- Name: Events_p2023_09_15; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_15" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_15" OWNER TO postgres;

--
-- Name: Events_p2023_09_16; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_16" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_16" OWNER TO postgres;

--
-- Name: Events_p2023_09_17; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_17" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_17" OWNER TO postgres;

--
-- Name: Events_p2023_09_18; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_18" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_18" OWNER TO postgres;

--
-- Name: Events_p2023_09_19; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_19" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_19" OWNER TO postgres;

--
-- Name: Events_p2023_09_20; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_20" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_20" OWNER TO postgres;

--
-- Name: Events_p2023_09_21; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_21" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_21" OWNER TO postgres;

--
-- Name: Events_p2023_09_22; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_22" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_22" OWNER TO postgres;

--
-- Name: Events_p2023_09_23; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_23" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_23" OWNER TO postgres;

--
-- Name: Events_p2023_09_24; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_24" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_24" OWNER TO postgres;

--
-- Name: Events_p2023_09_25; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_25" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_25" OWNER TO postgres;

--
-- Name: Events_p2023_09_26; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_26" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_26" OWNER TO postgres;

--
-- Name: Events_p2023_09_27; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_27" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_27" OWNER TO postgres;

--
-- Name: Events_p2023_09_28; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_28" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_28" OWNER TO postgres;

--
-- Name: Events_p2023_09_29; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_29" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_29" OWNER TO postgres;

--
-- Name: Events_p2023_09_30; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_09_30" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_09_30" OWNER TO postgres;

--
-- Name: Events_p2023_10_01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_01" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_01" OWNER TO postgres;

--
-- Name: Events_p2023_10_02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_02" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_02" OWNER TO postgres;

--
-- Name: Events_p2023_10_03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_03" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_03" OWNER TO postgres;

--
-- Name: Events_p2023_10_04; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_04" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_04" OWNER TO postgres;

--
-- Name: Events_p2023_10_05; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_05" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_05" OWNER TO postgres;

--
-- Name: Events_p2023_10_06; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_06" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_06" OWNER TO postgres;

--
-- Name: Events_p2023_10_07; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_07" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_07" OWNER TO postgres;

--
-- Name: Events_p2023_10_08; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_08" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_08" OWNER TO postgres;

--
-- Name: Events_p2023_10_09; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_09" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_09" OWNER TO postgres;

--
-- Name: Events_p2023_10_10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_10" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_10" OWNER TO postgres;

--
-- Name: Events_p2023_10_11; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_11" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_11" OWNER TO postgres;

--
-- Name: Events_p2023_10_12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_12" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_12" OWNER TO postgres;

--
-- Name: Events_p2023_10_13; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_13" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_13" OWNER TO postgres;

--
-- Name: Events_p2023_10_14; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_14" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_14" OWNER TO postgres;

--
-- Name: Events_p2023_10_15; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_15" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_15" OWNER TO postgres;

--
-- Name: Events_p2023_10_16; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_16" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_16" OWNER TO postgres;

--
-- Name: Events_p2023_10_17; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_17" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_17" OWNER TO postgres;

--
-- Name: Events_p2023_10_18; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_18" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_18" OWNER TO postgres;

--
-- Name: Events_p2023_10_19; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_19" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_19" OWNER TO postgres;

--
-- Name: Events_p2023_10_20; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_20" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_20" OWNER TO postgres;

--
-- Name: Events_p2023_10_21; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_21" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_21" OWNER TO postgres;

--
-- Name: Events_p2023_10_22; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_22" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_22" OWNER TO postgres;

--
-- Name: Events_p2023_10_23; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_23" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_23" OWNER TO postgres;

--
-- Name: Events_p2023_10_24; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_24" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_24" OWNER TO postgres;

--
-- Name: Events_p2023_10_25; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_25" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_25" OWNER TO postgres;

--
-- Name: Events_p2023_10_26; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_26" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_26" OWNER TO postgres;

--
-- Name: Events_p2023_10_27; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_27" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_27" OWNER TO postgres;

--
-- Name: Events_p2023_10_28; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_28" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_28" OWNER TO postgres;

--
-- Name: Events_p2023_10_29; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_29" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_29" OWNER TO postgres;

--
-- Name: Events_p2023_10_30; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_30" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_30" OWNER TO postgres;

--
-- Name: Events_p2023_10_31; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_10_31" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_10_31" OWNER TO postgres;

--
-- Name: Events_p2023_11_01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_01" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_01" OWNER TO postgres;

--
-- Name: Events_p2023_11_02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_02" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_02" OWNER TO postgres;

--
-- Name: Events_p2023_11_03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_03" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_03" OWNER TO postgres;

--
-- Name: Events_p2023_11_04; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_04" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_04" OWNER TO postgres;

--
-- Name: Events_p2023_11_05; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_05" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_05" OWNER TO postgres;

--
-- Name: Events_p2023_11_06; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_06" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_06" OWNER TO postgres;

--
-- Name: Events_p2023_11_07; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_07" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_07" OWNER TO postgres;

--
-- Name: Events_p2023_11_08; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_08" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_08" OWNER TO postgres;

--
-- Name: Events_p2023_11_09; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_09" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_09" OWNER TO postgres;

--
-- Name: Events_p2023_11_10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_10" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_10" OWNER TO postgres;

--
-- Name: Events_p2023_11_11; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_11" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_11" OWNER TO postgres;

--
-- Name: Events_p2023_11_12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_12" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_12" OWNER TO postgres;

--
-- Name: Events_p2023_11_13; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_13" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_13" OWNER TO postgres;

--
-- Name: Events_p2023_11_14; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_14" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_14" OWNER TO postgres;

--
-- Name: Events_p2023_11_15; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_15" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_15" OWNER TO postgres;

--
-- Name: Events_p2023_11_16; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_16" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_16" OWNER TO postgres;

--
-- Name: Events_p2023_11_17; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_17" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_17" OWNER TO postgres;

--
-- Name: Events_p2023_11_18; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_18" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_18" OWNER TO postgres;

--
-- Name: Events_p2023_11_19; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_19" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_19" OWNER TO postgres;

--
-- Name: Events_p2023_11_20; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_20" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_20" OWNER TO postgres;

--
-- Name: Events_p2023_11_21; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_21" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_21" OWNER TO postgres;

--
-- Name: Events_p2023_11_22; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_22" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_22" OWNER TO postgres;

--
-- Name: Events_p2023_11_23; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_23" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_23" OWNER TO postgres;

--
-- Name: Events_p2023_11_24; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_24" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_24" OWNER TO postgres;

--
-- Name: Events_p2023_11_25; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_25" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_25" OWNER TO postgres;

--
-- Name: Events_p2023_11_26; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_26" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_26" OWNER TO postgres;

--
-- Name: Events_p2023_11_27; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_27" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_27" OWNER TO postgres;

--
-- Name: Events_p2023_11_28; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_28" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_28" OWNER TO postgres;

--
-- Name: Events_p2023_11_29; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_29" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_29" OWNER TO postgres;

--
-- Name: Events_p2023_11_30; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_11_30" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_11_30" OWNER TO postgres;

--
-- Name: Events_p2023_12_01; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_01" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_01" OWNER TO postgres;

--
-- Name: Events_p2023_12_02; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_02" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_02" OWNER TO postgres;

--
-- Name: Events_p2023_12_03; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_03" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_03" OWNER TO postgres;

--
-- Name: Events_p2023_12_04; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_04" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_04" OWNER TO postgres;

--
-- Name: Events_p2023_12_05; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_05" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_05" OWNER TO postgres;

--
-- Name: Events_p2023_12_06; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_06" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_06" OWNER TO postgres;

--
-- Name: Events_p2023_12_07; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_07" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_07" OWNER TO postgres;

--
-- Name: Events_p2023_12_08; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_08" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_08" OWNER TO postgres;

--
-- Name: Events_p2023_12_09; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_09" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_09" OWNER TO postgres;

--
-- Name: Events_p2023_12_10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_10" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_10" OWNER TO postgres;

--
-- Name: Events_p2023_12_11; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_11" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_11" OWNER TO postgres;

--
-- Name: Events_p2023_12_12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_12" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_12" OWNER TO postgres;

--
-- Name: Events_p2023_12_13; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_13" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_13" OWNER TO postgres;

--
-- Name: Events_p2023_12_14; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Events_p2023_12_14" (
    id bigint DEFAULT nextval('public."Events_id_seq1"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdBy" character varying(255),
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    body jsonb
);


ALTER TABLE public."Events_p2023_12_14" OWNER TO postgres;

--
-- Name: ExternalAccessTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ExternalAccessTokens" (
    id integer NOT NULL,
    "tokenOwnerId" character varying(255) NOT NULL,
    "tokenOwnerType" public."enum_ExternalAccessTokens_tokenOwnerType" NOT NULL,
    "accessToken" text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "createdBy" character varying(255) NOT NULL,
    "updatedBy" character varying(255) NOT NULL,
    "deletedBy" character varying(255)
);


ALTER TABLE public."ExternalAccessTokens" OWNER TO postgres;

--
-- Name: ExternalAccessTokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ExternalAccessTokens_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ExternalAccessTokens_id_seq" OWNER TO postgres;

--
-- Name: ExternalAccessTokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ExternalAccessTokens_id_seq" OWNED BY public."ExternalAccessTokens".id;


--
-- Name: ExternalLocationSecrets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ExternalLocationSecrets" (
    id integer NOT NULL,
    "provisionedEntityId" integer,
    "locationSecret" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "deletedAt" timestamp with time zone,
    "createdBy" character varying(255) NOT NULL,
    "updatedBy" character varying(255),
    "deletedBy" character varying(255)
);


ALTER TABLE public."ExternalLocationSecrets" OWNER TO postgres;

--
-- Name: ExternalLocationSecrets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ExternalLocationSecrets_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ExternalLocationSecrets_id_seq" OWNER TO postgres;

--
-- Name: ExternalLocationSecrets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ExternalLocationSecrets_id_seq" OWNED BY public."ExternalLocationSecrets".id;


--
-- Name: HuddlePatientData; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."HuddlePatientData" (
    "pmsPatientId" bigint NOT NULL,
    "isBitewingsDue" boolean,
    "isPerioChartDue" boolean,
    "isFmxDue" boolean,
    "isProphyDue" boolean,
    "isPerioMaintenanceDue" boolean,
    "isNextAppointmentDue" boolean,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."HuddlePatientData" OWNER TO postgres;

--
-- Name: ImageAnalysisMirrors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ImageAnalysisMirrors" (
    id integer NOT NULL,
    "mongodbAnalysisId" character varying(255) NOT NULL,
    "imageManifestId" integer,
    "finalProcessingStatus" character varying(255) NOT NULL,
    "finalProcessingStatusCode" character varying(255),
    "finalProcessingStatusMessage" character varying(255),
    "imageAcquiredAt" timestamp with time zone NOT NULL,
    "numberOfCaries" integer,
    "rblSeverities" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."ImageAnalysisMirrors" OWNER TO postgres;

--
-- Name: ImageAnalysisMirrors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ImageAnalysisMirrors_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ImageAnalysisMirrors_id_seq" OWNER TO postgres;

--
-- Name: ImageAnalysisMirrors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ImageAnalysisMirrors_id_seq" OWNED BY public."ImageAnalysisMirrors".id;


--
-- Name: ImageCatalog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ImageCatalog" (
    id integer NOT NULL,
    "imageManifestId" integer,
    "mongoImageId" character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."ImageCatalog" OWNER TO postgres;

--
-- Name: ImageCatalog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ImageCatalog_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ImageCatalog_id_seq" OWNER TO postgres;

--
-- Name: ImageCatalog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ImageCatalog_id_seq" OWNED BY public."ImageCatalog".id;


--
-- Name: ImagingPatientIdentifiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ImagingPatientIdentifiers" (
    id bigint NOT NULL,
    "imageMetadataPatientId" character varying(255),
    "chartNum" character varying(255),
    "imagingPatientId" integer NOT NULL,
    "practiceId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."ImagingPatientIdentifiers" OWNER TO postgres;

--
-- Name: ImagingPatientIdentifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ImagingPatientIdentifiers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ImagingPatientIdentifiers_id_seq" OWNER TO postgres;

--
-- Name: ImagingPatientIdentifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ImagingPatientIdentifiers_id_seq" OWNED BY public."ImagingPatientIdentifiers".id;


--
-- Name: ImagingPatients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ImagingPatients" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "practicePatientId" character varying(255),
    "practiceId" character varying(255) NOT NULL,
    "organizationId" character varying(255) NOT NULL,
    name character varying(255),
    "dateOfBirth" date,
    sex character varying(255),
    "videaId" uuid NOT NULL,
    "sourceImageAcquiredAt" timestamp with time zone,
    "chartNum" character(255),
    "folderHash" character varying(255)
);


ALTER TABLE public."ImagingPatients" OWNER TO postgres;

--
-- Name: ImagingPatientsSources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ImagingPatientsSources" (
    id integer NOT NULL,
    "imagingPatientId" bigint NOT NULL,
    "imagingPatientSource" public."enum_ImagingPatientsSources_imagingPatientSource" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."ImagingPatientsSources" OWNER TO postgres;

--
-- Name: ImagingPatientsSources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ImagingPatientsSources_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ImagingPatientsSources_id_seq" OWNER TO postgres;

--
-- Name: ImagingPatientsSources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ImagingPatientsSources_id_seq" OWNED BY public."ImagingPatientsSources".id;


--
-- Name: InsightsAggregateMetrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InsightsAggregateMetrics" (
    id bigint NOT NULL,
    "constructType" public."enum_InsightsAggregateMetrics_constructType" NOT NULL,
    "constructId" integer NOT NULL,
    "temporalIntervalType" public."enum_InsightsAggregateMetrics_temporalIntervalType" NOT NULL,
    start date NOT NULL,
    "end" date NOT NULL,
    "patientsWithRestoAiFindings" integer DEFAULT 0 NOT NULL,
    "restoDiagnosticRate" numeric(4,3) DEFAULT 0 NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "cariesFindings" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."InsightsAggregateMetrics" OWNER TO postgres;

--
-- Name: InsightsAggregateMetrics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."InsightsAggregateMetrics_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."InsightsAggregateMetrics_id_seq" OWNER TO postgres;

--
-- Name: InsightsAggregateMetrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."InsightsAggregateMetrics_id_seq" OWNED BY public."InsightsAggregateMetrics".id;


--
-- Name: IntegrationJobAudit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IntegrationJobAudit" (
    id integer NOT NULL,
    "integrationJobRunId" integer,
    key character varying(255) NOT NULL,
    value jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."IntegrationJobAudit" OWNER TO postgres;

--
-- Name: IntegrationJobAudit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IntegrationJobAudit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IntegrationJobAudit_id_seq" OWNER TO postgres;

--
-- Name: IntegrationJobAudit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IntegrationJobAudit_id_seq" OWNED BY public."IntegrationJobAudit".id;


--
-- Name: IntegrationJobRuns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IntegrationJobRuns" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "organizationId" character varying(255),
    "practiceId" character varying(255),
    "bullJobId" character varying(255),
    name character varying(255) NOT NULL,
    start timestamp with time zone,
    "end" timestamp with time zone,
    params json,
    status character varying(255),
    description character varying(255),
    "parentId" integer,
    progress smallint DEFAULT 0
);


ALTER TABLE public."IntegrationJobRuns" OWNER TO postgres;

--
-- Name: IntegrationJobRuns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IntegrationJobRuns_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IntegrationJobRuns_id_seq" OWNER TO postgres;

--
-- Name: IntegrationJobRuns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IntegrationJobRuns_id_seq" OWNED BY public."IntegrationJobRuns".id;


--
-- Name: MagicLink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MagicLink" (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    "idToken" jsonb NOT NULL,
    "accessToken" jsonb NOT NULL,
    "practiceId" integer NOT NULL,
    "expiresAt" timestamp with time zone DEFAULT (CURRENT_TIMESTAMP + '01:00:00'::interval) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."MagicLink" OWNER TO postgres;

--
-- Name: MagicLink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MagicLink_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MagicLink_id_seq" OWNER TO postgres;

--
-- Name: MagicLink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MagicLink_id_seq" OWNED BY public."MagicLink".id;


--
-- Name: OrganizationPreferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrganizationPreferences" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "preferenceKey" text NOT NULL,
    "preferenceValue" jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBy" text,
    "deletedAt" timestamp with time zone,
    "organizationId" text NOT NULL
);


ALTER TABLE public."OrganizationPreferences" OWNER TO postgres;

--
-- Name: Organizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Organizations" (
    id integer NOT NULL,
    "videaId" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name character varying(255) NOT NULL,
    flags jsonb,
    "inMongo" boolean DEFAULT false,
    "vaultPracticeId" bigint
);


ALTER TABLE public."Organizations" OWNER TO postgres;

--
-- Name: COLUMN "Organizations".id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Organizations".id IS 'internal id';


--
-- Name: COLUMN "Organizations"."videaId"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Organizations"."videaId" IS 'external, unique, hexadecimal identifier';


--
-- Name: COLUMN "Organizations"."inMongo"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Organizations"."inMongo" IS 'indicates that this record has an analogue from MongoDB which the videaId is sourced from';


--
-- Name: COLUMN "Organizations"."vaultPracticeId"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Organizations"."vaultPracticeId" IS 'When Organizations share data across all practices, this column refers to the PmsPractice where Images will be uploaded to.';


--
-- Name: Organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Organizations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Organizations_id_seq" OWNER TO postgres;

--
-- Name: Organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Organizations_id_seq" OWNED BY public."Organizations".id;


--
-- Name: PatientIdMatches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PatientIdMatches" (
    id bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "practiceId" integer NOT NULL,
    "pmsPatientId" bigint NOT NULL,
    "imagingPatientId" integer NOT NULL,
    "matchMethod" public."enum_PatientIdMatches_matchMethod" NOT NULL,
    details text,
    "nameDifference" numeric
);


ALTER TABLE public."PatientIdMatches" OWNER TO postgres;

--
-- Name: PatientIdMatches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PatientIdMatches_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PatientIdMatches_id_seq" OWNER TO postgres;

--
-- Name: PatientIdMatches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PatientIdMatches_id_seq" OWNED BY public."PatientIdMatches".id;


--
-- Name: Patients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Patients_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Patients_id_seq" OWNER TO postgres;

--
-- Name: Patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Patients_id_seq" OWNED BY public."ImagingPatients".id;


--
-- Name: PmsAppointmentToTreatments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsAppointmentToTreatments" (
    "treatmentId" bigint NOT NULL,
    "appointmentId" bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."PmsAppointmentToTreatments" OWNER TO postgres;

--
-- Name: PmsAppointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsAppointments" (
    id bigint NOT NULL,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone NOT NULL,
    "patientId" bigint NOT NULL,
    "providerId" bigint,
    "operatoryId" bigint,
    "videaId" character varying(255) NOT NULL,
    "pmsId" character varying(255) NOT NULL,
    "pmsIntegrationType" public."enum_PmsAppointments_pmsIntegrationType" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "practiceId" bigint NOT NULL
);


ALTER TABLE public."PmsAppointments" OWNER TO postgres;

--
-- Name: PmsAppointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsAppointments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsAppointments_id_seq" OWNER TO postgres;

--
-- Name: PmsAppointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsAppointments_id_seq" OWNED BY public."PmsAppointments".id;


--
-- Name: PmsDataIngestionContext; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsDataIngestionContext" (
    id integer NOT NULL,
    "organizationId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "pmsType" character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    "pmsContext" jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."PmsDataIngestionContext" OWNER TO postgres;

--
-- Name: PmsDataIngestionContext_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsDataIngestionContext_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsDataIngestionContext_id_seq" OWNER TO postgres;

--
-- Name: PmsDataIngestionContext_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsDataIngestionContext_id_seq" OWNED BY public."PmsDataIngestionContext".id;


--
-- Name: PmsOperatories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsOperatories" (
    id bigint NOT NULL,
    "displayName" character varying(255) NOT NULL,
    "shortName" character varying(255) NOT NULL,
    "practiceId" bigint NOT NULL,
    "videaId" character varying(255) NOT NULL,
    "pmsId" character varying(255) NOT NULL,
    "pmsIntegrationType" public."enum_PmsOperatories_pmsIntegrationType" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."PmsOperatories" OWNER TO postgres;

--
-- Name: PmsOperatories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsOperatories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsOperatories_id_seq" OWNER TO postgres;

--
-- Name: PmsOperatories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsOperatories_id_seq" OWNED BY public."PmsOperatories".id;


--
-- Name: PmsPatientViewCounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsPatientViewCounts" (
    id bigint NOT NULL,
    "practiceId" integer NOT NULL,
    "pmsPatientId" bigint NOT NULL,
    "viewedDay" date NOT NULL,
    "viewCount" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."PmsPatientViewCounts" OWNER TO postgres;

--
-- Name: PmsPatientViewCounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsPatientViewCounts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsPatientViewCounts_id_seq" OWNER TO postgres;

--
-- Name: PmsPatientViewCounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsPatientViewCounts_id_seq" OWNED BY public."PmsPatientViewCounts".id;


--
-- Name: PmsPatients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsPatients" (
    id bigint NOT NULL,
    "firstName" character varying(255),
    "lastName" character varying(255),
    "displayName" character varying(255),
    gender character varying(255),
    dob date,
    "videaId" character varying(255) NOT NULL,
    "pmsId" character varying(255) NOT NULL,
    "pmsIntegrationType" public."enum_PmsPatients_pmsIntegrationType" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "practiceId" bigint NOT NULL,
    "isBitewingsDue" boolean,
    "isPerioChartDue" boolean,
    "isFmxDue" boolean,
    "isProphyDue" boolean,
    "isPerioMaintenanceDue" boolean,
    "isNextAppointmentDue" boolean,
    "organizationId" integer
);


ALTER TABLE public."PmsPatients" OWNER TO postgres;

--
-- Name: PmsPatients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsPatients_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsPatients_id_seq" OWNER TO postgres;

--
-- Name: PmsPatients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsPatients_id_seq" OWNED BY public."PmsPatients".id;


--
-- Name: PmsProviders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsProviders" (
    id bigint NOT NULL,
    "firstName" character varying(255),
    "lastName" character varying(255),
    "displayName" character varying(255),
    "videaId" character varying(255) NOT NULL,
    "pmsId" character varying(255) NOT NULL,
    "pmsIntegrationType" public."enum_PmsProviders_pmsIntegrationType" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "practiceId" bigint NOT NULL,
    "organizationId" integer
);


ALTER TABLE public."PmsProviders" OWNER TO postgres;

--
-- Name: PmsProviders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsProviders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsProviders_id_seq" OWNER TO postgres;

--
-- Name: PmsProviders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsProviders_id_seq" OWNED BY public."PmsProviders".id;


--
-- Name: PmsTreatmentStatusHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsTreatmentStatusHistory" (
    "pmsTreatmentId" bigint NOT NULL,
    "entryDate" date NOT NULL,
    "entryStatus" public."enum_PmsTreatments_status" NOT NULL,
    "finalDate" date,
    "finalStatus" public."enum_PmsTreatments_status",
    "isHistoricalCompleted" boolean,
    "sameDay" boolean,
    "completionTimeDays" smallint,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."PmsTreatmentStatusHistory" OWNER TO postgres;

--
-- Name: PmsTreatments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PmsTreatments" (
    id bigint NOT NULL,
    "practiceId" bigint NOT NULL,
    "patientId" bigint NOT NULL,
    "cdtCode" character varying(255),
    category public."enum_PmsTreatments_category" DEFAULT 'OTHER'::public."enum_PmsTreatments_category" NOT NULL,
    "shortName" character varying(255),
    status public."enum_PmsTreatments_status" DEFAULT 'OTHER'::public."enum_PmsTreatments_status" NOT NULL,
    surface character varying(255),
    "toothNum" character varying(255),
    "toothRange" character varying(255),
    "videaId" character varying(255) NOT NULL,
    "pmsId" character varying(255) NOT NULL,
    "pmsIntegrationType" public."enum_PmsTreatments_pmsIntegrationType" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "lastModified" timestamp with time zone,
    "treatmentDate" date,
    amount numeric
);


ALTER TABLE public."PmsTreatments" OWNER TO postgres;

--
-- Name: PmsTreatmentsView; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."PmsTreatmentsView" AS
 SELECT t.id,
    t."practiceId",
    t."patientId",
    t."cdtCode",
    (COALESCE(c.category, 'OTHER'::character varying))::character varying(255) AS category,
    (COALESCE(c.type, 'OTHER'::character varying))::character varying(255) AS "shortName",
    t.status,
    t.surface,
    t."toothNum",
    t."toothRange",
    t."videaId",
    t."pmsId",
    t."pmsIntegrationType",
    t."createdAt",
    t."updatedAt",
    t."deletedAt",
    t."lastModified",
    t."treatmentDate",
    t.amount
   FROM (public."PmsTreatments" t
     LEFT JOIN public."CdtCodes" c ON (((t."cdtCode")::text = (c."cdtCode")::text)));


ALTER TABLE public."PmsTreatmentsView" OWNER TO postgres;

--
-- Name: PmsTreatments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PmsTreatments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PmsTreatments_id_seq" OWNER TO postgres;

--
-- Name: PmsTreatments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PmsTreatments_id_seq" OWNED BY public."PmsTreatments".id;


--
-- Name: PracticePreferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PracticePreferences" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "preferenceKey" text NOT NULL,
    "preferenceValue" jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBy" text,
    "deletedAt" timestamp with time zone,
    "practiceId" text NOT NULL
);


ALTER TABLE public."PracticePreferences" OWNER TO postgres;

--
-- Name: Practices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Practices" (
    id integer NOT NULL,
    "videaId" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name character varying(255) NOT NULL,
    location character varying(255),
    "organizationId" integer NOT NULL,
    status public."enum_Practices_status" DEFAULT 'Active'::public."enum_Practices_status" NOT NULL,
    "accountOwnerName" character varying(255),
    "sensorTypes" jsonb,
    "pmsIntegrationType" character varying(255),
    "pmsFileTypes" jsonb,
    flags jsonb,
    "inMongo" boolean DEFAULT false,
    "lastPatientTaskCalculationAt" timestamp with time zone,
    timezone character varying(255),
    "userExperience" character varying(255) DEFAULT 'STANDALONE'::character varying NOT NULL,
    "externalPracticeId" character varying(255),
    "pmsShortName" character varying(255),
    "isTest" boolean DEFAULT false NOT NULL,
    "onboardingDate" date,
    configuration character varying(255),
    "cloudwatchLogStream" jsonb,
    country character(2),
    language character varying(255) DEFAULT NULL::character varying,
    "dentrixSerialNumber" character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."Practices" OWNER TO postgres;

--
-- Name: COLUMN "Practices".id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Practices".id IS 'internal id';


--
-- Name: COLUMN "Practices"."videaId"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Practices"."videaId" IS 'external, unique, hexadecimal identifier';


--
-- Name: COLUMN "Practices"."inMongo"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Practices"."inMongo" IS 'indicates that this record has an analogue from MongoDB which the videaId is sourced from';


--
-- Name: COLUMN "Practices"."onboardingDate"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Practices"."onboardingDate" IS 'For ROI purposes, we need to know when the customer began using the product.';


--
-- Name: Practices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Practices_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Practices_id_seq" OWNER TO postgres;

--
-- Name: Practices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Practices_id_seq" OWNED BY public."Practices".id;


--
-- Name: ProductKeys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductKeys" (
    id integer NOT NULL,
    "productKeyId" uuid,
    "productKey" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deactivatedAt" timestamp with time zone,
    "createdBy" character varying(255) NOT NULL,
    "updatedBy" character varying(255) NOT NULL,
    "deactivatedBy" character varying(255)
);


ALTER TABLE public."ProductKeys" OWNER TO postgres;

--
-- Name: ProductKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductKeys_id_seq" OWNER TO postgres;

--
-- Name: ProductKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductKeys_id_seq" OWNED BY public."ProductKeys".id;


--
-- Name: ProvisionedEntities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProvisionedEntities" (
    id integer NOT NULL,
    "integrationPartnerId" character varying(255) NOT NULL,
    "entityType" public."enum_ProvisionedEntities_entityType" NOT NULL,
    "externalId" character varying(255) NOT NULL,
    "videaId" character varying(255) NOT NULL,
    "parentEntityId" integer,
    "metaData" json,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "deletedAt" timestamp with time zone,
    "createdBy" character varying(255) NOT NULL,
    "updatedBy" character varying(255),
    "deletedBy" character varying(255),
    "enabledModels" json,
    "salesDetails" jsonb
);


ALTER TABLE public."ProvisionedEntities" OWNER TO postgres;

--
-- Name: ProvisionedEntities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProvisionedEntities_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProvisionedEntities_id_seq" OWNER TO postgres;

--
-- Name: ProvisionedEntities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProvisionedEntities_id_seq" OWNED BY public."ProvisionedEntities".id;


--
-- Name: QuarantineImages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuarantineImages" (
    id integer NOT NULL,
    "imageManifestId" integer,
    status character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."QuarantineImages" OWNER TO postgres;

--
-- Name: COLUMN "QuarantineImages".id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."QuarantineImages".id IS 'Autoincremented instead of storing IDs from Dentrix Ascend directly';


--
-- Name: QuarantineImages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."QuarantineImages_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."QuarantineImages_id_seq" OWNER TO postgres;

--
-- Name: QuarantineImages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."QuarantineImages_id_seq" OWNED BY public."QuarantineImages".id;


--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: UnifiedAppointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UnifiedAppointments" (
    id bigint NOT NULL,
    "appointmentOn" timestamp with time zone NOT NULL,
    "practiceId" bigint NOT NULL,
    "estimatedVisitId" bigint,
    "pmsAppointmentId" bigint,
    "pmsPatientId" bigint,
    "imagingPatientId" bigint,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "organizationId" integer
);


ALTER TABLE public."UnifiedAppointments" OWNER TO postgres;

--
-- Name: UnifiedAppointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UnifiedAppointments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UnifiedAppointments_id_seq" OWNER TO postgres;

--
-- Name: UnifiedAppointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UnifiedAppointments_id_seq" OWNED BY public."UnifiedAppointments".id;


--
-- Name: UserEvents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserEvents" (
    id bigint NOT NULL,
    "estimatedVisitId" bigint,
    "userId" character varying(255) NOT NULL,
    "eventName" character varying(255) NOT NULL,
    "imageCount" integer,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."UserEvents" OWNER TO postgres;

--
-- Name: UserEvents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserEvents_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UserEvents_id_seq" OWNER TO postgres;

--
-- Name: UserEvents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserEvents_id_seq" OWNED BY public."UserEvents".id;


--
-- Name: UserPreferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserPreferences" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "preferenceKey" text NOT NULL,
    "preferenceValue" jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBy" text,
    "deletedAt" timestamp with time zone,
    "userId" text NOT NULL
);


ALTER TABLE public."UserPreferences" OWNER TO postgres;

--
-- Name: UserWatchLists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserWatchLists" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "userId" character varying(255) NOT NULL,
    "practiceId" character varying(255) NOT NULL,
    "watchListType" public."enum_UserWatchLists_watchListType" DEFAULT 'Practice'::public."enum_UserWatchLists_watchListType",
    "providerId" character varying(255)
);


ALTER TABLE public."UserWatchLists" OWNER TO postgres;

--
-- Name: UserWatchLists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserWatchLists_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UserWatchLists_id_seq" OWNER TO postgres;

--
-- Name: UserWatchLists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserWatchLists_id_seq" OWNED BY public."UserWatchLists".id;


--
-- Name: UtilizationMetrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UtilizationMetrics" (
    id bigint NOT NULL,
    "dataDigestId" bigint NOT NULL,
    "practiceId" integer NOT NULL,
    "intervalType" public."enum_UtilizationMetrics_intervalType" NOT NULL,
    "intervalStart" date NOT NULL,
    "intervalEnd" date NOT NULL,
    views integer,
    "viewsForRealTimeCapturesAndAnalyses" integer,
    "viewsForHistoricCapturesAndRealTimeAnalyses" integer,
    "viewsForHistoricCapturesAndAnalyses" integer,
    "eligiblePatients" integer,
    "eligiblePatientsForRealTimeCapturesAndAnalyses" integer,
    "eligiblePatientsForHistoricCapturesAndRealTimeAnalyses" integer,
    "eligiblePatientsForHistoricCapturesAndAnalyses" integer,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "preparedPatients" integer,
    "reviewedPatients" integer,
    "viewsForLookahead" integer,
    "eligiblePatientsForLookahead" integer
);


ALTER TABLE public."UtilizationMetrics" OWNER TO postgres;

--
-- Name: COLUMN "UtilizationMetrics"."dataDigestId"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."dataDigestId" IS 'soft FOREIGN KEY ("dataDigestId") REFERENCES public."DataDigest" (id)';


--
-- Name: COLUMN "UtilizationMetrics"."intervalType"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."intervalType" IS 'Since all metrics are DISTINCT COUNTS, intervals larger than 1 day compute metrics by interating over each day in the interval and applying set unions.';


--
-- Name: COLUMN "UtilizationMetrics"."intervalStart"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."intervalStart" IS 'Date range is Inclusive';


--
-- Name: COLUMN "UtilizationMetrics"."intervalEnd"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."intervalEnd" IS 'Date range is Inclusive';


--
-- Name: COLUMN "UtilizationMetrics".views; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics".views IS 'Set union of viewsSubCat1, viewsSubCat2, viewsSubCat3';


--
-- Name: COLUMN "UtilizationMetrics"."viewsForRealTimeCapturesAndAnalyses"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."viewsForRealTimeCapturesAndAnalyses" IS 'Count distinct patients with at least one individual image viewed that was acquired and analyzed today.';


--
-- Name: COLUMN "UtilizationMetrics"."viewsForHistoricCapturesAndRealTimeAnalyses"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."viewsForHistoricCapturesAndRealTimeAnalyses" IS 'Count distinct patients with an appointment today with at least one individual image viewed that was acquired BEFORE today and analyzed today.';


--
-- Name: COLUMN "UtilizationMetrics"."viewsForHistoricCapturesAndAnalyses"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."viewsForHistoricCapturesAndAnalyses" IS 'Count distinct patients with an appointment today with at least one individual image viewed that was acquired BEFORE today and analyzed BEFORE.';


--
-- Name: COLUMN "UtilizationMetrics"."eligiblePatients"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."eligiblePatients" IS 'Set union of eligiblePatientsSubCat1, eligiblePatientsSubCat2, eligiblePatientsSubCat3';


--
-- Name: COLUMN "UtilizationMetrics"."eligiblePatientsForRealTimeCapturesAndAnalyses"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."eligiblePatientsForRealTimeCapturesAndAnalyses" IS 'Count distinct patients who got new x-rays analyzed today.';


--
-- Name: COLUMN "UtilizationMetrics"."eligiblePatientsForHistoricCapturesAndRealTimeAnalyses"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."eligiblePatientsForHistoricCapturesAndRealTimeAnalyses" IS 'Count distinct patients who got OLD x-rays acquired before but analyzed today.';


--
-- Name: COLUMN "UtilizationMetrics"."eligiblePatientsForHistoricCapturesAndAnalyses"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."eligiblePatientsForHistoricCapturesAndAnalyses" IS 'Count distinct patients seen by the dentist today (i.e has an appointment today) who got OLD x-rays acquired before but analyzed BEFORE today.';


--
-- Name: COLUMN "UtilizationMetrics"."preparedPatients"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."preparedPatients" IS 'Count distinct patients without an appointment today with at least one individual image viewed today that was analyzed BEFORE today in any flow and have an appointment upcoming in next 3 days.';


--
-- Name: COLUMN "UtilizationMetrics"."reviewedPatients"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."reviewedPatients" IS 'Count distinct patients without an appointment today with at least one individual image viewed today that was analyzed BEFORE today in any flow and who do not have an upcoming appointment in the next 3 days';


--
-- Name: COLUMN "UtilizationMetrics"."viewsForLookahead"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."viewsForLookahead" IS 'Count distinct patients with an appointment today with at least one individual image that was viewed in the past up to 8 days prior that was analyzed BEFORE today.';


--
-- Name: COLUMN "UtilizationMetrics"."eligiblePatientsForLookahead"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."UtilizationMetrics"."eligiblePatientsForLookahead" IS 'Count distinct patients with an appointment today with at least one individual image that was analyzed BEFORE today.';


--
-- Name: UtilizationMetrics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UtilizationMetrics_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UtilizationMetrics_id_seq" OWNER TO postgres;

--
-- Name: UtilizationMetrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UtilizationMetrics_id_seq" OWNED BY public."UtilizationMetrics".id;


--
-- Name: VideaAIModels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VideaAIModels" (
    id bigint NOT NULL,
    version character varying(255) DEFAULT 'v1.0.0'::character varying NOT NULL,
    "videaId" character varying(255) NOT NULL,
    "modelShortName" character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    constraints jsonb,
    "isIRB" boolean DEFAULT false NOT NULL,
    "defaultErrorMessage" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."VideaAIModels" OWNER TO postgres;

--
-- Name: VideaAIModels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."VideaAIModels_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."VideaAIModels_id_seq" OWNER TO postgres;

--
-- Name: VideaAIModels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."VideaAIModels_id_seq" OWNED BY public."VideaAIModels".id;


--
-- Name: VideaPathologyTypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VideaPathologyTypes" (
    id bigint NOT NULL,
    "pathologyName" character varying(255) NOT NULL,
    shape character varying(255) NOT NULL,
    "lineStyle" character varying(255) NOT NULL,
    "defaultLineColor" character varying(255) NOT NULL,
    "defaultShapeFillColor" character varying(255),
    "videaModelId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "isEnabledByDefaultForDDAI" boolean DEFAULT false NOT NULL,
    "correspondingPracticeFeatureFlag" character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."VideaPathologyTypes" OWNER TO postgres;

--
-- Name: VideaPathologyTypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."VideaPathologyTypes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."VideaPathologyTypes_id_seq" OWNER TO postgres;

--
-- Name: VideaPathologyTypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."VideaPathologyTypes_id_seq" OWNED BY public."VideaPathologyTypes".id;


--
-- Name: one_shots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.one_shots (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "completedAt" timestamp with time zone,
    filename text NOT NULL,
    state text DEFAULT 'started'::text NOT NULL,
    attempts integer DEFAULT 1 NOT NULL,
    error text,
    output jsonb
);


ALTER TABLE public.one_shots OWNER TO postgres;

--
-- Name: Events_default; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_default" DEFAULT;


--
-- Name: Events_p2023_07_17; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_17" FOR VALUES FROM ('2023-07-17 00:00:00+00') TO ('2023-07-18 00:00:00+00');


--
-- Name: Events_p2023_07_18; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_18" FOR VALUES FROM ('2023-07-18 00:00:00+00') TO ('2023-07-19 00:00:00+00');


--
-- Name: Events_p2023_07_19; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_19" FOR VALUES FROM ('2023-07-19 00:00:00+00') TO ('2023-07-20 00:00:00+00');


--
-- Name: Events_p2023_07_20; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_20" FOR VALUES FROM ('2023-07-20 00:00:00+00') TO ('2023-07-21 00:00:00+00');


--
-- Name: Events_p2023_07_21; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_21" FOR VALUES FROM ('2023-07-21 00:00:00+00') TO ('2023-07-22 00:00:00+00');


--
-- Name: Events_p2023_07_22; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_22" FOR VALUES FROM ('2023-07-22 00:00:00+00') TO ('2023-07-23 00:00:00+00');


--
-- Name: Events_p2023_07_23; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_23" FOR VALUES FROM ('2023-07-23 00:00:00+00') TO ('2023-07-24 00:00:00+00');


--
-- Name: Events_p2023_07_24; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_24" FOR VALUES FROM ('2023-07-24 00:00:00+00') TO ('2023-07-25 00:00:00+00');


--
-- Name: Events_p2023_07_25; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_25" FOR VALUES FROM ('2023-07-25 00:00:00+00') TO ('2023-07-26 00:00:00+00');


--
-- Name: Events_p2023_07_26; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_26" FOR VALUES FROM ('2023-07-26 00:00:00+00') TO ('2023-07-27 00:00:00+00');


--
-- Name: Events_p2023_07_27; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_27" FOR VALUES FROM ('2023-07-27 00:00:00+00') TO ('2023-07-28 00:00:00+00');


--
-- Name: Events_p2023_07_28; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_28" FOR VALUES FROM ('2023-07-28 00:00:00+00') TO ('2023-07-29 00:00:00+00');


--
-- Name: Events_p2023_07_29; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_29" FOR VALUES FROM ('2023-07-29 00:00:00+00') TO ('2023-07-30 00:00:00+00');


--
-- Name: Events_p2023_07_30; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_30" FOR VALUES FROM ('2023-07-30 00:00:00+00') TO ('2023-07-31 00:00:00+00');


--
-- Name: Events_p2023_07_31; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_07_31" FOR VALUES FROM ('2023-07-31 00:00:00+00') TO ('2023-08-01 00:00:00+00');


--
-- Name: Events_p2023_08_01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_01" FOR VALUES FROM ('2023-08-01 00:00:00+00') TO ('2023-08-02 00:00:00+00');


--
-- Name: Events_p2023_08_02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_02" FOR VALUES FROM ('2023-08-02 00:00:00+00') TO ('2023-08-03 00:00:00+00');


--
-- Name: Events_p2023_08_03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_03" FOR VALUES FROM ('2023-08-03 00:00:00+00') TO ('2023-08-04 00:00:00+00');


--
-- Name: Events_p2023_08_04; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_04" FOR VALUES FROM ('2023-08-04 00:00:00+00') TO ('2023-08-05 00:00:00+00');


--
-- Name: Events_p2023_08_05; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_05" FOR VALUES FROM ('2023-08-05 00:00:00+00') TO ('2023-08-06 00:00:00+00');


--
-- Name: Events_p2023_08_06; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_06" FOR VALUES FROM ('2023-08-06 00:00:00+00') TO ('2023-08-07 00:00:00+00');


--
-- Name: Events_p2023_08_07; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_07" FOR VALUES FROM ('2023-08-07 00:00:00+00') TO ('2023-08-08 00:00:00+00');


--
-- Name: Events_p2023_08_08; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_08" FOR VALUES FROM ('2023-08-08 00:00:00+00') TO ('2023-08-09 00:00:00+00');


--
-- Name: Events_p2023_08_09; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_09" FOR VALUES FROM ('2023-08-09 00:00:00+00') TO ('2023-08-10 00:00:00+00');


--
-- Name: Events_p2023_08_10; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_10" FOR VALUES FROM ('2023-08-10 00:00:00+00') TO ('2023-08-11 00:00:00+00');


--
-- Name: Events_p2023_08_11; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_11" FOR VALUES FROM ('2023-08-11 00:00:00+00') TO ('2023-08-12 00:00:00+00');


--
-- Name: Events_p2023_08_12; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_12" FOR VALUES FROM ('2023-08-12 00:00:00+00') TO ('2023-08-13 00:00:00+00');


--
-- Name: Events_p2023_08_13; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_13" FOR VALUES FROM ('2023-08-13 00:00:00+00') TO ('2023-08-14 00:00:00+00');


--
-- Name: Events_p2023_08_14; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_14" FOR VALUES FROM ('2023-08-14 00:00:00+00') TO ('2023-08-15 00:00:00+00');


--
-- Name: Events_p2023_08_15; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_15" FOR VALUES FROM ('2023-08-15 00:00:00+00') TO ('2023-08-16 00:00:00+00');


--
-- Name: Events_p2023_08_16; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_16" FOR VALUES FROM ('2023-08-16 00:00:00+00') TO ('2023-08-17 00:00:00+00');


--
-- Name: Events_p2023_08_17; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_17" FOR VALUES FROM ('2023-08-17 00:00:00+00') TO ('2023-08-18 00:00:00+00');


--
-- Name: Events_p2023_08_18; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_18" FOR VALUES FROM ('2023-08-18 00:00:00+00') TO ('2023-08-19 00:00:00+00');


--
-- Name: Events_p2023_08_19; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_19" FOR VALUES FROM ('2023-08-19 00:00:00+00') TO ('2023-08-20 00:00:00+00');


--
-- Name: Events_p2023_08_20; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_20" FOR VALUES FROM ('2023-08-20 00:00:00+00') TO ('2023-08-21 00:00:00+00');


--
-- Name: Events_p2023_08_21; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_21" FOR VALUES FROM ('2023-08-21 00:00:00+00') TO ('2023-08-22 00:00:00+00');


--
-- Name: Events_p2023_08_22; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_22" FOR VALUES FROM ('2023-08-22 00:00:00+00') TO ('2023-08-23 00:00:00+00');


--
-- Name: Events_p2023_08_23; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_23" FOR VALUES FROM ('2023-08-23 00:00:00+00') TO ('2023-08-24 00:00:00+00');


--
-- Name: Events_p2023_08_24; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_24" FOR VALUES FROM ('2023-08-24 00:00:00+00') TO ('2023-08-25 00:00:00+00');


--
-- Name: Events_p2023_08_25; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_25" FOR VALUES FROM ('2023-08-25 00:00:00+00') TO ('2023-08-26 00:00:00+00');


--
-- Name: Events_p2023_08_26; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_26" FOR VALUES FROM ('2023-08-26 00:00:00+00') TO ('2023-08-27 00:00:00+00');


--
-- Name: Events_p2023_08_27; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_27" FOR VALUES FROM ('2023-08-27 00:00:00+00') TO ('2023-08-28 00:00:00+00');


--
-- Name: Events_p2023_08_28; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_28" FOR VALUES FROM ('2023-08-28 00:00:00+00') TO ('2023-08-29 00:00:00+00');


--
-- Name: Events_p2023_08_29; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_29" FOR VALUES FROM ('2023-08-29 00:00:00+00') TO ('2023-08-30 00:00:00+00');


--
-- Name: Events_p2023_08_30; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_30" FOR VALUES FROM ('2023-08-30 00:00:00+00') TO ('2023-08-31 00:00:00+00');


--
-- Name: Events_p2023_08_31; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_08_31" FOR VALUES FROM ('2023-08-31 00:00:00+00') TO ('2023-09-01 00:00:00+00');


--
-- Name: Events_p2023_09_01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_01" FOR VALUES FROM ('2023-09-01 00:00:00+00') TO ('2023-09-02 00:00:00+00');


--
-- Name: Events_p2023_09_02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_02" FOR VALUES FROM ('2023-09-02 00:00:00+00') TO ('2023-09-03 00:00:00+00');


--
-- Name: Events_p2023_09_03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_03" FOR VALUES FROM ('2023-09-03 00:00:00+00') TO ('2023-09-04 00:00:00+00');


--
-- Name: Events_p2023_09_04; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_04" FOR VALUES FROM ('2023-09-04 00:00:00+00') TO ('2023-09-05 00:00:00+00');


--
-- Name: Events_p2023_09_05; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_05" FOR VALUES FROM ('2023-09-05 00:00:00+00') TO ('2023-09-06 00:00:00+00');


--
-- Name: Events_p2023_09_06; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_06" FOR VALUES FROM ('2023-09-06 00:00:00+00') TO ('2023-09-07 00:00:00+00');


--
-- Name: Events_p2023_09_07; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_07" FOR VALUES FROM ('2023-09-07 00:00:00+00') TO ('2023-09-08 00:00:00+00');


--
-- Name: Events_p2023_09_08; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_08" FOR VALUES FROM ('2023-09-08 00:00:00+00') TO ('2023-09-09 00:00:00+00');


--
-- Name: Events_p2023_09_09; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_09" FOR VALUES FROM ('2023-09-09 00:00:00+00') TO ('2023-09-10 00:00:00+00');


--
-- Name: Events_p2023_09_10; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_10" FOR VALUES FROM ('2023-09-10 00:00:00+00') TO ('2023-09-11 00:00:00+00');


--
-- Name: Events_p2023_09_11; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_11" FOR VALUES FROM ('2023-09-11 00:00:00+00') TO ('2023-09-12 00:00:00+00');


--
-- Name: Events_p2023_09_12; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_12" FOR VALUES FROM ('2023-09-12 00:00:00+00') TO ('2023-09-13 00:00:00+00');


--
-- Name: Events_p2023_09_13; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_13" FOR VALUES FROM ('2023-09-13 00:00:00+00') TO ('2023-09-14 00:00:00+00');


--
-- Name: Events_p2023_09_14; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_14" FOR VALUES FROM ('2023-09-14 00:00:00+00') TO ('2023-09-15 00:00:00+00');


--
-- Name: Events_p2023_09_15; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_15" FOR VALUES FROM ('2023-09-15 00:00:00+00') TO ('2023-09-16 00:00:00+00');


--
-- Name: Events_p2023_09_16; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_16" FOR VALUES FROM ('2023-09-16 00:00:00+00') TO ('2023-09-17 00:00:00+00');


--
-- Name: Events_p2023_09_17; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_17" FOR VALUES FROM ('2023-09-17 00:00:00+00') TO ('2023-09-18 00:00:00+00');


--
-- Name: Events_p2023_09_18; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_18" FOR VALUES FROM ('2023-09-18 00:00:00+00') TO ('2023-09-19 00:00:00+00');


--
-- Name: Events_p2023_09_19; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_19" FOR VALUES FROM ('2023-09-19 00:00:00+00') TO ('2023-09-20 00:00:00+00');


--
-- Name: Events_p2023_09_20; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_20" FOR VALUES FROM ('2023-09-20 00:00:00+00') TO ('2023-09-21 00:00:00+00');


--
-- Name: Events_p2023_09_21; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_21" FOR VALUES FROM ('2023-09-21 00:00:00+00') TO ('2023-09-22 00:00:00+00');


--
-- Name: Events_p2023_09_22; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_22" FOR VALUES FROM ('2023-09-22 00:00:00+00') TO ('2023-09-23 00:00:00+00');


--
-- Name: Events_p2023_09_23; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_23" FOR VALUES FROM ('2023-09-23 00:00:00+00') TO ('2023-09-24 00:00:00+00');


--
-- Name: Events_p2023_09_24; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_24" FOR VALUES FROM ('2023-09-24 00:00:00+00') TO ('2023-09-25 00:00:00+00');


--
-- Name: Events_p2023_09_25; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_25" FOR VALUES FROM ('2023-09-25 00:00:00+00') TO ('2023-09-26 00:00:00+00');


--
-- Name: Events_p2023_09_26; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_26" FOR VALUES FROM ('2023-09-26 00:00:00+00') TO ('2023-09-27 00:00:00+00');


--
-- Name: Events_p2023_09_27; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_27" FOR VALUES FROM ('2023-09-27 00:00:00+00') TO ('2023-09-28 00:00:00+00');


--
-- Name: Events_p2023_09_28; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_28" FOR VALUES FROM ('2023-09-28 00:00:00+00') TO ('2023-09-29 00:00:00+00');


--
-- Name: Events_p2023_09_29; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_29" FOR VALUES FROM ('2023-09-29 00:00:00+00') TO ('2023-09-30 00:00:00+00');


--
-- Name: Events_p2023_09_30; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_09_30" FOR VALUES FROM ('2023-09-30 00:00:00+00') TO ('2023-10-01 00:00:00+00');


--
-- Name: Events_p2023_10_01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_01" FOR VALUES FROM ('2023-10-01 00:00:00+00') TO ('2023-10-02 00:00:00+00');


--
-- Name: Events_p2023_10_02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_02" FOR VALUES FROM ('2023-10-02 00:00:00+00') TO ('2023-10-03 00:00:00+00');


--
-- Name: Events_p2023_10_03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_03" FOR VALUES FROM ('2023-10-03 00:00:00+00') TO ('2023-10-04 00:00:00+00');


--
-- Name: Events_p2023_10_04; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_04" FOR VALUES FROM ('2023-10-04 00:00:00+00') TO ('2023-10-05 00:00:00+00');


--
-- Name: Events_p2023_10_05; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_05" FOR VALUES FROM ('2023-10-05 00:00:00+00') TO ('2023-10-06 00:00:00+00');


--
-- Name: Events_p2023_10_06; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_06" FOR VALUES FROM ('2023-10-06 00:00:00+00') TO ('2023-10-07 00:00:00+00');


--
-- Name: Events_p2023_10_07; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_07" FOR VALUES FROM ('2023-10-07 00:00:00+00') TO ('2023-10-08 00:00:00+00');


--
-- Name: Events_p2023_10_08; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_08" FOR VALUES FROM ('2023-10-08 00:00:00+00') TO ('2023-10-09 00:00:00+00');


--
-- Name: Events_p2023_10_09; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_09" FOR VALUES FROM ('2023-10-09 00:00:00+00') TO ('2023-10-10 00:00:00+00');


--
-- Name: Events_p2023_10_10; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_10" FOR VALUES FROM ('2023-10-10 00:00:00+00') TO ('2023-10-11 00:00:00+00');


--
-- Name: Events_p2023_10_11; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_11" FOR VALUES FROM ('2023-10-11 00:00:00+00') TO ('2023-10-12 00:00:00+00');


--
-- Name: Events_p2023_10_12; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_12" FOR VALUES FROM ('2023-10-12 00:00:00+00') TO ('2023-10-13 00:00:00+00');


--
-- Name: Events_p2023_10_13; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_13" FOR VALUES FROM ('2023-10-13 00:00:00+00') TO ('2023-10-14 00:00:00+00');


--
-- Name: Events_p2023_10_14; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_14" FOR VALUES FROM ('2023-10-14 00:00:00+00') TO ('2023-10-15 00:00:00+00');


--
-- Name: Events_p2023_10_15; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_15" FOR VALUES FROM ('2023-10-15 00:00:00+00') TO ('2023-10-16 00:00:00+00');


--
-- Name: Events_p2023_10_16; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_16" FOR VALUES FROM ('2023-10-16 00:00:00+00') TO ('2023-10-17 00:00:00+00');


--
-- Name: Events_p2023_10_17; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_17" FOR VALUES FROM ('2023-10-17 00:00:00+00') TO ('2023-10-18 00:00:00+00');


--
-- Name: Events_p2023_10_18; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_18" FOR VALUES FROM ('2023-10-18 00:00:00+00') TO ('2023-10-19 00:00:00+00');


--
-- Name: Events_p2023_10_19; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_19" FOR VALUES FROM ('2023-10-19 00:00:00+00') TO ('2023-10-20 00:00:00+00');


--
-- Name: Events_p2023_10_20; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_20" FOR VALUES FROM ('2023-10-20 00:00:00+00') TO ('2023-10-21 00:00:00+00');


--
-- Name: Events_p2023_10_21; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_21" FOR VALUES FROM ('2023-10-21 00:00:00+00') TO ('2023-10-22 00:00:00+00');


--
-- Name: Events_p2023_10_22; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_22" FOR VALUES FROM ('2023-10-22 00:00:00+00') TO ('2023-10-23 00:00:00+00');


--
-- Name: Events_p2023_10_23; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_23" FOR VALUES FROM ('2023-10-23 00:00:00+00') TO ('2023-10-24 00:00:00+00');


--
-- Name: Events_p2023_10_24; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_24" FOR VALUES FROM ('2023-10-24 00:00:00+00') TO ('2023-10-25 00:00:00+00');


--
-- Name: Events_p2023_10_25; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_25" FOR VALUES FROM ('2023-10-25 00:00:00+00') TO ('2023-10-26 00:00:00+00');


--
-- Name: Events_p2023_10_26; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_26" FOR VALUES FROM ('2023-10-26 00:00:00+00') TO ('2023-10-27 00:00:00+00');


--
-- Name: Events_p2023_10_27; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_27" FOR VALUES FROM ('2023-10-27 00:00:00+00') TO ('2023-10-28 00:00:00+00');


--
-- Name: Events_p2023_10_28; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_28" FOR VALUES FROM ('2023-10-28 00:00:00+00') TO ('2023-10-29 00:00:00+00');


--
-- Name: Events_p2023_10_29; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_29" FOR VALUES FROM ('2023-10-29 00:00:00+00') TO ('2023-10-30 00:00:00+00');


--
-- Name: Events_p2023_10_30; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_30" FOR VALUES FROM ('2023-10-30 00:00:00+00') TO ('2023-10-31 00:00:00+00');


--
-- Name: Events_p2023_10_31; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_10_31" FOR VALUES FROM ('2023-10-31 00:00:00+00') TO ('2023-11-01 00:00:00+00');


--
-- Name: Events_p2023_11_01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_01" FOR VALUES FROM ('2023-11-01 00:00:00+00') TO ('2023-11-02 00:00:00+00');


--
-- Name: Events_p2023_11_02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_02" FOR VALUES FROM ('2023-11-02 00:00:00+00') TO ('2023-11-03 00:00:00+00');


--
-- Name: Events_p2023_11_03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_03" FOR VALUES FROM ('2023-11-03 00:00:00+00') TO ('2023-11-04 00:00:00+00');


--
-- Name: Events_p2023_11_04; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_04" FOR VALUES FROM ('2023-11-04 00:00:00+00') TO ('2023-11-05 00:00:00+00');


--
-- Name: Events_p2023_11_05; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_05" FOR VALUES FROM ('2023-11-05 00:00:00+00') TO ('2023-11-06 00:00:00+00');


--
-- Name: Events_p2023_11_06; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_06" FOR VALUES FROM ('2023-11-06 00:00:00+00') TO ('2023-11-07 00:00:00+00');


--
-- Name: Events_p2023_11_07; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_07" FOR VALUES FROM ('2023-11-07 00:00:00+00') TO ('2023-11-08 00:00:00+00');


--
-- Name: Events_p2023_11_08; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_08" FOR VALUES FROM ('2023-11-08 00:00:00+00') TO ('2023-11-09 00:00:00+00');


--
-- Name: Events_p2023_11_09; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_09" FOR VALUES FROM ('2023-11-09 00:00:00+00') TO ('2023-11-10 00:00:00+00');


--
-- Name: Events_p2023_11_10; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_10" FOR VALUES FROM ('2023-11-10 00:00:00+00') TO ('2023-11-11 00:00:00+00');


--
-- Name: Events_p2023_11_11; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_11" FOR VALUES FROM ('2023-11-11 00:00:00+00') TO ('2023-11-12 00:00:00+00');


--
-- Name: Events_p2023_11_12; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_12" FOR VALUES FROM ('2023-11-12 00:00:00+00') TO ('2023-11-13 00:00:00+00');


--
-- Name: Events_p2023_11_13; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_13" FOR VALUES FROM ('2023-11-13 00:00:00+00') TO ('2023-11-14 00:00:00+00');


--
-- Name: Events_p2023_11_14; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_14" FOR VALUES FROM ('2023-11-14 00:00:00+00') TO ('2023-11-15 00:00:00+00');


--
-- Name: Events_p2023_11_15; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_15" FOR VALUES FROM ('2023-11-15 00:00:00+00') TO ('2023-11-16 00:00:00+00');


--
-- Name: Events_p2023_11_16; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_16" FOR VALUES FROM ('2023-11-16 00:00:00+00') TO ('2023-11-17 00:00:00+00');


--
-- Name: Events_p2023_11_17; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_17" FOR VALUES FROM ('2023-11-17 00:00:00+00') TO ('2023-11-18 00:00:00+00');


--
-- Name: Events_p2023_11_18; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_18" FOR VALUES FROM ('2023-11-18 00:00:00+00') TO ('2023-11-19 00:00:00+00');


--
-- Name: Events_p2023_11_19; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_19" FOR VALUES FROM ('2023-11-19 00:00:00+00') TO ('2023-11-20 00:00:00+00');


--
-- Name: Events_p2023_11_20; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_20" FOR VALUES FROM ('2023-11-20 00:00:00+00') TO ('2023-11-21 00:00:00+00');


--
-- Name: Events_p2023_11_21; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_21" FOR VALUES FROM ('2023-11-21 00:00:00+00') TO ('2023-11-22 00:00:00+00');


--
-- Name: Events_p2023_11_22; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_22" FOR VALUES FROM ('2023-11-22 00:00:00+00') TO ('2023-11-23 00:00:00+00');


--
-- Name: Events_p2023_11_23; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_23" FOR VALUES FROM ('2023-11-23 00:00:00+00') TO ('2023-11-24 00:00:00+00');


--
-- Name: Events_p2023_11_24; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_24" FOR VALUES FROM ('2023-11-24 00:00:00+00') TO ('2023-11-25 00:00:00+00');


--
-- Name: Events_p2023_11_25; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_25" FOR VALUES FROM ('2023-11-25 00:00:00+00') TO ('2023-11-26 00:00:00+00');


--
-- Name: Events_p2023_11_26; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_26" FOR VALUES FROM ('2023-11-26 00:00:00+00') TO ('2023-11-27 00:00:00+00');


--
-- Name: Events_p2023_11_27; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_27" FOR VALUES FROM ('2023-11-27 00:00:00+00') TO ('2023-11-28 00:00:00+00');


--
-- Name: Events_p2023_11_28; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_28" FOR VALUES FROM ('2023-11-28 00:00:00+00') TO ('2023-11-29 00:00:00+00');


--
-- Name: Events_p2023_11_29; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_29" FOR VALUES FROM ('2023-11-29 00:00:00+00') TO ('2023-11-30 00:00:00+00');


--
-- Name: Events_p2023_11_30; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_11_30" FOR VALUES FROM ('2023-11-30 00:00:00+00') TO ('2023-12-01 00:00:00+00');


--
-- Name: Events_p2023_12_01; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_01" FOR VALUES FROM ('2023-12-01 00:00:00+00') TO ('2023-12-02 00:00:00+00');


--
-- Name: Events_p2023_12_02; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_02" FOR VALUES FROM ('2023-12-02 00:00:00+00') TO ('2023-12-03 00:00:00+00');


--
-- Name: Events_p2023_12_03; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_03" FOR VALUES FROM ('2023-12-03 00:00:00+00') TO ('2023-12-04 00:00:00+00');


--
-- Name: Events_p2023_12_04; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_04" FOR VALUES FROM ('2023-12-04 00:00:00+00') TO ('2023-12-05 00:00:00+00');


--
-- Name: Events_p2023_12_05; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_05" FOR VALUES FROM ('2023-12-05 00:00:00+00') TO ('2023-12-06 00:00:00+00');


--
-- Name: Events_p2023_12_06; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_06" FOR VALUES FROM ('2023-12-06 00:00:00+00') TO ('2023-12-07 00:00:00+00');


--
-- Name: Events_p2023_12_07; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_07" FOR VALUES FROM ('2023-12-07 00:00:00+00') TO ('2023-12-08 00:00:00+00');


--
-- Name: Events_p2023_12_08; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_08" FOR VALUES FROM ('2023-12-08 00:00:00+00') TO ('2023-12-09 00:00:00+00');


--
-- Name: Events_p2023_12_09; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_09" FOR VALUES FROM ('2023-12-09 00:00:00+00') TO ('2023-12-10 00:00:00+00');


--
-- Name: Events_p2023_12_10; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_10" FOR VALUES FROM ('2023-12-10 00:00:00+00') TO ('2023-12-11 00:00:00+00');


--
-- Name: Events_p2023_12_11; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_11" FOR VALUES FROM ('2023-12-11 00:00:00+00') TO ('2023-12-12 00:00:00+00');


--
-- Name: Events_p2023_12_12; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_12" FOR VALUES FROM ('2023-12-12 00:00:00+00') TO ('2023-12-13 00:00:00+00');


--
-- Name: Events_p2023_12_13; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_13" FOR VALUES FROM ('2023-12-13 00:00:00+00') TO ('2023-12-14 00:00:00+00');


--
-- Name: Events_p2023_12_14; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ATTACH PARTITION public."Events_p2023_12_14" FOR VALUES FROM ('2023-12-14 00:00:00+00') TO ('2023-12-15 00:00:00+00');


--
-- Name: ProductionCollections id; Type: DEFAULT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProductionCollections" ALTER COLUMN id SET DEFAULT nextval('"DentrixAscend"."ProductionCollections_id_seq"'::regclass);


--
-- Name: ProductionCollectionsAudit id; Type: DEFAULT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProductionCollectionsAudit" ALTER COLUMN id SET DEFAULT nextval('"DentrixAscend"."ProductionCollectionsAudit_id_seq"'::regclass);


--
-- Name: Appointments id; Type: DEFAULT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Appointments" ALTER COLUMN id SET DEFAULT nextval('"DentrixCore"."Appointments_id_seq"'::regclass);


--
-- Name: Patients id; Type: DEFAULT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Patients" ALTER COLUMN id SET DEFAULT nextval('"DentrixCore"."Patients_id_seq"'::regclass);


--
-- Name: Providers id; Type: DEFAULT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Providers" ALTER COLUMN id SET DEFAULT nextval('"DentrixCore"."Providers_id_seq"'::regclass);


--
-- Name: Treatments id; Type: DEFAULT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Treatments" ALTER COLUMN id SET DEFAULT nextval('"DentrixCore"."Treatments_id_seq"'::regclass);


--
-- Name: AnonymizedImageMetadata id; Type: DEFAULT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."AnonymizedImageMetadata" ALTER COLUMN id SET DEFAULT nextval('"NonPhi"."AnonymizedImageMetadata_id_seq"'::regclass);


--
-- Name: ImageManifests id; Type: DEFAULT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."ImageManifests" ALTER COLUMN id SET DEFAULT nextval('"NonPhi"."ImageManifests_id_seq"'::regclass);


--
-- Name: Appointments id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Appointments" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."Appointments_id_seq"'::regclass);


--
-- Name: AppointmentsAudit id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."AppointmentsAudit" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."AppointmentsAudit_id_seq"'::regclass);


--
-- Name: Operatories id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Operatories" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."Operatories_id_seq"'::regclass);


--
-- Name: OperatoriesAudit id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."OperatoriesAudit" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."OperatoriesAudit_id_seq"'::regclass);


--
-- Name: Patients id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Patients" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."Patients_id_seq"'::regclass);


--
-- Name: PatientsAudit id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."PatientsAudit" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."PatientsAudit_id_seq"'::regclass);


--
-- Name: ProcedureLogs id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProcedureLogs" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."ProcedureLogs_id_seq"'::regclass);


--
-- Name: ProcedureLogsAudit id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProcedureLogsAudit" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."ProcedureLogsAudit_id_seq"'::regclass);


--
-- Name: Providers id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Providers" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."Providers_id_seq"'::regclass);


--
-- Name: ProvidersAudit id; Type: DEFAULT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProvidersAudit" ALTER COLUMN id SET DEFAULT nextval('"OpenDental"."ProvidersAudit_id_seq"'::regclass);


--
-- Name: PhiImageMetadata id; Type: DEFAULT; Schema: Phi; Owner: postgres
--

ALTER TABLE ONLY "Phi"."PhiImageMetadata" ALTER COLUMN id SET DEFAULT nextval('"Phi"."PhiImageMetadata_id_seq"'::regclass);


--
-- Name: AnalyzedImages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnalyzedImages" ALTER COLUMN id SET DEFAULT nextval('public."AnalyzedImages_id_seq"'::regclass);


--
-- Name: ConnectorBackfillConfigs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConnectorBackfillConfigs" ALTER COLUMN id SET DEFAULT nextval('public."ConnectorBackfillConfigs_id_seq"'::regclass);


--
-- Name: CustomerProviders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerProviders" ALTER COLUMN id SET DEFAULT nextval('public."CustomerProviders_id_seq"'::regclass);


--
-- Name: CustomerTreatments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerTreatments" ALTER COLUMN id SET DEFAULT nextval('public."CustomerTreatments_id_seq"'::regclass);


--
-- Name: CustomerTreatmentsAggregations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerTreatmentsAggregations" ALTER COLUMN id SET DEFAULT nextval('public."CustomerTreatmentsAggregations_id_seq"'::regclass);


--
-- Name: DataDigest id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigest" ALTER COLUMN id SET DEFAULT nextval('public."DataDigest_id_seq"'::regclass);


--
-- Name: DataDigestMeta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigestMeta" ALTER COLUMN id SET DEFAULT nextval('public."DataDigestMeta_id_seq"'::regclass);


--
-- Name: DataUploadAudit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataUploadAudit" ALTER COLUMN id SET DEFAULT nextval('public."DataUploadAudit_id_seq"'::regclass);


--
-- Name: DataUploadTriggers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataUploadTriggers" ALTER COLUMN id SET DEFAULT nextval('public."DataUploadTriggers_id_seq"'::regclass);


--
-- Name: EntityAliases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EntityAliases" ALTER COLUMN id SET DEFAULT nextval('public."EntityAliases_id_seq"'::regclass);


--
-- Name: EstimatedVisit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstimatedVisit" ALTER COLUMN id SET DEFAULT nextval('public."EstimatedVisit_id_seq"'::regclass);


--
-- Name: Events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events" ALTER COLUMN id SET DEFAULT nextval('public."Events_id_seq1"'::regclass);


--
-- Name: Events_archive id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_archive" ALTER COLUMN id SET DEFAULT nextval('public."Events_id_seq"'::regclass);


--
-- Name: ExternalAccessTokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExternalAccessTokens" ALTER COLUMN id SET DEFAULT nextval('public."ExternalAccessTokens_id_seq"'::regclass);


--
-- Name: ExternalLocationSecrets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExternalLocationSecrets" ALTER COLUMN id SET DEFAULT nextval('public."ExternalLocationSecrets_id_seq"'::regclass);


--
-- Name: ImageAnalysisMirrors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageAnalysisMirrors" ALTER COLUMN id SET DEFAULT nextval('public."ImageAnalysisMirrors_id_seq"'::regclass);


--
-- Name: ImageCatalog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageCatalog" ALTER COLUMN id SET DEFAULT nextval('public."ImageCatalog_id_seq"'::regclass);


--
-- Name: ImagingPatientIdentifiers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientIdentifiers" ALTER COLUMN id SET DEFAULT nextval('public."ImagingPatientIdentifiers_id_seq"'::regclass);


--
-- Name: ImagingPatients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients" ALTER COLUMN id SET DEFAULT nextval('public."Patients_id_seq"'::regclass);


--
-- Name: ImagingPatientsSources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientsSources" ALTER COLUMN id SET DEFAULT nextval('public."ImagingPatientsSources_id_seq"'::regclass);


--
-- Name: InsightsAggregateMetrics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InsightsAggregateMetrics" ALTER COLUMN id SET DEFAULT nextval('public."InsightsAggregateMetrics_id_seq"'::regclass);


--
-- Name: IntegrationJobAudit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationJobAudit" ALTER COLUMN id SET DEFAULT nextval('public."IntegrationJobAudit_id_seq"'::regclass);


--
-- Name: IntegrationJobRuns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationJobRuns" ALTER COLUMN id SET DEFAULT nextval('public."IntegrationJobRuns_id_seq"'::regclass);


--
-- Name: MagicLink id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MagicLink" ALTER COLUMN id SET DEFAULT nextval('public."MagicLink_id_seq"'::regclass);


--
-- Name: Organizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Organizations" ALTER COLUMN id SET DEFAULT nextval('public."Organizations_id_seq"'::regclass);


--
-- Name: PatientIdMatches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PatientIdMatches" ALTER COLUMN id SET DEFAULT nextval('public."PatientIdMatches_id_seq"'::regclass);


--
-- Name: PmsAppointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments" ALTER COLUMN id SET DEFAULT nextval('public."PmsAppointments_id_seq"'::regclass);


--
-- Name: PmsDataIngestionContext id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsDataIngestionContext" ALTER COLUMN id SET DEFAULT nextval('public."PmsDataIngestionContext_id_seq"'::regclass);


--
-- Name: PmsOperatories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsOperatories" ALTER COLUMN id SET DEFAULT nextval('public."PmsOperatories_id_seq"'::regclass);


--
-- Name: PmsPatientViewCounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatientViewCounts" ALTER COLUMN id SET DEFAULT nextval('public."PmsPatientViewCounts_id_seq"'::regclass);


--
-- Name: PmsPatients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatients" ALTER COLUMN id SET DEFAULT nextval('public."PmsPatients_id_seq"'::regclass);


--
-- Name: PmsProviders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsProviders" ALTER COLUMN id SET DEFAULT nextval('public."PmsProviders_id_seq"'::regclass);


--
-- Name: PmsTreatments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatments" ALTER COLUMN id SET DEFAULT nextval('public."PmsTreatments_id_seq"'::regclass);


--
-- Name: Practices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Practices" ALTER COLUMN id SET DEFAULT nextval('public."Practices_id_seq"'::regclass);


--
-- Name: ProductKeys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductKeys" ALTER COLUMN id SET DEFAULT nextval('public."ProductKeys_id_seq"'::regclass);


--
-- Name: ProvisionedEntities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProvisionedEntities" ALTER COLUMN id SET DEFAULT nextval('public."ProvisionedEntities_id_seq"'::regclass);


--
-- Name: QuarantineImages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuarantineImages" ALTER COLUMN id SET DEFAULT nextval('public."QuarantineImages_id_seq"'::regclass);


--
-- Name: UnifiedAppointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments" ALTER COLUMN id SET DEFAULT nextval('public."UnifiedAppointments_id_seq"'::regclass);


--
-- Name: UserEvents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEvents" ALTER COLUMN id SET DEFAULT nextval('public."UserEvents_id_seq"'::regclass);


--
-- Name: UserWatchLists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserWatchLists" ALTER COLUMN id SET DEFAULT nextval('public."UserWatchLists_id_seq"'::regclass);


--
-- Name: UtilizationMetrics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UtilizationMetrics" ALTER COLUMN id SET DEFAULT nextval('public."UtilizationMetrics_id_seq"'::regclass);


--
-- Name: VideaAIModels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaAIModels" ALTER COLUMN id SET DEFAULT nextval('public."VideaAIModels_id_seq"'::regclass);


--
-- Name: VideaPathologyTypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaPathologyTypes" ALTER COLUMN id SET DEFAULT nextval('public."VideaPathologyTypes_id_seq"'::regclass);


--
-- Name: AppointmentDetailsAudit AppointmentDetailsAudit_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."AppointmentDetailsAudit"
    ADD CONSTRAINT "AppointmentDetailsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: AppointmentDetails AppointmentDetails_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."AppointmentDetails"
    ADD CONSTRAINT "AppointmentDetails_pkey" PRIMARY KEY (id);


--
-- Name: AppointmentHeadersAudit AppointmentHeadersAudit_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."AppointmentHeadersAudit"
    ADD CONSTRAINT "AppointmentHeadersAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: AppointmentHeaders AppointmentHeaders_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."AppointmentHeaders"
    ADD CONSTRAINT "AppointmentHeaders_pkey" PRIMARY KEY (id);


--
-- Name: OperatoriesAudit OperatoriesAudit_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."OperatoriesAudit"
    ADD CONSTRAINT "OperatoriesAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Operatories Operatories_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."Operatories"
    ADD CONSTRAINT "Operatories_pkey" PRIMARY KEY (id);


--
-- Name: PatientsAudit PatientsAudit_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Patients Patients_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."Patients"
    ADD CONSTRAINT "Patients_pkey" PRIMARY KEY (id);


--
-- Name: ProvidersAudit ProvidersAudit_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Providers Providers_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."Providers"
    ADD CONSTRAINT "Providers_pkey" PRIMARY KEY (id);


--
-- Name: TreatmentPlansAudit TreatmentPlansAudit_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."TreatmentPlansAudit"
    ADD CONSTRAINT "TreatmentPlansAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: TreatmentPlans TreatmentPlans_pkey; Type: CONSTRAINT; Schema: Denticon; Owner: postgres
--

ALTER TABLE ONLY "Denticon"."TreatmentPlans"
    ADD CONSTRAINT "TreatmentPlans_pkey" PRIMARY KEY (id);


--
-- Name: AppointmentsAudit AppointmentsAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."AppointmentsAudit"
    ADD CONSTRAINT "AppointmentsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Appointments Appointments_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."Appointments"
    ADD CONSTRAINT "Appointments_pkey" PRIMARY KEY (id);


--
-- Name: OperatoriesAudit OperatoriesAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."OperatoriesAudit"
    ADD CONSTRAINT "OperatoriesAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Operatories Operatories_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."Operatories"
    ADD CONSTRAINT "Operatories_pkey" PRIMARY KEY (id);


--
-- Name: PatientProceduresAudit PatientProceduresAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PatientProceduresAudit"
    ADD CONSTRAINT "PatientProceduresAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: PatientProcedures PatientProcedures_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PatientProcedures"
    ADD CONSTRAINT "PatientProcedures_pkey" PRIMARY KEY (id);


--
-- Name: PatientsAudit PatientsAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Patients Patients_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."Patients"
    ADD CONSTRAINT "Patients_pkey" PRIMARY KEY (id);


--
-- Name: PracticeProceduresAudit PracticeProceduresAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PracticeProceduresAudit"
    ADD CONSTRAINT "PracticeProceduresAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: PracticeProcedures PracticeProcedures_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."PracticeProcedures"
    ADD CONSTRAINT "PracticeProcedures_pkey" PRIMARY KEY (id);


--
-- Name: ProductionCollectionsAudit ProductionCollectionsAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProductionCollectionsAudit"
    ADD CONSTRAINT "ProductionCollectionsAudit_pkey" PRIMARY KEY (id);


--
-- Name: ProductionCollections ProductionCollections_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProductionCollections"
    ADD CONSTRAINT "ProductionCollections_pkey" PRIMARY KEY (id);


--
-- Name: ProvidersAudit ProvidersAudit_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Providers Providers_pkey; Type: CONSTRAINT; Schema: DentrixAscend; Owner: postgres
--

ALTER TABLE ONLY "DentrixAscend"."Providers"
    ADD CONSTRAINT "Providers_pkey" PRIMARY KEY (id);


--
-- Name: AppointmentsAudit AppointmentsAudit_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."AppointmentsAudit"
    ADD CONSTRAINT "AppointmentsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Appointments Appointments_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Appointments"
    ADD CONSTRAINT "Appointments_pkey" PRIMARY KEY (id);


--
-- Name: PatientsAudit PatientsAudit_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Patients Patients_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Patients"
    ADD CONSTRAINT "Patients_pkey" PRIMARY KEY (id);


--
-- Name: ProvidersAudit ProvidersAudit_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Providers Providers_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Providers"
    ADD CONSTRAINT "Providers_pkey" PRIMARY KEY (id);


--
-- Name: TreatmentsAudit TreatmentsAudit_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."TreatmentsAudit"
    ADD CONSTRAINT "TreatmentsAudit_pkey" PRIMARY KEY ("integrationJobRunId", id);


--
-- Name: Treatments Treatments_pkey; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Treatments"
    ADD CONSTRAINT "Treatments_pkey" PRIMARY KEY (id);


--
-- Name: Appointments unique_constraint_appointmentId_practiceId; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Appointments"
    ADD CONSTRAINT "unique_constraint_appointmentId_practiceId" UNIQUE ("appointmentId", "practiceId");


--
-- Name: Patients unique_constraint_patientId_practiceId; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Patients"
    ADD CONSTRAINT "unique_constraint_patientId_practiceId" UNIQUE ("patientId", "practiceId");


--
-- Name: Providers unique_constraint_providerId_practiceId; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Providers"
    ADD CONSTRAINT "unique_constraint_providerId_practiceId" UNIQUE ("providerId", "practiceId");


--
-- Name: Treatments unique_constraint_treatmentId_practiceId; Type: CONSTRAINT; Schema: DentrixCore; Owner: postgres
--

ALTER TABLE ONLY "DentrixCore"."Treatments"
    ADD CONSTRAINT "unique_constraint_treatmentId_practiceId" UNIQUE ("treatmentId", "practiceId");


--
-- Name: DDB_APPT_BASE DDB_APPT_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise11.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise11.0"."DDB_APPT_BASE"
    ADD CONSTRAINT "DDB_APPT_BASE_pkey" PRIMARY KEY ("APPTID", "APPTDB");


--
-- Name: DDB_APPT_PROCCODE_BASE DDB_APPT_PROCCODE_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise11.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise11.0"."DDB_APPT_PROCCODE_BASE"
    ADD CONSTRAINT "DDB_APPT_PROCCODE_BASE_pkey" PRIMARY KEY ("APPTPROCID", "APPTPROCDB");


--
-- Name: DDB_APPT_SCHEDULE_BASE DDB_APPT_SCHEDULE_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise11.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise11.0"."DDB_APPT_SCHEDULE_BASE"
    ADD CONSTRAINT "DDB_APPT_SCHEDULE_BASE_pkey" PRIMARY KEY ("ApptScheduleID", "ApptScheduleDB");


--
-- Name: DDB_PAT_BASE DDB_PAT_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise11.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise11.0"."DDB_PAT_BASE"
    ADD CONSTRAINT "DDB_PAT_BASE_pkey" PRIMARY KEY ("PATID", "PATDB");


--
-- Name: DDB_PROC_CODE_BASE DDB_PROC_CODE_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise11.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise11.0"."DDB_PROC_CODE_BASE"
    ADD CONSTRAINT "DDB_PROC_CODE_BASE_pkey" PRIMARY KEY ("PROC_CODEID", "PROC_CODEDB");


--
-- Name: DDB_RSC_BASE DDB_RSC_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise11.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise11.0"."DDB_RSC_BASE"
    ADD CONSTRAINT "DDB_RSC_BASE_pkey" PRIMARY KEY ("URSCID", "RSCDB");


--
-- Name: DDB_APPT_BASE DDB_APPT_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise8.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise8.0"."DDB_APPT_BASE"
    ADD CONSTRAINT "DDB_APPT_BASE_pkey" PRIMARY KEY ("APPTID", "APPTDB");


--
-- Name: DDB_APPT_SCHEDULE_BASE DDB_APPT_SCHEDULE_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise8.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise8.0"."DDB_APPT_SCHEDULE_BASE"
    ADD CONSTRAINT "DDB_APPT_SCHEDULE_BASE_pkey" PRIMARY KEY ("ApptScheduleID", "ApptScheduleDB");


--
-- Name: DDB_PAT_BASE DDB_PAT_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise8.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise8.0"."DDB_PAT_BASE"
    ADD CONSTRAINT "DDB_PAT_BASE_pkey" PRIMARY KEY ("PATID", "PATDB");


--
-- Name: DDB_PROC_CODE_BASE DDB_PROC_CODE_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise8.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise8.0"."DDB_PROC_CODE_BASE"
    ADD CONSTRAINT "DDB_PROC_CODE_BASE_pkey" PRIMARY KEY ("PROC_CODEID", "PROC_CODEDB");


--
-- Name: DDB_RSC_BASE DDB_RSC_BASE_pkey; Type: CONSTRAINT; Schema: DentrixEnterprise8.0; Owner: postgres
--

ALTER TABLE ONLY "DentrixEnterprise8.0"."DDB_RSC_BASE"
    ADD CONSTRAINT "DDB_RSC_BASE_pkey" PRIMARY KEY ("URSCID", "RSCDB");


--
-- Name: AnonymizedImageMetadata AnonymizedImageMetadata_pkey; Type: CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."AnonymizedImageMetadata"
    ADD CONSTRAINT "AnonymizedImageMetadata_pkey" PRIMARY KEY (id);


--
-- Name: FolderHashToChartNum FolderHashToChartNum_pkey; Type: CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."FolderHashToChartNum"
    ADD CONSTRAINT "FolderHashToChartNum_pkey" PRIMARY KEY (id);


--
-- Name: ImageManifests ImageManifests_fileContentHash_key; Type: CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."ImageManifests"
    ADD CONSTRAINT "ImageManifests_fileContentHash_key" UNIQUE ("fileContentHash");


--
-- Name: ImageManifests ImageManifests_pkey; Type: CONSTRAINT; Schema: NonPhi; Owner: postgres
--

ALTER TABLE ONLY "NonPhi"."ImageManifests"
    ADD CONSTRAINT "ImageManifests_pkey" PRIMARY KEY (id);


--
-- Name: AppointmentsAudit AppointmentsAudit_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."AppointmentsAudit"
    ADD CONSTRAINT "AppointmentsAudit_pkey" PRIMARY KEY (id);


--
-- Name: Appointments Appointments_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Appointments"
    ADD CONSTRAINT "Appointments_pkey" PRIMARY KEY (id);


--
-- Name: OperatoriesAudit OperatoriesAudit_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."OperatoriesAudit"
    ADD CONSTRAINT "OperatoriesAudit_pkey" PRIMARY KEY (id);


--
-- Name: Operatories Operatories_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Operatories"
    ADD CONSTRAINT "Operatories_pkey" PRIMARY KEY (id);


--
-- Name: PatientsAudit PatientsAudit_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."PatientsAudit"
    ADD CONSTRAINT "PatientsAudit_pkey" PRIMARY KEY (id);


--
-- Name: Patients Patients_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Patients"
    ADD CONSTRAINT "Patients_pkey" PRIMARY KEY (id);


--
-- Name: ProcedureLogsAudit ProcedureLogsAudit_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProcedureLogsAudit"
    ADD CONSTRAINT "ProcedureLogsAudit_pkey" PRIMARY KEY (id);


--
-- Name: ProcedureLogs ProcedureLogs_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProcedureLogs"
    ADD CONSTRAINT "ProcedureLogs_pkey" PRIMARY KEY (id);


--
-- Name: ProvidersAudit ProvidersAudit_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProvidersAudit"
    ADD CONSTRAINT "ProvidersAudit_pkey" PRIMARY KEY (id);


--
-- Name: Providers Providers_pkey; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Providers"
    ADD CONSTRAINT "Providers_pkey" PRIMARY KEY (id);


--
-- Name: Appointments unique_constraint_open_dental_practiceId_aptNum; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Appointments"
    ADD CONSTRAINT "unique_constraint_open_dental_practiceId_aptNum" UNIQUE ("practiceId", "AptNum");


--
-- Name: Operatories unique_constraint_open_dental_practiceId_operatoryNum; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Operatories"
    ADD CONSTRAINT "unique_constraint_open_dental_practiceId_operatoryNum" UNIQUE ("practiceId", "OperatoryNum");


--
-- Name: Patients unique_constraint_open_dental_practiceId_patNum; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Patients"
    ADD CONSTRAINT "unique_constraint_open_dental_practiceId_patNum" UNIQUE ("practiceId", "PatNum");


--
-- Name: ProcedureLogs unique_constraint_open_dental_practiceId_procNum; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."ProcedureLogs"
    ADD CONSTRAINT "unique_constraint_open_dental_practiceId_procNum" UNIQUE ("practiceId", "ProcNum");


--
-- Name: Providers unique_constraint_open_dental_practiceId_provNum; Type: CONSTRAINT; Schema: OpenDental; Owner: postgres
--

ALTER TABLE ONLY "OpenDental"."Providers"
    ADD CONSTRAINT "unique_constraint_open_dental_practiceId_provNum" UNIQUE ("practiceId", "ProvNum");


--
-- Name: PhiImageMetadata PhiImageMetadata_pkey; Type: CONSTRAINT; Schema: Phi; Owner: postgres
--

ALTER TABLE ONLY "Phi"."PhiImageMetadata"
    ADD CONSTRAINT "PhiImageMetadata_pkey" PRIMARY KEY (id);


--
-- Name: AnalysesHistory AnalysesHistory_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."AnalysesHistory"
    ADD CONSTRAINT "AnalysesHistory_pkey" PRIMARY KEY (id);


--
-- Name: Analyses Analyses_mongoId_key; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Analyses"
    ADD CONSTRAINT "Analyses_mongoId_key" UNIQUE ("mongoId");


--
-- Name: Analyses Analyses_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Analyses"
    ADD CONSTRAINT "Analyses_pkey" PRIMARY KEY (id);


--
-- Name: Analyses Analyses_rawResponseId_key; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Analyses"
    ADD CONSTRAINT "Analyses_rawResponseId_key" UNIQUE ("rawResponseId");


--
-- Name: BoneLevels BoneLevels_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."BoneLevels"
    ADD CONSTRAINT "BoneLevels_pkey" PRIMARY KEY (id);


--
-- Name: Calculus Calculus_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Calculus"
    ADD CONSTRAINT "Calculus_pkey" PRIMARY KEY (id);


--
-- Name: Caries Caries_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Caries"
    ADD CONSTRAINT "Caries_pkey" PRIMARY KEY (id);


--
-- Name: ConfidenceThresholds ConfidenceThresholds_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."ConfidenceThresholds"
    ADD CONSTRAINT "ConfidenceThresholds_pkey" PRIMARY KEY (id);


--
-- Name: Crowns Crowns_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Crowns"
    ADD CONSTRAINT "Crowns_pkey" PRIMARY KEY (id);


--
-- Name: Fillings Fillings_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Fillings"
    ADD CONSTRAINT "Fillings_pkey" PRIMARY KEY (id);


--
-- Name: Findings Findings_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Findings"
    ADD CONSTRAINT "Findings_pkey" PRIMARY KEY (id);


--
-- Name: FmxSummary FmxSummary_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."FmxSummary"
    ADD CONSTRAINT "FmxSummary_pkey" PRIMARY KEY (id);


--
-- Name: Labels Labels_label_key; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Labels"
    ADD CONSTRAINT "Labels_label_key" UNIQUE (label);


--
-- Name: Labels Labels_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Labels"
    ADD CONSTRAINT "Labels_pkey" PRIMARY KEY (id);


--
-- Name: RawResponses RawResponses_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."RawResponses"
    ADD CONSTRAINT "RawResponses_pkey" PRIMARY KEY (id);


--
-- Name: RootCanals RootCanals_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."RootCanals"
    ADD CONSTRAINT "RootCanals_pkey" PRIMARY KEY (id);


--
-- Name: Roots Roots_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Roots"
    ADD CONSTRAINT "Roots_pkey" PRIMARY KEY (id);


--
-- Name: Teeth Teeth_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Teeth"
    ADD CONSTRAINT "Teeth_pkey" PRIMARY KEY (id);


--
-- Name: UserValidations UserValidations_pkey; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."UserValidations"
    ADD CONSTRAINT "UserValidations_pkey" PRIMARY KEY (id);


--
-- Name: FmxSummary analyses.FmxSummary_estimatedVisitId_toothId_deletedAt_uk; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."FmxSummary"
    ADD CONSTRAINT "analyses.FmxSummary_estimatedVisitId_toothId_deletedAt_uk" UNIQUE ("estimatedVisitId", "toothId", "deletedAt");


--
-- Name: Teeth analyses.Teeth_toothId_analysesId_uk; Type: CONSTRAINT; Schema: analyses; Owner: postgres
--

ALTER TABLE ONLY analyses."Teeth"
    ADD CONSTRAINT "analyses.Teeth_toothId_analysesId_uk" UNIQUE ("toothId", "analysesId");


--
-- Name: AnalyzedImages AnalyzedImages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnalyzedImages"
    ADD CONSTRAINT "AnalyzedImages_pkey" PRIMARY KEY (id);


--
-- Name: CdtCodesToAnalysesLabels CdtCodesToAnalysesLabels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CdtCodesToAnalysesLabels"
    ADD CONSTRAINT "CdtCodesToAnalysesLabels_pkey" PRIMARY KEY (id);


--
-- Name: CdtCodes CdtCodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CdtCodes"
    ADD CONSTRAINT "CdtCodes_pkey" PRIMARY KEY ("cdtCode");


--
-- Name: ConnectorBackfillConfigs ConnectorBackfillConfigs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConnectorBackfillConfigs"
    ADD CONSTRAINT "ConnectorBackfillConfigs_pkey" PRIMARY KEY (id);


--
-- Name: CustomerProviders CustomerProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerProviders"
    ADD CONSTRAINT "CustomerProviders_pkey" PRIMARY KEY (id);


--
-- Name: CustomerTreatmentsAggregations CustomerTreatmentsAggregations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerTreatmentsAggregations"
    ADD CONSTRAINT "CustomerTreatmentsAggregations_pkey" PRIMARY KEY (id);


--
-- Name: CustomerTreatments CustomerTreatments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerTreatments"
    ADD CONSTRAINT "CustomerTreatments_pkey" PRIMARY KEY (id);


--
-- Name: DataDigestMeta DataDigestMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigestMeta"
    ADD CONSTRAINT "DataDigestMeta_pkey" PRIMARY KEY (id);


--
-- Name: DataDigest DataDigest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigest"
    ADD CONSTRAINT "DataDigest_pkey" PRIMARY KEY (id);


--
-- Name: DataUploadAudit DataUploadAudit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataUploadAudit"
    ADD CONSTRAINT "DataUploadAudit_pkey" PRIMARY KEY (id);


--
-- Name: DataUploadTriggers DataUploadTriggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataUploadTriggers"
    ADD CONSTRAINT "DataUploadTriggers_pkey" PRIMARY KEY (id);


--
-- Name: DefaultPreferences DefaultPreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DefaultPreferences"
    ADD CONSTRAINT "DefaultPreferences_pkey" PRIMARY KEY (id);


--
-- Name: DefaultPreferences DefaultPreferences_preferenceKey_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DefaultPreferences"
    ADD CONSTRAINT "DefaultPreferences_preferenceKey_uk" UNIQUE ("preferenceKey");


--
-- Name: EntityAliases EntityAliases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EntityAliases"
    ADD CONSTRAINT "EntityAliases_pkey" PRIMARY KEY (id);


--
-- Name: EstimatedVisit EstimatedVisit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstimatedVisit"
    ADD CONSTRAINT "EstimatedVisit_pkey" PRIMARY KEY (id);


--
-- Name: Events pk_data_mart_event; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events"
    ADD CONSTRAINT pk_data_mart_event PRIMARY KEY (id, "createdAt");


--
-- Name: Events_default Events_default_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_default"
    ADD CONSTRAINT "Events_default_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_17 Events_p2023_07_17_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_17"
    ADD CONSTRAINT "Events_p2023_07_17_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_18 Events_p2023_07_18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_18"
    ADD CONSTRAINT "Events_p2023_07_18_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_19 Events_p2023_07_19_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_19"
    ADD CONSTRAINT "Events_p2023_07_19_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_20 Events_p2023_07_20_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_20"
    ADD CONSTRAINT "Events_p2023_07_20_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_21 Events_p2023_07_21_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_21"
    ADD CONSTRAINT "Events_p2023_07_21_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_22 Events_p2023_07_22_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_22"
    ADD CONSTRAINT "Events_p2023_07_22_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_23 Events_p2023_07_23_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_23"
    ADD CONSTRAINT "Events_p2023_07_23_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_24 Events_p2023_07_24_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_24"
    ADD CONSTRAINT "Events_p2023_07_24_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_25 Events_p2023_07_25_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_25"
    ADD CONSTRAINT "Events_p2023_07_25_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_26 Events_p2023_07_26_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_26"
    ADD CONSTRAINT "Events_p2023_07_26_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_27 Events_p2023_07_27_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_27"
    ADD CONSTRAINT "Events_p2023_07_27_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_28 Events_p2023_07_28_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_28"
    ADD CONSTRAINT "Events_p2023_07_28_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_29 Events_p2023_07_29_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_29"
    ADD CONSTRAINT "Events_p2023_07_29_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_30 Events_p2023_07_30_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_30"
    ADD CONSTRAINT "Events_p2023_07_30_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_07_31 Events_p2023_07_31_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_07_31"
    ADD CONSTRAINT "Events_p2023_07_31_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_01 Events_p2023_08_01_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_01"
    ADD CONSTRAINT "Events_p2023_08_01_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_02 Events_p2023_08_02_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_02"
    ADD CONSTRAINT "Events_p2023_08_02_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_03 Events_p2023_08_03_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_03"
    ADD CONSTRAINT "Events_p2023_08_03_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_04 Events_p2023_08_04_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_04"
    ADD CONSTRAINT "Events_p2023_08_04_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_05 Events_p2023_08_05_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_05"
    ADD CONSTRAINT "Events_p2023_08_05_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_06 Events_p2023_08_06_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_06"
    ADD CONSTRAINT "Events_p2023_08_06_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_07 Events_p2023_08_07_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_07"
    ADD CONSTRAINT "Events_p2023_08_07_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_08 Events_p2023_08_08_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_08"
    ADD CONSTRAINT "Events_p2023_08_08_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_09 Events_p2023_08_09_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_09"
    ADD CONSTRAINT "Events_p2023_08_09_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_10 Events_p2023_08_10_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_10"
    ADD CONSTRAINT "Events_p2023_08_10_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_11 Events_p2023_08_11_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_11"
    ADD CONSTRAINT "Events_p2023_08_11_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_12 Events_p2023_08_12_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_12"
    ADD CONSTRAINT "Events_p2023_08_12_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_13 Events_p2023_08_13_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_13"
    ADD CONSTRAINT "Events_p2023_08_13_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_14 Events_p2023_08_14_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_14"
    ADD CONSTRAINT "Events_p2023_08_14_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_15 Events_p2023_08_15_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_15"
    ADD CONSTRAINT "Events_p2023_08_15_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_16 Events_p2023_08_16_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_16"
    ADD CONSTRAINT "Events_p2023_08_16_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_17 Events_p2023_08_17_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_17"
    ADD CONSTRAINT "Events_p2023_08_17_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_18 Events_p2023_08_18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_18"
    ADD CONSTRAINT "Events_p2023_08_18_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_19 Events_p2023_08_19_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_19"
    ADD CONSTRAINT "Events_p2023_08_19_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_20 Events_p2023_08_20_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_20"
    ADD CONSTRAINT "Events_p2023_08_20_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_21 Events_p2023_08_21_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_21"
    ADD CONSTRAINT "Events_p2023_08_21_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_22 Events_p2023_08_22_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_22"
    ADD CONSTRAINT "Events_p2023_08_22_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_23 Events_p2023_08_23_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_23"
    ADD CONSTRAINT "Events_p2023_08_23_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_24 Events_p2023_08_24_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_24"
    ADD CONSTRAINT "Events_p2023_08_24_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_25 Events_p2023_08_25_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_25"
    ADD CONSTRAINT "Events_p2023_08_25_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_26 Events_p2023_08_26_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_26"
    ADD CONSTRAINT "Events_p2023_08_26_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_27 Events_p2023_08_27_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_27"
    ADD CONSTRAINT "Events_p2023_08_27_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_28 Events_p2023_08_28_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_28"
    ADD CONSTRAINT "Events_p2023_08_28_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_29 Events_p2023_08_29_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_29"
    ADD CONSTRAINT "Events_p2023_08_29_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_30 Events_p2023_08_30_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_30"
    ADD CONSTRAINT "Events_p2023_08_30_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_08_31 Events_p2023_08_31_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_08_31"
    ADD CONSTRAINT "Events_p2023_08_31_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_01 Events_p2023_09_01_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_01"
    ADD CONSTRAINT "Events_p2023_09_01_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_02 Events_p2023_09_02_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_02"
    ADD CONSTRAINT "Events_p2023_09_02_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_03 Events_p2023_09_03_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_03"
    ADD CONSTRAINT "Events_p2023_09_03_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_04 Events_p2023_09_04_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_04"
    ADD CONSTRAINT "Events_p2023_09_04_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_05 Events_p2023_09_05_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_05"
    ADD CONSTRAINT "Events_p2023_09_05_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_06 Events_p2023_09_06_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_06"
    ADD CONSTRAINT "Events_p2023_09_06_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_07 Events_p2023_09_07_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_07"
    ADD CONSTRAINT "Events_p2023_09_07_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_08 Events_p2023_09_08_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_08"
    ADD CONSTRAINT "Events_p2023_09_08_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_09 Events_p2023_09_09_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_09"
    ADD CONSTRAINT "Events_p2023_09_09_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_10 Events_p2023_09_10_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_10"
    ADD CONSTRAINT "Events_p2023_09_10_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_11 Events_p2023_09_11_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_11"
    ADD CONSTRAINT "Events_p2023_09_11_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_12 Events_p2023_09_12_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_12"
    ADD CONSTRAINT "Events_p2023_09_12_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_13 Events_p2023_09_13_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_13"
    ADD CONSTRAINT "Events_p2023_09_13_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_14 Events_p2023_09_14_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_14"
    ADD CONSTRAINT "Events_p2023_09_14_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_15 Events_p2023_09_15_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_15"
    ADD CONSTRAINT "Events_p2023_09_15_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_16 Events_p2023_09_16_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_16"
    ADD CONSTRAINT "Events_p2023_09_16_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_17 Events_p2023_09_17_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_17"
    ADD CONSTRAINT "Events_p2023_09_17_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_18 Events_p2023_09_18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_18"
    ADD CONSTRAINT "Events_p2023_09_18_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_19 Events_p2023_09_19_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_19"
    ADD CONSTRAINT "Events_p2023_09_19_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_20 Events_p2023_09_20_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_20"
    ADD CONSTRAINT "Events_p2023_09_20_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_21 Events_p2023_09_21_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_21"
    ADD CONSTRAINT "Events_p2023_09_21_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_22 Events_p2023_09_22_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_22"
    ADD CONSTRAINT "Events_p2023_09_22_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_23 Events_p2023_09_23_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_23"
    ADD CONSTRAINT "Events_p2023_09_23_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_24 Events_p2023_09_24_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_24"
    ADD CONSTRAINT "Events_p2023_09_24_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_25 Events_p2023_09_25_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_25"
    ADD CONSTRAINT "Events_p2023_09_25_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_26 Events_p2023_09_26_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_26"
    ADD CONSTRAINT "Events_p2023_09_26_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_27 Events_p2023_09_27_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_27"
    ADD CONSTRAINT "Events_p2023_09_27_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_28 Events_p2023_09_28_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_28"
    ADD CONSTRAINT "Events_p2023_09_28_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_29 Events_p2023_09_29_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_29"
    ADD CONSTRAINT "Events_p2023_09_29_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_09_30 Events_p2023_09_30_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_09_30"
    ADD CONSTRAINT "Events_p2023_09_30_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_01 Events_p2023_10_01_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_01"
    ADD CONSTRAINT "Events_p2023_10_01_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_02 Events_p2023_10_02_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_02"
    ADD CONSTRAINT "Events_p2023_10_02_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_03 Events_p2023_10_03_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_03"
    ADD CONSTRAINT "Events_p2023_10_03_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_04 Events_p2023_10_04_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_04"
    ADD CONSTRAINT "Events_p2023_10_04_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_05 Events_p2023_10_05_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_05"
    ADD CONSTRAINT "Events_p2023_10_05_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_06 Events_p2023_10_06_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_06"
    ADD CONSTRAINT "Events_p2023_10_06_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_07 Events_p2023_10_07_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_07"
    ADD CONSTRAINT "Events_p2023_10_07_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_08 Events_p2023_10_08_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_08"
    ADD CONSTRAINT "Events_p2023_10_08_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_09 Events_p2023_10_09_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_09"
    ADD CONSTRAINT "Events_p2023_10_09_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_10 Events_p2023_10_10_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_10"
    ADD CONSTRAINT "Events_p2023_10_10_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_11 Events_p2023_10_11_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_11"
    ADD CONSTRAINT "Events_p2023_10_11_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_12 Events_p2023_10_12_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_12"
    ADD CONSTRAINT "Events_p2023_10_12_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_13 Events_p2023_10_13_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_13"
    ADD CONSTRAINT "Events_p2023_10_13_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_14 Events_p2023_10_14_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_14"
    ADD CONSTRAINT "Events_p2023_10_14_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_15 Events_p2023_10_15_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_15"
    ADD CONSTRAINT "Events_p2023_10_15_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_16 Events_p2023_10_16_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_16"
    ADD CONSTRAINT "Events_p2023_10_16_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_17 Events_p2023_10_17_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_17"
    ADD CONSTRAINT "Events_p2023_10_17_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_18 Events_p2023_10_18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_18"
    ADD CONSTRAINT "Events_p2023_10_18_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_19 Events_p2023_10_19_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_19"
    ADD CONSTRAINT "Events_p2023_10_19_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_20 Events_p2023_10_20_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_20"
    ADD CONSTRAINT "Events_p2023_10_20_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_21 Events_p2023_10_21_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_21"
    ADD CONSTRAINT "Events_p2023_10_21_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_22 Events_p2023_10_22_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_22"
    ADD CONSTRAINT "Events_p2023_10_22_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_23 Events_p2023_10_23_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_23"
    ADD CONSTRAINT "Events_p2023_10_23_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_24 Events_p2023_10_24_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_24"
    ADD CONSTRAINT "Events_p2023_10_24_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_25 Events_p2023_10_25_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_25"
    ADD CONSTRAINT "Events_p2023_10_25_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_26 Events_p2023_10_26_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_26"
    ADD CONSTRAINT "Events_p2023_10_26_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_27 Events_p2023_10_27_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_27"
    ADD CONSTRAINT "Events_p2023_10_27_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_28 Events_p2023_10_28_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_28"
    ADD CONSTRAINT "Events_p2023_10_28_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_29 Events_p2023_10_29_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_29"
    ADD CONSTRAINT "Events_p2023_10_29_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_30 Events_p2023_10_30_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_30"
    ADD CONSTRAINT "Events_p2023_10_30_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_10_31 Events_p2023_10_31_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_10_31"
    ADD CONSTRAINT "Events_p2023_10_31_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_01 Events_p2023_11_01_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_01"
    ADD CONSTRAINT "Events_p2023_11_01_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_02 Events_p2023_11_02_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_02"
    ADD CONSTRAINT "Events_p2023_11_02_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_03 Events_p2023_11_03_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_03"
    ADD CONSTRAINT "Events_p2023_11_03_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_04 Events_p2023_11_04_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_04"
    ADD CONSTRAINT "Events_p2023_11_04_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_05 Events_p2023_11_05_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_05"
    ADD CONSTRAINT "Events_p2023_11_05_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_06 Events_p2023_11_06_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_06"
    ADD CONSTRAINT "Events_p2023_11_06_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_07 Events_p2023_11_07_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_07"
    ADD CONSTRAINT "Events_p2023_11_07_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_08 Events_p2023_11_08_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_08"
    ADD CONSTRAINT "Events_p2023_11_08_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_09 Events_p2023_11_09_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_09"
    ADD CONSTRAINT "Events_p2023_11_09_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_10 Events_p2023_11_10_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_10"
    ADD CONSTRAINT "Events_p2023_11_10_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_11 Events_p2023_11_11_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_11"
    ADD CONSTRAINT "Events_p2023_11_11_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_12 Events_p2023_11_12_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_12"
    ADD CONSTRAINT "Events_p2023_11_12_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_13 Events_p2023_11_13_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_13"
    ADD CONSTRAINT "Events_p2023_11_13_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_14 Events_p2023_11_14_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_14"
    ADD CONSTRAINT "Events_p2023_11_14_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_15 Events_p2023_11_15_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_15"
    ADD CONSTRAINT "Events_p2023_11_15_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_16 Events_p2023_11_16_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_16"
    ADD CONSTRAINT "Events_p2023_11_16_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_17 Events_p2023_11_17_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_17"
    ADD CONSTRAINT "Events_p2023_11_17_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_18 Events_p2023_11_18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_18"
    ADD CONSTRAINT "Events_p2023_11_18_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_19 Events_p2023_11_19_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_19"
    ADD CONSTRAINT "Events_p2023_11_19_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_20 Events_p2023_11_20_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_20"
    ADD CONSTRAINT "Events_p2023_11_20_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_21 Events_p2023_11_21_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_21"
    ADD CONSTRAINT "Events_p2023_11_21_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_22 Events_p2023_11_22_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_22"
    ADD CONSTRAINT "Events_p2023_11_22_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_23 Events_p2023_11_23_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_23"
    ADD CONSTRAINT "Events_p2023_11_23_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_24 Events_p2023_11_24_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_24"
    ADD CONSTRAINT "Events_p2023_11_24_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_25 Events_p2023_11_25_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_25"
    ADD CONSTRAINT "Events_p2023_11_25_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_26 Events_p2023_11_26_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_26"
    ADD CONSTRAINT "Events_p2023_11_26_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_27 Events_p2023_11_27_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_27"
    ADD CONSTRAINT "Events_p2023_11_27_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_28 Events_p2023_11_28_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_28"
    ADD CONSTRAINT "Events_p2023_11_28_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_29 Events_p2023_11_29_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_29"
    ADD CONSTRAINT "Events_p2023_11_29_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_11_30 Events_p2023_11_30_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_11_30"
    ADD CONSTRAINT "Events_p2023_11_30_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_01 Events_p2023_12_01_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_01"
    ADD CONSTRAINT "Events_p2023_12_01_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_02 Events_p2023_12_02_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_02"
    ADD CONSTRAINT "Events_p2023_12_02_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_03 Events_p2023_12_03_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_03"
    ADD CONSTRAINT "Events_p2023_12_03_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_04 Events_p2023_12_04_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_04"
    ADD CONSTRAINT "Events_p2023_12_04_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_05 Events_p2023_12_05_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_05"
    ADD CONSTRAINT "Events_p2023_12_05_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_06 Events_p2023_12_06_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_06"
    ADD CONSTRAINT "Events_p2023_12_06_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_07 Events_p2023_12_07_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_07"
    ADD CONSTRAINT "Events_p2023_12_07_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_08 Events_p2023_12_08_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_08"
    ADD CONSTRAINT "Events_p2023_12_08_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_09 Events_p2023_12_09_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_09"
    ADD CONSTRAINT "Events_p2023_12_09_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_10 Events_p2023_12_10_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_10"
    ADD CONSTRAINT "Events_p2023_12_10_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_11 Events_p2023_12_11_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_11"
    ADD CONSTRAINT "Events_p2023_12_11_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_12 Events_p2023_12_12_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_12"
    ADD CONSTRAINT "Events_p2023_12_12_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_13 Events_p2023_12_13_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_13"
    ADD CONSTRAINT "Events_p2023_12_13_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_p2023_12_14 Events_p2023_12_14_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_p2023_12_14"
    ADD CONSTRAINT "Events_p2023_12_14_pkey" PRIMARY KEY (id, "createdAt");


--
-- Name: Events_archive Events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Events_archive"
    ADD CONSTRAINT "Events_pkey" PRIMARY KEY (id);


--
-- Name: ExternalAccessTokens ExternalAccessTokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExternalAccessTokens"
    ADD CONSTRAINT "ExternalAccessTokens_pkey" PRIMARY KEY (id);


--
-- Name: ExternalLocationSecrets ExternalLocationSecrets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExternalLocationSecrets"
    ADD CONSTRAINT "ExternalLocationSecrets_pkey" PRIMARY KEY (id);


--
-- Name: HuddlePatientData HuddlePatientData_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HuddlePatientData"
    ADD CONSTRAINT "HuddlePatientData_pkey" PRIMARY KEY ("pmsPatientId");


--
-- Name: ImageAnalysisMirrors ImageAnalysisMirrors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageAnalysisMirrors"
    ADD CONSTRAINT "ImageAnalysisMirrors_pkey" PRIMARY KEY (id);


--
-- Name: ImageCatalog ImageCatalog_mongoImageId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageCatalog"
    ADD CONSTRAINT "ImageCatalog_mongoImageId_key" UNIQUE ("mongoImageId");


--
-- Name: ImageCatalog ImageCatalog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImageCatalog"
    ADD CONSTRAINT "ImageCatalog_pkey" PRIMARY KEY (id);


--
-- Name: ImagingPatientIdentifiers ImagingPatientIdentifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientIdentifiers"
    ADD CONSTRAINT "ImagingPatientIdentifiers_pkey" PRIMARY KEY (id);


--
-- Name: ImagingPatientsSources ImagingPatientsSources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientsSources"
    ADD CONSTRAINT "ImagingPatientsSources_pkey" PRIMARY KEY (id);


--
-- Name: ImagingPatients ImagingPatients_folderHash_practiceId_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients"
    ADD CONSTRAINT "ImagingPatients_folderHash_practiceId_uk" UNIQUE ("folderHash", "practiceId");


--
-- Name: InsightsAggregateMetrics InsightsAggregateMetrics_constructType_constructId_temporalInte; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InsightsAggregateMetrics"
    ADD CONSTRAINT "InsightsAggregateMetrics_constructType_constructId_temporalInte" UNIQUE ("constructType", "constructId", "temporalIntervalType", start, "end");


--
-- Name: InsightsAggregateMetrics InsightsAggregateMetrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InsightsAggregateMetrics"
    ADD CONSTRAINT "InsightsAggregateMetrics_pkey" PRIMARY KEY (id);


--
-- Name: IntegrationJobAudit IntegrationJobAudit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationJobAudit"
    ADD CONSTRAINT "IntegrationJobAudit_pkey" PRIMARY KEY (id);


--
-- Name: IntegrationJobRuns IntegrationJobRuns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationJobRuns"
    ADD CONSTRAINT "IntegrationJobRuns_pkey" PRIMARY KEY (id);


--
-- Name: MagicLink MagicLink_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MagicLink"
    ADD CONSTRAINT "MagicLink_key_key" UNIQUE (key);


--
-- Name: MagicLink MagicLink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MagicLink"
    ADD CONSTRAINT "MagicLink_pkey" PRIMARY KEY (id);


--
-- Name: OrganizationPreferences OrganizationPreferences_organizationId_preferenceKey_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationPreferences"
    ADD CONSTRAINT "OrganizationPreferences_organizationId_preferenceKey_uk" UNIQUE ("organizationId", "preferenceKey");


--
-- Name: OrganizationPreferences OrganizationPreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationPreferences"
    ADD CONSTRAINT "OrganizationPreferences_pkey" PRIMARY KEY (id);


--
-- Name: Organizations Organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Organizations"
    ADD CONSTRAINT "Organizations_pkey" PRIMARY KEY (id);


--
-- Name: Organizations Organizations_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Organizations"
    ADD CONSTRAINT "Organizations_videaId_key" UNIQUE ("videaId");


--
-- Name: PatientIdMatches PatientIdMatches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PatientIdMatches"
    ADD CONSTRAINT "PatientIdMatches_pkey" PRIMARY KEY (id);


--
-- Name: ImagingPatients Patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients"
    ADD CONSTRAINT "Patients_pkey" PRIMARY KEY (id);


--
-- Name: ImagingPatients Patients_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients"
    ADD CONSTRAINT "Patients_videaId_key" UNIQUE ("videaId");


--
-- Name: PmsAppointmentToTreatments PmsAppointmentToTreatments_appointmentId_treatmentId_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointmentToTreatments"
    ADD CONSTRAINT "PmsAppointmentToTreatments_appointmentId_treatmentId_pk" PRIMARY KEY ("appointmentId", "treatmentId");


--
-- Name: PmsAppointments PmsAppointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments"
    ADD CONSTRAINT "PmsAppointments_pkey" PRIMARY KEY (id);


--
-- Name: PmsAppointments PmsAppointments_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsAppointments"
    ADD CONSTRAINT "PmsAppointments_videaId_key" UNIQUE ("videaId");


--
-- Name: PmsDataIngestionContext PmsDataIngestionContext_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsDataIngestionContext"
    ADD CONSTRAINT "PmsDataIngestionContext_pkey" PRIMARY KEY (id);


--
-- Name: PmsOperatories PmsOperatories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsOperatories"
    ADD CONSTRAINT "PmsOperatories_pkey" PRIMARY KEY (id);


--
-- Name: PmsOperatories PmsOperatories_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsOperatories"
    ADD CONSTRAINT "PmsOperatories_videaId_key" UNIQUE ("videaId");


--
-- Name: PmsPatientViewCounts PmsPatientViewCounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatientViewCounts"
    ADD CONSTRAINT "PmsPatientViewCounts_pkey" PRIMARY KEY (id);


--
-- Name: PmsPatientViewCounts PmsPatientViewCounts_practiceId_pmsPatientId_viewedDay_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatientViewCounts"
    ADD CONSTRAINT "PmsPatientViewCounts_practiceId_pmsPatientId_viewedDay_key" UNIQUE ("practiceId", "pmsPatientId", "viewedDay");


--
-- Name: PmsPatients PmsPatients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatients"
    ADD CONSTRAINT "PmsPatients_pkey" PRIMARY KEY (id);


--
-- Name: PmsPatients PmsPatients_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsPatients"
    ADD CONSTRAINT "PmsPatients_videaId_key" UNIQUE ("videaId");


--
-- Name: PmsProviders PmsProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsProviders"
    ADD CONSTRAINT "PmsProviders_pkey" PRIMARY KEY (id);


--
-- Name: PmsProviders PmsProviders_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsProviders"
    ADD CONSTRAINT "PmsProviders_videaId_key" UNIQUE ("videaId");


--
-- Name: PmsTreatmentStatusHistory PmsTreatmentStatusHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatmentStatusHistory"
    ADD CONSTRAINT "PmsTreatmentStatusHistory_pkey" PRIMARY KEY ("pmsTreatmentId");


--
-- Name: PmsTreatments PmsTreatments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatments"
    ADD CONSTRAINT "PmsTreatments_pkey" PRIMARY KEY (id);


--
-- Name: PmsTreatments PmsTreatments_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PmsTreatments"
    ADD CONSTRAINT "PmsTreatments_videaId_key" UNIQUE ("videaId");


--
-- Name: PracticePreferences PracticePreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PracticePreferences"
    ADD CONSTRAINT "PracticePreferences_pkey" PRIMARY KEY (id);


--
-- Name: PracticePreferences PracticePreferences_practiceId_preferenceKey_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PracticePreferences"
    ADD CONSTRAINT "PracticePreferences_practiceId_preferenceKey_uk" UNIQUE ("practiceId", "preferenceKey");


--
-- Name: Practices Practices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Practices"
    ADD CONSTRAINT "Practices_pkey" PRIMARY KEY (id);


--
-- Name: Practices Practices_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Practices"
    ADD CONSTRAINT "Practices_videaId_key" UNIQUE ("videaId");


--
-- Name: ProductKeys ProductKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductKeys"
    ADD CONSTRAINT "ProductKeys_pkey" PRIMARY KEY (id);


--
-- Name: ProductKeys ProductKeys_productKeyId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductKeys"
    ADD CONSTRAINT "ProductKeys_productKeyId_key" UNIQUE ("productKeyId");


--
-- Name: ProvisionedEntities ProvisionedEntities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProvisionedEntities"
    ADD CONSTRAINT "ProvisionedEntities_pkey" PRIMARY KEY (id);


--
-- Name: QuarantineImages QuarantineImages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuarantineImages"
    ADD CONSTRAINT "QuarantineImages_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: UnifiedAppointments UnifiedAppointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnifiedAppointments"
    ADD CONSTRAINT "UnifiedAppointments_pkey" PRIMARY KEY (id);


--
-- Name: UserEvents UserEvents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEvents"
    ADD CONSTRAINT "UserEvents_pkey" PRIMARY KEY (id);


--
-- Name: UserPreferences UserPreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserPreferences"
    ADD CONSTRAINT "UserPreferences_pkey" PRIMARY KEY (id);


--
-- Name: UserPreferences UserPreferences_userId_preferenceKey_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserPreferences"
    ADD CONSTRAINT "UserPreferences_userId_preferenceKey_uk" UNIQUE ("userId", "preferenceKey");


--
-- Name: UserWatchLists UserWatchLists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserWatchLists"
    ADD CONSTRAINT "UserWatchLists_pkey" PRIMARY KEY (id);


--
-- Name: UtilizationMetrics UtilizationMetrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UtilizationMetrics"
    ADD CONSTRAINT "UtilizationMetrics_pkey" PRIMARY KEY (id);


--
-- Name: VideaAIModels VideaAIModels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaAIModels"
    ADD CONSTRAINT "VideaAIModels_pkey" PRIMARY KEY (id);


--
-- Name: VideaAIModels VideaAIModels_shortName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaAIModels"
    ADD CONSTRAINT "VideaAIModels_shortName_key" UNIQUE ("modelShortName");


--
-- Name: VideaAIModels VideaAIModels_videaId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaAIModels"
    ADD CONSTRAINT "VideaAIModels_videaId_key" UNIQUE ("videaId");


--
-- Name: VideaPathologyTypes VideaPathologyTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideaPathologyTypes"
    ADD CONSTRAINT "VideaPathologyTypes_pkey" PRIMARY KEY (id);


--
-- Name: one_shots one_shots_filename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.one_shots
    ADD CONSTRAINT one_shots_filename_key UNIQUE (filename);


--
-- Name: one_shots one_shots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.one_shots
    ADD CONSTRAINT one_shots_pkey PRIMARY KEY (id);


--
-- Name: CdtCodesToAnalysesLabels public.CdtCodesToAnalysesLabels_labelId_cdtCode_deletedAt_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CdtCodesToAnalysesLabels"
    ADD CONSTRAINT "public.CdtCodesToAnalysesLabels_labelId_cdtCode_deletedAt_uk" UNIQUE ("labelId", "cdtCode", "deletedAt");


--
-- Name: ImagingPatients unique_constraint_chartNum_practiceId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients"
    ADD CONSTRAINT "unique_constraint_chartNum_practiceId" UNIQUE ("chartNum", "practiceId");


--
-- Name: DataDigestMeta unique_constraint_dataDigestId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigestMeta"
    ADD CONSTRAINT "unique_constraint_dataDigestId_key" UNIQUE ("dataDigestId", key);


--
-- Name: UtilizationMetrics unique_constraint_dataDigestId_practiceId_intervalType_interval; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UtilizationMetrics"
    ADD CONSTRAINT "unique_constraint_dataDigestId_practiceId_intervalType_interval" UNIQUE ("dataDigestId", "practiceId", "intervalType", "intervalStart", "intervalEnd");


--
-- Name: ImagingPatientsSources unique_constraint_imagingPatientId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatientsSources"
    ADD CONSTRAINT "unique_constraint_imagingPatientId" UNIQUE ("imagingPatientId");


--
-- Name: IntegrationJobAudit unique_constraint_integrationJobRunId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationJobAudit"
    ADD CONSTRAINT "unique_constraint_integrationJobRunId_key" UNIQUE ("integrationJobRunId", key);


--
-- Name: DataDigest unique_constraint_name_digest_version; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataDigest"
    ADD CONSTRAINT unique_constraint_name_digest_version UNIQUE (name, digest, version);


--
-- Name: CustomerTreatmentsAggregations unique_constraint_organizationId_practiceId_year; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerTreatmentsAggregations"
    ADD CONSTRAINT "unique_constraint_organizationId_practiceId_year" UNIQUE ("organizationId", "practiceId", year);


--
-- Name: ImagingPatients unique_constraint_practiceId_practicePatientId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ImagingPatients"
    ADD CONSTRAINT "unique_constraint_practiceId_practicePatientId" UNIQUE ("practicePatientId", "practiceId");


--
-- Name: CustomerProviders unique_constraint_practiceid_customerproviderId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerProviders"
    ADD CONSTRAINT "unique_constraint_practiceid_customerproviderId" UNIQUE ("practiceId", "customerProviderId");


--
-- Name: CustomerTreatments unique_constraint_practiceid_treatmentid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CustomerTreatments"
    ADD CONSTRAINT unique_constraint_practiceid_treatmentid UNIQUE ("practiceId", "customerTreatmentId");


--
-- Name: idx_integrationJobRunId_locationId_serviceDate; Type: INDEX; Schema: DentrixAscend; Owner: postgres
--

CREATE INDEX "idx_integrationJobRunId_locationId_serviceDate" ON "DentrixAscend"."ProductionCollectionsAudit" USING btree ("integrationJobRunId", "locationId", "serviceDate");


--
-- Name: idx_locationId_serviceDate; Type: INDEX; Schema: DentrixAscend; Owner: postgres
--

CREATE INDEX "idx_locationId_serviceDate" ON "DentrixAscend"."ProductionCollections" USING btree ("locationId", "serviceDate");


--
-- Name: TreatmentsAudit_practiceId_treatmentId; Type: INDEX; Schema: DentrixCore; Owner: postgres
--

CREATE INDEX "TreatmentsAudit_practiceId_treatmentId" ON "DentrixCore"."TreatmentsAudit" USING btree ("practiceId", "treatmentId");


--
-- Name: TreatmentsAudit_treatmentId_practiceId; Type: INDEX; Schema: DentrixCore; Owner: postgres
--

CREATE INDEX "TreatmentsAudit_treatmentId_practiceId" ON "DentrixCore"."TreatmentsAudit" USING btree ("treatmentId", "practiceId");


--
-- Name: patients_practice_id_chart_num; Type: INDEX; Schema: DentrixCore; Owner: postgres
--

CREATE INDEX patients_practice_id_chart_num ON "DentrixCore"."Patients" USING btree ("practiceId", "chartNum");


--
-- Name: patients_practice_id_patient_guid; Type: INDEX; Schema: DentrixCore; Owner: postgres
--

CREATE INDEX patients_practice_id_patient_guid ON "DentrixCore"."Patients" USING btree ("practiceId", "patientGuid");


--
-- Name: ImageManifests_organizationId_imageAcquiredAt; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE INDEX "ImageManifests_organizationId_imageAcquiredAt" ON "NonPhi"."ImageManifests" USING btree ("organizationId", "imageAcquiredAt");


--
-- Name: ImageManifests_practiceId_imageAcquiredAt; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE INDEX "ImageManifests_practiceId_imageAcquiredAt" ON "NonPhi"."ImageManifests" USING btree ("practiceId", "imageAcquiredAt");


--
-- Name: idx_imagemanifests_image_pixel_hash; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE INDEX idx_imagemanifests_image_pixel_hash ON "NonPhi"."ImageManifests" USING btree ("imagePixelHash", "practiceId");


--
-- Name: idx_practiceid_chartnum_unique; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE UNIQUE INDEX idx_practiceid_chartnum_unique ON "NonPhi"."FolderHashToChartNum" USING btree ("practiceId", "chartNum");


--
-- Name: idx_practiceid_folderhash_unique; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE UNIQUE INDEX idx_practiceid_folderhash_unique ON "NonPhi"."FolderHashToChartNum" USING btree ("practiceId", "folderHash");


--
-- Name: image_manifests_created_at; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE INDEX image_manifests_created_at ON "NonPhi"."ImageManifests" USING btree ("createdAt");


--
-- Name: image_manifests_estimated_visit_id; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE INDEX image_manifests_estimated_visit_id ON "NonPhi"."ImageManifests" USING btree ("estimatedVisitId");


--
-- Name: image_manifests_patient_id_practice_id_created_at; Type: INDEX; Schema: NonPhi; Owner: postgres
--

CREATE INDEX image_manifests_patient_id_practice_id_created_at ON "NonPhi"."ImageManifests" USING btree ("patientId", "practiceId", "createdAt");


--
-- Name: analyses_created_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_created_at ON analyses."Analyses" USING btree ("createdAt");


--
-- Name: analyses_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_deleted_at ON analyses."Analyses" USING btree ("deletedAt");


--
-- Name: analyses_history_data; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_history_data ON analyses."AnalysesHistory" USING gin (data jsonb_path_ops);


--
-- Name: analyses_history_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_history_deleted_at ON analyses."AnalysesHistory" USING btree ("deletedAt");


--
-- Name: analyses_history_image_manifest_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_history_image_manifest_id ON analyses."AnalysesHistory" USING btree ("imageManifestId");


--
-- Name: analyses_image_manifest_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_image_manifest_id ON analyses."Analyses" USING btree ("imageManifestId");


--
-- Name: analyses_raw_response_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX analyses_raw_response_id ON analyses."Analyses" USING btree ("rawResponseId");


--
-- Name: bone_levels_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX bone_levels_analyses_id ON analyses."BoneLevels" USING btree ("analysesId");


--
-- Name: bone_levels_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX bone_levels_deleted_at ON analyses."BoneLevels" USING btree ("deletedAt");


--
-- Name: bone_levels_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX bone_levels_tooth_id ON analyses."BoneLevels" USING btree ("toothId");


--
-- Name: calculus_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX calculus_analyses_id ON analyses."Calculus" USING btree ("analysesId");


--
-- Name: calculus_bounds; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX calculus_bounds ON analyses."Calculus" USING gist (bounds);


--
-- Name: calculus_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX calculus_deleted_at ON analyses."Calculus" USING btree ("deletedAt");


--
-- Name: calculus_outline; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX calculus_outline ON analyses."Calculus" USING gist (outline);


--
-- Name: calculus_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX calculus_tooth_id ON analyses."Calculus" USING btree ("toothId");


--
-- Name: caries_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX caries_analyses_id ON analyses."Caries" USING btree ("analysesId");


--
-- Name: caries_bounds; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX caries_bounds ON analyses."Caries" USING gist (bounds);


--
-- Name: caries_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX caries_deleted_at ON analyses."Caries" USING btree ("deletedAt");


--
-- Name: caries_outline; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX caries_outline ON analyses."Caries" USING gist (outline);


--
-- Name: caries_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX caries_tooth_id ON analyses."Caries" USING btree ("toothId");


--
-- Name: confidence_thresholds_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX confidence_thresholds_deleted_at ON analyses."ConfidenceThresholds" USING btree ("deletedAt");


--
-- Name: confidence_thresholds_label; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX confidence_thresholds_label ON analyses."ConfidenceThresholds" USING btree (label);


--
-- Name: crowns_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_analyses_id ON analyses."Crowns" USING btree ("analysesId");


--
-- Name: crowns_attributes; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_attributes ON analyses."Crowns" USING gin (attributes jsonb_path_ops);


--
-- Name: crowns_bounds; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_bounds ON analyses."Crowns" USING gist (bounds);


--
-- Name: crowns_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_deleted_at ON analyses."Crowns" USING btree ("deletedAt");


--
-- Name: crowns_label; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_label ON analyses."Crowns" USING btree (label);


--
-- Name: crowns_outline; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_outline ON analyses."Crowns" USING gist (outline);


--
-- Name: crowns_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX crowns_tooth_id ON analyses."Crowns" USING btree ("toothId");


--
-- Name: fillings_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_analyses_id ON analyses."Fillings" USING btree ("analysesId");


--
-- Name: fillings_attributes; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_attributes ON analyses."Fillings" USING gin (attributes jsonb_path_ops);


--
-- Name: fillings_bounds; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_bounds ON analyses."Fillings" USING gist (bounds);


--
-- Name: fillings_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_deleted_at ON analyses."Fillings" USING btree ("deletedAt");


--
-- Name: fillings_label; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_label ON analyses."Fillings" USING btree (label);


--
-- Name: fillings_outline; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_outline ON analyses."Fillings" USING gist (outline);


--
-- Name: fillings_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fillings_tooth_id ON analyses."Fillings" USING btree ("toothId");


--
-- Name: findings_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX findings_analyses_id ON analyses."Findings" USING btree ("analysesId");


--
-- Name: findings_attributes; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX findings_attributes ON analyses."Findings" USING gin (attributes jsonb_path_ops);


--
-- Name: findings_bounds; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX findings_bounds ON analyses."Findings" USING gist (bounds);


--
-- Name: findings_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX findings_deleted_at ON analyses."Findings" USING btree ("deletedAt");


--
-- Name: findings_label; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX findings_label ON analyses."Findings" USING btree (label);


--
-- Name: fmx_summary_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fmx_summary_deleted_at ON analyses."FmxSummary" USING btree ("deletedAt");


--
-- Name: fmx_summary_estimated_visit_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fmx_summary_estimated_visit_id ON analyses."FmxSummary" USING btree ("estimatedVisitId");


--
-- Name: fmx_summary_hash; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fmx_summary_hash ON analyses."FmxSummary" USING btree (hash);


--
-- Name: fmx_summary_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX fmx_summary_tooth_id ON analyses."FmxSummary" USING btree ("toothId");


--
-- Name: labels_label; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX labels_label ON analyses."Labels" USING btree (label);


--
-- Name: outline_new_index; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX outline_new_index ON analyses."Teeth" USING btree (outline);


--
-- Name: raw_responses_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX raw_responses_deleted_at ON analyses."RawResponses" USING btree ("deletedAt");


--
-- Name: raw_responses_image_manifest_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX raw_responses_image_manifest_id ON analyses."RawResponses" USING btree ("imageManifestId");


--
-- Name: raw_responses_response; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX raw_responses_response ON analyses."RawResponses" USING gin (response jsonb_path_ops);


--
-- Name: root_canals_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_analyses_id ON analyses."RootCanals" USING btree ("analysesId");


--
-- Name: root_canals_attributes; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_attributes ON analyses."RootCanals" USING gin (attributes jsonb_path_ops);


--
-- Name: root_canals_bounds; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_bounds ON analyses."RootCanals" USING gist (bounds);


--
-- Name: root_canals_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_deleted_at ON analyses."RootCanals" USING btree ("deletedAt");


--
-- Name: root_canals_label; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_label ON analyses."RootCanals" USING btree (label);


--
-- Name: root_canals_outline; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_outline ON analyses."RootCanals" USING gist (outline);


--
-- Name: root_canals_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX root_canals_tooth_id ON analyses."RootCanals" USING btree ("toothId");


--
-- Name: roots_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX roots_analyses_id ON analyses."Roots" USING btree ("analysesId");


--
-- Name: roots_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX roots_deleted_at ON analyses."Roots" USING btree ("deletedAt");


--
-- Name: roots_tooth_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX roots_tooth_id ON analyses."Roots" USING btree ("toothId");


--
-- Name: teeth_analyses_id; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_analyses_id ON analyses."Teeth" USING btree ("analysesId");


--
-- Name: teeth_crown_dentin; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_crown_dentin ON analyses."Teeth" USING gist ("crownDentin");


--
-- Name: teeth_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_deleted_at ON analyses."Teeth" USING btree ("deletedAt");


--
-- Name: teeth_dentin; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_dentin ON analyses."Teeth" USING gist ("crownDentin");


--
-- Name: teeth_enamel; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_enamel ON analyses."Teeth" USING gist (enamel);


--
-- Name: teeth_interproximal_concavities; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_interproximal_concavities ON analyses."Teeth" USING gist ("interproximalConcavities");


--
-- Name: teeth_pulp; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX teeth_pulp ON analyses."Teeth" USING gist (pulp);


--
-- Name: user_validations_deleted_at; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX user_validations_deleted_at ON analyses."UserValidations" USING btree ("deletedAt");


--
-- Name: user_validations_finding_id_finding_type; Type: INDEX; Schema: analyses; Owner: postgres
--

CREATE INDEX user_validations_finding_id_finding_type ON analyses."UserValidations" USING btree ("findingId", "findingType");


--
-- Name: event_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX event_created_at ON ONLY public."Events" USING btree ("createdAt");


--
-- Name: Events_default_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_default_createdAt_idx" ON public."Events_default" USING btree ("createdAt");


--
-- Name: event_body_object_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX event_body_object_id ON ONLY public."Events" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_default_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_default_expr_idx" ON public."Events_default" USING btree (((body ->> 'objectId'::text)));


--
-- Name: event_body_external_image_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX event_body_external_image_id ON ONLY public."Events" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_default_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_default_expr_idx1" ON public."Events_default" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: event_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX event_name ON ONLY public."Events" USING btree (name);


--
-- Name: Events_default_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_default_name_idx" ON public."Events_default" USING btree (name);


--
-- Name: Events_p2023_07_17_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_17_createdAt_idx" ON public."Events_p2023_07_17" USING btree ("createdAt");


--
-- Name: Events_p2023_07_17_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_17_expr_idx" ON public."Events_p2023_07_17" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_17_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_17_expr_idx1" ON public."Events_p2023_07_17" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_17_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_17_name_idx" ON public."Events_p2023_07_17" USING btree (name);


--
-- Name: Events_p2023_07_18_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_18_createdAt_idx" ON public."Events_p2023_07_18" USING btree ("createdAt");


--
-- Name: Events_p2023_07_18_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_18_expr_idx" ON public."Events_p2023_07_18" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_18_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_18_expr_idx1" ON public."Events_p2023_07_18" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_18_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_18_name_idx" ON public."Events_p2023_07_18" USING btree (name);


--
-- Name: Events_p2023_07_19_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_19_createdAt_idx" ON public."Events_p2023_07_19" USING btree ("createdAt");


--
-- Name: Events_p2023_07_19_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_19_expr_idx" ON public."Events_p2023_07_19" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_19_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_19_expr_idx1" ON public."Events_p2023_07_19" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_19_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_19_name_idx" ON public."Events_p2023_07_19" USING btree (name);


--
-- Name: Events_p2023_07_20_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_20_createdAt_idx" ON public."Events_p2023_07_20" USING btree ("createdAt");


--
-- Name: Events_p2023_07_20_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_20_expr_idx" ON public."Events_p2023_07_20" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_20_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_20_expr_idx1" ON public."Events_p2023_07_20" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_20_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_20_name_idx" ON public."Events_p2023_07_20" USING btree (name);


--
-- Name: Events_p2023_07_21_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_21_createdAt_idx" ON public."Events_p2023_07_21" USING btree ("createdAt");


--
-- Name: Events_p2023_07_21_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_21_expr_idx" ON public."Events_p2023_07_21" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_21_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_21_expr_idx1" ON public."Events_p2023_07_21" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_21_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_21_name_idx" ON public."Events_p2023_07_21" USING btree (name);


--
-- Name: Events_p2023_07_22_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_22_createdAt_idx" ON public."Events_p2023_07_22" USING btree ("createdAt");


--
-- Name: Events_p2023_07_22_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_22_expr_idx" ON public."Events_p2023_07_22" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_22_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_22_expr_idx1" ON public."Events_p2023_07_22" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_22_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_22_name_idx" ON public."Events_p2023_07_22" USING btree (name);


--
-- Name: Events_p2023_07_23_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_23_createdAt_idx" ON public."Events_p2023_07_23" USING btree ("createdAt");


--
-- Name: Events_p2023_07_23_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_23_expr_idx" ON public."Events_p2023_07_23" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_23_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_23_expr_idx1" ON public."Events_p2023_07_23" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_23_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_23_name_idx" ON public."Events_p2023_07_23" USING btree (name);


--
-- Name: Events_p2023_07_24_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_24_createdAt_idx" ON public."Events_p2023_07_24" USING btree ("createdAt");


--
-- Name: Events_p2023_07_24_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_24_expr_idx" ON public."Events_p2023_07_24" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_24_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_24_expr_idx1" ON public."Events_p2023_07_24" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_24_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_24_name_idx" ON public."Events_p2023_07_24" USING btree (name);


--
-- Name: Events_p2023_07_25_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_25_createdAt_idx" ON public."Events_p2023_07_25" USING btree ("createdAt");


--
-- Name: Events_p2023_07_25_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_25_expr_idx" ON public."Events_p2023_07_25" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_25_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_25_expr_idx1" ON public."Events_p2023_07_25" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_25_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_25_name_idx" ON public."Events_p2023_07_25" USING btree (name);


--
-- Name: Events_p2023_07_26_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_26_createdAt_idx" ON public."Events_p2023_07_26" USING btree ("createdAt");


--
-- Name: Events_p2023_07_26_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_26_expr_idx" ON public."Events_p2023_07_26" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_26_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_26_expr_idx1" ON public."Events_p2023_07_26" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_26_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_26_name_idx" ON public."Events_p2023_07_26" USING btree (name);


--
-- Name: Events_p2023_07_27_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_27_createdAt_idx" ON public."Events_p2023_07_27" USING btree ("createdAt");


--
-- Name: Events_p2023_07_27_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_27_expr_idx" ON public."Events_p2023_07_27" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_27_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_27_expr_idx1" ON public."Events_p2023_07_27" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_27_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_27_name_idx" ON public."Events_p2023_07_27" USING btree (name);


--
-- Name: Events_p2023_07_28_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_28_createdAt_idx" ON public."Events_p2023_07_28" USING btree ("createdAt");


--
-- Name: Events_p2023_07_28_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_28_expr_idx" ON public."Events_p2023_07_28" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_28_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_28_expr_idx1" ON public."Events_p2023_07_28" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_28_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_28_name_idx" ON public."Events_p2023_07_28" USING btree (name);


--
-- Name: Events_p2023_07_29_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_29_createdAt_idx" ON public."Events_p2023_07_29" USING btree ("createdAt");


--
-- Name: Events_p2023_07_29_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_29_expr_idx" ON public."Events_p2023_07_29" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_29_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_29_expr_idx1" ON public."Events_p2023_07_29" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_29_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_29_name_idx" ON public."Events_p2023_07_29" USING btree (name);


--
-- Name: Events_p2023_07_30_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_30_createdAt_idx" ON public."Events_p2023_07_30" USING btree ("createdAt");


--
-- Name: Events_p2023_07_30_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_30_expr_idx" ON public."Events_p2023_07_30" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_30_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_30_expr_idx1" ON public."Events_p2023_07_30" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_30_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_30_name_idx" ON public."Events_p2023_07_30" USING btree (name);


--
-- Name: Events_p2023_07_31_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_31_createdAt_idx" ON public."Events_p2023_07_31" USING btree ("createdAt");


--
-- Name: Events_p2023_07_31_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_31_expr_idx" ON public."Events_p2023_07_31" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_07_31_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_31_expr_idx1" ON public."Events_p2023_07_31" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_07_31_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_07_31_name_idx" ON public."Events_p2023_07_31" USING btree (name);


--
-- Name: Events_p2023_08_01_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_01_createdAt_idx" ON public."Events_p2023_08_01" USING btree ("createdAt");


--
-- Name: Events_p2023_08_01_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_01_expr_idx" ON public."Events_p2023_08_01" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_01_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_01_expr_idx1" ON public."Events_p2023_08_01" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_01_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_01_name_idx" ON public."Events_p2023_08_01" USING btree (name);


--
-- Name: Events_p2023_08_02_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_02_createdAt_idx" ON public."Events_p2023_08_02" USING btree ("createdAt");


--
-- Name: Events_p2023_08_02_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_02_expr_idx" ON public."Events_p2023_08_02" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_02_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_02_expr_idx1" ON public."Events_p2023_08_02" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_02_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_02_name_idx" ON public."Events_p2023_08_02" USING btree (name);


--
-- Name: Events_p2023_08_03_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_03_createdAt_idx" ON public."Events_p2023_08_03" USING btree ("createdAt");


--
-- Name: Events_p2023_08_03_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_03_expr_idx" ON public."Events_p2023_08_03" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_03_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_03_expr_idx1" ON public."Events_p2023_08_03" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_03_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_03_name_idx" ON public."Events_p2023_08_03" USING btree (name);


--
-- Name: Events_p2023_08_04_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_04_createdAt_idx" ON public."Events_p2023_08_04" USING btree ("createdAt");


--
-- Name: Events_p2023_08_04_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_04_expr_idx" ON public."Events_p2023_08_04" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_04_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_04_expr_idx1" ON public."Events_p2023_08_04" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_04_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_04_name_idx" ON public."Events_p2023_08_04" USING btree (name);


--
-- Name: Events_p2023_08_05_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_05_createdAt_idx" ON public."Events_p2023_08_05" USING btree ("createdAt");


--
-- Name: Events_p2023_08_05_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_05_expr_idx" ON public."Events_p2023_08_05" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_05_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_05_expr_idx1" ON public."Events_p2023_08_05" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_05_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_05_name_idx" ON public."Events_p2023_08_05" USING btree (name);


--
-- Name: Events_p2023_08_06_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_06_createdAt_idx" ON public."Events_p2023_08_06" USING btree ("createdAt");


--
-- Name: Events_p2023_08_06_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_06_expr_idx" ON public."Events_p2023_08_06" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_06_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_06_expr_idx1" ON public."Events_p2023_08_06" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_06_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_06_name_idx" ON public."Events_p2023_08_06" USING btree (name);


--
-- Name: Events_p2023_08_07_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_07_createdAt_idx" ON public."Events_p2023_08_07" USING btree ("createdAt");


--
-- Name: Events_p2023_08_07_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_07_expr_idx" ON public."Events_p2023_08_07" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_07_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_07_expr_idx1" ON public."Events_p2023_08_07" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_07_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_07_name_idx" ON public."Events_p2023_08_07" USING btree (name);


--
-- Name: Events_p2023_08_08_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_08_createdAt_idx" ON public."Events_p2023_08_08" USING btree ("createdAt");


--
-- Name: Events_p2023_08_08_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_08_expr_idx" ON public."Events_p2023_08_08" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_08_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_08_expr_idx1" ON public."Events_p2023_08_08" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_08_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_08_name_idx" ON public."Events_p2023_08_08" USING btree (name);


--
-- Name: Events_p2023_08_09_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_09_createdAt_idx" ON public."Events_p2023_08_09" USING btree ("createdAt");


--
-- Name: Events_p2023_08_09_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_09_expr_idx" ON public."Events_p2023_08_09" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_09_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_09_expr_idx1" ON public."Events_p2023_08_09" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_09_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_09_name_idx" ON public."Events_p2023_08_09" USING btree (name);


--
-- Name: Events_p2023_08_10_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_10_createdAt_idx" ON public."Events_p2023_08_10" USING btree ("createdAt");


--
-- Name: Events_p2023_08_10_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_10_expr_idx" ON public."Events_p2023_08_10" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_10_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_10_expr_idx1" ON public."Events_p2023_08_10" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_10_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_10_name_idx" ON public."Events_p2023_08_10" USING btree (name);


--
-- Name: Events_p2023_08_11_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_11_createdAt_idx" ON public."Events_p2023_08_11" USING btree ("createdAt");


--
-- Name: Events_p2023_08_11_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_11_expr_idx" ON public."Events_p2023_08_11" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_11_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_11_expr_idx1" ON public."Events_p2023_08_11" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_11_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_11_name_idx" ON public."Events_p2023_08_11" USING btree (name);


--
-- Name: Events_p2023_08_12_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_12_createdAt_idx" ON public."Events_p2023_08_12" USING btree ("createdAt");


--
-- Name: Events_p2023_08_12_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_12_expr_idx" ON public."Events_p2023_08_12" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_12_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_12_expr_idx1" ON public."Events_p2023_08_12" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_12_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_12_name_idx" ON public."Events_p2023_08_12" USING btree (name);


--
-- Name: Events_p2023_08_13_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_13_createdAt_idx" ON public."Events_p2023_08_13" USING btree ("createdAt");


--
-- Name: Events_p2023_08_13_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_13_expr_idx" ON public."Events_p2023_08_13" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_13_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_13_expr_idx1" ON public."Events_p2023_08_13" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_13_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_13_name_idx" ON public."Events_p2023_08_13" USING btree (name);


--
-- Name: Events_p2023_08_14_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_14_createdAt_idx" ON public."Events_p2023_08_14" USING btree ("createdAt");


--
-- Name: Events_p2023_08_14_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_14_expr_idx" ON public."Events_p2023_08_14" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_14_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_14_expr_idx1" ON public."Events_p2023_08_14" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_14_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_14_name_idx" ON public."Events_p2023_08_14" USING btree (name);


--
-- Name: Events_p2023_08_15_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_15_createdAt_idx" ON public."Events_p2023_08_15" USING btree ("createdAt");


--
-- Name: Events_p2023_08_15_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_15_expr_idx" ON public."Events_p2023_08_15" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_15_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_15_expr_idx1" ON public."Events_p2023_08_15" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_15_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_15_name_idx" ON public."Events_p2023_08_15" USING btree (name);


--
-- Name: Events_p2023_08_16_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_16_createdAt_idx" ON public."Events_p2023_08_16" USING btree ("createdAt");


--
-- Name: Events_p2023_08_16_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_16_expr_idx" ON public."Events_p2023_08_16" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_16_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_16_expr_idx1" ON public."Events_p2023_08_16" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_16_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_16_name_idx" ON public."Events_p2023_08_16" USING btree (name);


--
-- Name: Events_p2023_08_17_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_17_createdAt_idx" ON public."Events_p2023_08_17" USING btree ("createdAt");


--
-- Name: Events_p2023_08_17_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_17_expr_idx" ON public."Events_p2023_08_17" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_17_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_17_expr_idx1" ON public."Events_p2023_08_17" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_17_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_17_name_idx" ON public."Events_p2023_08_17" USING btree (name);


--
-- Name: Events_p2023_08_18_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_18_createdAt_idx" ON public."Events_p2023_08_18" USING btree ("createdAt");


--
-- Name: Events_p2023_08_18_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_18_expr_idx" ON public."Events_p2023_08_18" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_18_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_18_expr_idx1" ON public."Events_p2023_08_18" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_18_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_18_name_idx" ON public."Events_p2023_08_18" USING btree (name);


--
-- Name: Events_p2023_08_19_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_19_createdAt_idx" ON public."Events_p2023_08_19" USING btree ("createdAt");


--
-- Name: Events_p2023_08_19_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_19_expr_idx" ON public."Events_p2023_08_19" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_19_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_19_expr_idx1" ON public."Events_p2023_08_19" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_19_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_19_name_idx" ON public."Events_p2023_08_19" USING btree (name);


--
-- Name: Events_p2023_08_20_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_20_createdAt_idx" ON public."Events_p2023_08_20" USING btree ("createdAt");


--
-- Name: Events_p2023_08_20_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_20_expr_idx" ON public."Events_p2023_08_20" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_20_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_20_expr_idx1" ON public."Events_p2023_08_20" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_20_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_20_name_idx" ON public."Events_p2023_08_20" USING btree (name);


--
-- Name: Events_p2023_08_21_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_21_createdAt_idx" ON public."Events_p2023_08_21" USING btree ("createdAt");


--
-- Name: Events_p2023_08_21_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_21_expr_idx" ON public."Events_p2023_08_21" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_21_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_21_expr_idx1" ON public."Events_p2023_08_21" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_21_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_21_name_idx" ON public."Events_p2023_08_21" USING btree (name);


--
-- Name: Events_p2023_08_22_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_22_createdAt_idx" ON public."Events_p2023_08_22" USING btree ("createdAt");


--
-- Name: Events_p2023_08_22_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_22_expr_idx" ON public."Events_p2023_08_22" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_22_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_22_expr_idx1" ON public."Events_p2023_08_22" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_22_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_22_name_idx" ON public."Events_p2023_08_22" USING btree (name);


--
-- Name: Events_p2023_08_23_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_23_createdAt_idx" ON public."Events_p2023_08_23" USING btree ("createdAt");


--
-- Name: Events_p2023_08_23_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_23_expr_idx" ON public."Events_p2023_08_23" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_23_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_23_expr_idx1" ON public."Events_p2023_08_23" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_23_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_23_name_idx" ON public."Events_p2023_08_23" USING btree (name);


--
-- Name: Events_p2023_08_24_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_24_createdAt_idx" ON public."Events_p2023_08_24" USING btree ("createdAt");


--
-- Name: Events_p2023_08_24_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_24_expr_idx" ON public."Events_p2023_08_24" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_24_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_24_expr_idx1" ON public."Events_p2023_08_24" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_24_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_24_name_idx" ON public."Events_p2023_08_24" USING btree (name);


--
-- Name: Events_p2023_08_25_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_25_createdAt_idx" ON public."Events_p2023_08_25" USING btree ("createdAt");


--
-- Name: Events_p2023_08_25_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_25_expr_idx" ON public."Events_p2023_08_25" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_25_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_25_expr_idx1" ON public."Events_p2023_08_25" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_25_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_25_name_idx" ON public."Events_p2023_08_25" USING btree (name);


--
-- Name: Events_p2023_08_26_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_26_createdAt_idx" ON public."Events_p2023_08_26" USING btree ("createdAt");


--
-- Name: Events_p2023_08_26_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_26_expr_idx" ON public."Events_p2023_08_26" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_26_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_26_expr_idx1" ON public."Events_p2023_08_26" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_26_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_26_name_idx" ON public."Events_p2023_08_26" USING btree (name);


--
-- Name: Events_p2023_08_27_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_27_createdAt_idx" ON public."Events_p2023_08_27" USING btree ("createdAt");


--
-- Name: Events_p2023_08_27_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_27_expr_idx" ON public."Events_p2023_08_27" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_27_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_27_expr_idx1" ON public."Events_p2023_08_27" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_27_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_27_name_idx" ON public."Events_p2023_08_27" USING btree (name);


--
-- Name: Events_p2023_08_28_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_28_createdAt_idx" ON public."Events_p2023_08_28" USING btree ("createdAt");


--
-- Name: Events_p2023_08_28_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_28_expr_idx" ON public."Events_p2023_08_28" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_28_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_28_expr_idx1" ON public."Events_p2023_08_28" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_28_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_28_name_idx" ON public."Events_p2023_08_28" USING btree (name);


--
-- Name: Events_p2023_08_29_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_29_createdAt_idx" ON public."Events_p2023_08_29" USING btree ("createdAt");


--
-- Name: Events_p2023_08_29_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_29_expr_idx" ON public."Events_p2023_08_29" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_29_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_29_expr_idx1" ON public."Events_p2023_08_29" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_29_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_29_name_idx" ON public."Events_p2023_08_29" USING btree (name);


--
-- Name: Events_p2023_08_30_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_30_createdAt_idx" ON public."Events_p2023_08_30" USING btree ("createdAt");


--
-- Name: Events_p2023_08_30_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_30_expr_idx" ON public."Events_p2023_08_30" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_30_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_30_expr_idx1" ON public."Events_p2023_08_30" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_30_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_30_name_idx" ON public."Events_p2023_08_30" USING btree (name);


--
-- Name: Events_p2023_08_31_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_31_createdAt_idx" ON public."Events_p2023_08_31" USING btree ("createdAt");


--
-- Name: Events_p2023_08_31_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_31_expr_idx" ON public."Events_p2023_08_31" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_08_31_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_31_expr_idx1" ON public."Events_p2023_08_31" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_08_31_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_08_31_name_idx" ON public."Events_p2023_08_31" USING btree (name);


--
-- Name: Events_p2023_09_01_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_01_createdAt_idx" ON public."Events_p2023_09_01" USING btree ("createdAt");


--
-- Name: Events_p2023_09_01_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_01_expr_idx" ON public."Events_p2023_09_01" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_01_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_01_expr_idx1" ON public."Events_p2023_09_01" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_01_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_01_name_idx" ON public."Events_p2023_09_01" USING btree (name);


--
-- Name: Events_p2023_09_02_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_02_createdAt_idx" ON public."Events_p2023_09_02" USING btree ("createdAt");


--
-- Name: Events_p2023_09_02_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_02_expr_idx" ON public."Events_p2023_09_02" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_02_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_02_expr_idx1" ON public."Events_p2023_09_02" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_02_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_02_name_idx" ON public."Events_p2023_09_02" USING btree (name);


--
-- Name: Events_p2023_09_03_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_03_createdAt_idx" ON public."Events_p2023_09_03" USING btree ("createdAt");


--
-- Name: Events_p2023_09_03_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_03_expr_idx" ON public."Events_p2023_09_03" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_03_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_03_expr_idx1" ON public."Events_p2023_09_03" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_03_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_03_name_idx" ON public."Events_p2023_09_03" USING btree (name);


--
-- Name: Events_p2023_09_04_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_04_createdAt_idx" ON public."Events_p2023_09_04" USING btree ("createdAt");


--
-- Name: Events_p2023_09_04_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_04_expr_idx" ON public."Events_p2023_09_04" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_04_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_04_expr_idx1" ON public."Events_p2023_09_04" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_04_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_04_name_idx" ON public."Events_p2023_09_04" USING btree (name);


--
-- Name: Events_p2023_09_05_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_05_createdAt_idx" ON public."Events_p2023_09_05" USING btree ("createdAt");


--
-- Name: Events_p2023_09_05_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_05_expr_idx" ON public."Events_p2023_09_05" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_05_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_05_expr_idx1" ON public."Events_p2023_09_05" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_05_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_05_name_idx" ON public."Events_p2023_09_05" USING btree (name);


--
-- Name: Events_p2023_09_06_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_06_createdAt_idx" ON public."Events_p2023_09_06" USING btree ("createdAt");


--
-- Name: Events_p2023_09_06_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_06_expr_idx" ON public."Events_p2023_09_06" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_06_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_06_expr_idx1" ON public."Events_p2023_09_06" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_06_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_06_name_idx" ON public."Events_p2023_09_06" USING btree (name);


--
-- Name: Events_p2023_09_07_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_07_createdAt_idx" ON public."Events_p2023_09_07" USING btree ("createdAt");


--
-- Name: Events_p2023_09_07_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_07_expr_idx" ON public."Events_p2023_09_07" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_07_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_07_expr_idx1" ON public."Events_p2023_09_07" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_07_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_07_name_idx" ON public."Events_p2023_09_07" USING btree (name);


--
-- Name: Events_p2023_09_08_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_08_createdAt_idx" ON public."Events_p2023_09_08" USING btree ("createdAt");


--
-- Name: Events_p2023_09_08_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_08_expr_idx" ON public."Events_p2023_09_08" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_08_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_08_expr_idx1" ON public."Events_p2023_09_08" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_08_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_08_name_idx" ON public."Events_p2023_09_08" USING btree (name);


--
-- Name: Events_p2023_09_09_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_09_createdAt_idx" ON public."Events_p2023_09_09" USING btree ("createdAt");


--
-- Name: Events_p2023_09_09_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_09_expr_idx" ON public."Events_p2023_09_09" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_09_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_09_expr_idx1" ON public."Events_p2023_09_09" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_09_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_09_name_idx" ON public."Events_p2023_09_09" USING btree (name);


--
-- Name: Events_p2023_09_10_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_10_createdAt_idx" ON public."Events_p2023_09_10" USING btree ("createdAt");


--
-- Name: Events_p2023_09_10_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_10_expr_idx" ON public."Events_p2023_09_10" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_10_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_10_expr_idx1" ON public."Events_p2023_09_10" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_10_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_10_name_idx" ON public."Events_p2023_09_10" USING btree (name);


--
-- Name: Events_p2023_09_11_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_11_createdAt_idx" ON public."Events_p2023_09_11" USING btree ("createdAt");


--
-- Name: Events_p2023_09_11_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_11_expr_idx" ON public."Events_p2023_09_11" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_11_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_11_expr_idx1" ON public."Events_p2023_09_11" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_11_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_11_name_idx" ON public."Events_p2023_09_11" USING btree (name);


--
-- Name: Events_p2023_09_12_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_12_createdAt_idx" ON public."Events_p2023_09_12" USING btree ("createdAt");


--
-- Name: Events_p2023_09_12_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_12_expr_idx" ON public."Events_p2023_09_12" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_12_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_12_expr_idx1" ON public."Events_p2023_09_12" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_12_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_12_name_idx" ON public."Events_p2023_09_12" USING btree (name);


--
-- Name: Events_p2023_09_13_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_13_createdAt_idx" ON public."Events_p2023_09_13" USING btree ("createdAt");


--
-- Name: Events_p2023_09_13_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_13_expr_idx" ON public."Events_p2023_09_13" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_13_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_13_expr_idx1" ON public."Events_p2023_09_13" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_13_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_13_name_idx" ON public."Events_p2023_09_13" USING btree (name);


--
-- Name: Events_p2023_09_14_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_14_createdAt_idx" ON public."Events_p2023_09_14" USING btree ("createdAt");


--
-- Name: Events_p2023_09_14_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_14_expr_idx" ON public."Events_p2023_09_14" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_14_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_14_expr_idx1" ON public."Events_p2023_09_14" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_14_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_14_name_idx" ON public."Events_p2023_09_14" USING btree (name);


--
-- Name: Events_p2023_09_15_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_15_createdAt_idx" ON public."Events_p2023_09_15" USING btree ("createdAt");


--
-- Name: Events_p2023_09_15_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_15_expr_idx" ON public."Events_p2023_09_15" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_15_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_15_expr_idx1" ON public."Events_p2023_09_15" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_15_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_15_name_idx" ON public."Events_p2023_09_15" USING btree (name);


--
-- Name: Events_p2023_09_16_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_16_createdAt_idx" ON public."Events_p2023_09_16" USING btree ("createdAt");


--
-- Name: Events_p2023_09_16_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_16_expr_idx" ON public."Events_p2023_09_16" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_16_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_16_expr_idx1" ON public."Events_p2023_09_16" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_16_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_16_name_idx" ON public."Events_p2023_09_16" USING btree (name);


--
-- Name: Events_p2023_09_17_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_17_createdAt_idx" ON public."Events_p2023_09_17" USING btree ("createdAt");


--
-- Name: Events_p2023_09_17_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_17_expr_idx" ON public."Events_p2023_09_17" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_17_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_17_expr_idx1" ON public."Events_p2023_09_17" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_17_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_17_name_idx" ON public."Events_p2023_09_17" USING btree (name);


--
-- Name: Events_p2023_09_18_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_18_createdAt_idx" ON public."Events_p2023_09_18" USING btree ("createdAt");


--
-- Name: Events_p2023_09_18_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_18_expr_idx" ON public."Events_p2023_09_18" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_18_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_18_expr_idx1" ON public."Events_p2023_09_18" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_18_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_18_name_idx" ON public."Events_p2023_09_18" USING btree (name);


--
-- Name: Events_p2023_09_19_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_19_createdAt_idx" ON public."Events_p2023_09_19" USING btree ("createdAt");


--
-- Name: Events_p2023_09_19_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_19_expr_idx" ON public."Events_p2023_09_19" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_19_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_19_expr_idx1" ON public."Events_p2023_09_19" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_19_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_19_name_idx" ON public."Events_p2023_09_19" USING btree (name);


--
-- Name: Events_p2023_09_20_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_20_createdAt_idx" ON public."Events_p2023_09_20" USING btree ("createdAt");


--
-- Name: Events_p2023_09_20_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_20_expr_idx" ON public."Events_p2023_09_20" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_20_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_20_expr_idx1" ON public."Events_p2023_09_20" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_20_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_20_name_idx" ON public."Events_p2023_09_20" USING btree (name);


--
-- Name: Events_p2023_09_21_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_21_createdAt_idx" ON public."Events_p2023_09_21" USING btree ("createdAt");


--
-- Name: Events_p2023_09_21_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_21_expr_idx" ON public."Events_p2023_09_21" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_21_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_21_expr_idx1" ON public."Events_p2023_09_21" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_21_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_21_name_idx" ON public."Events_p2023_09_21" USING btree (name);


--
-- Name: Events_p2023_09_22_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_22_createdAt_idx" ON public."Events_p2023_09_22" USING btree ("createdAt");


--
-- Name: Events_p2023_09_22_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_22_expr_idx" ON public."Events_p2023_09_22" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_22_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_22_expr_idx1" ON public."Events_p2023_09_22" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_22_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_22_name_idx" ON public."Events_p2023_09_22" USING btree (name);


--
-- Name: Events_p2023_09_23_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_23_createdAt_idx" ON public."Events_p2023_09_23" USING btree ("createdAt");


--
-- Name: Events_p2023_09_23_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_23_expr_idx" ON public."Events_p2023_09_23" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_23_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_23_expr_idx1" ON public."Events_p2023_09_23" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_23_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_23_name_idx" ON public."Events_p2023_09_23" USING btree (name);


--
-- Name: Events_p2023_09_24_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_24_createdAt_idx" ON public."Events_p2023_09_24" USING btree ("createdAt");


--
-- Name: Events_p2023_09_24_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_24_expr_idx" ON public."Events_p2023_09_24" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_24_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_24_expr_idx1" ON public."Events_p2023_09_24" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_24_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_24_name_idx" ON public."Events_p2023_09_24" USING btree (name);


--
-- Name: Events_p2023_09_25_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_25_createdAt_idx" ON public."Events_p2023_09_25" USING btree ("createdAt");


--
-- Name: Events_p2023_09_25_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_25_expr_idx" ON public."Events_p2023_09_25" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_25_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_25_expr_idx1" ON public."Events_p2023_09_25" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_25_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_25_name_idx" ON public."Events_p2023_09_25" USING btree (name);


--
-- Name: Events_p2023_09_26_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_26_createdAt_idx" ON public."Events_p2023_09_26" USING btree ("createdAt");


--
-- Name: Events_p2023_09_26_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_26_expr_idx" ON public."Events_p2023_09_26" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_26_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_26_expr_idx1" ON public."Events_p2023_09_26" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_26_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_26_name_idx" ON public."Events_p2023_09_26" USING btree (name);


--
-- Name: Events_p2023_09_27_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_27_createdAt_idx" ON public."Events_p2023_09_27" USING btree ("createdAt");


--
-- Name: Events_p2023_09_27_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_27_expr_idx" ON public."Events_p2023_09_27" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_27_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_27_expr_idx1" ON public."Events_p2023_09_27" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_27_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_27_name_idx" ON public."Events_p2023_09_27" USING btree (name);


--
-- Name: Events_p2023_09_28_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_28_createdAt_idx" ON public."Events_p2023_09_28" USING btree ("createdAt");


--
-- Name: Events_p2023_09_28_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_28_expr_idx" ON public."Events_p2023_09_28" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_28_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_28_expr_idx1" ON public."Events_p2023_09_28" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_28_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_28_name_idx" ON public."Events_p2023_09_28" USING btree (name);


--
-- Name: Events_p2023_09_29_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_29_createdAt_idx" ON public."Events_p2023_09_29" USING btree ("createdAt");


--
-- Name: Events_p2023_09_29_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_29_expr_idx" ON public."Events_p2023_09_29" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_29_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_29_expr_idx1" ON public."Events_p2023_09_29" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_29_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_29_name_idx" ON public."Events_p2023_09_29" USING btree (name);


--
-- Name: Events_p2023_09_30_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_30_createdAt_idx" ON public."Events_p2023_09_30" USING btree ("createdAt");


--
-- Name: Events_p2023_09_30_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_30_expr_idx" ON public."Events_p2023_09_30" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_09_30_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_30_expr_idx1" ON public."Events_p2023_09_30" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_09_30_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_09_30_name_idx" ON public."Events_p2023_09_30" USING btree (name);


--
-- Name: Events_p2023_10_01_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_01_createdAt_idx" ON public."Events_p2023_10_01" USING btree ("createdAt");


--
-- Name: Events_p2023_10_01_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_01_expr_idx" ON public."Events_p2023_10_01" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_01_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_01_expr_idx1" ON public."Events_p2023_10_01" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_01_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_01_name_idx" ON public."Events_p2023_10_01" USING btree (name);


--
-- Name: Events_p2023_10_02_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_02_createdAt_idx" ON public."Events_p2023_10_02" USING btree ("createdAt");


--
-- Name: Events_p2023_10_02_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_02_expr_idx" ON public."Events_p2023_10_02" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_02_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_02_expr_idx1" ON public."Events_p2023_10_02" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_02_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_02_name_idx" ON public."Events_p2023_10_02" USING btree (name);


--
-- Name: Events_p2023_10_03_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_03_createdAt_idx" ON public."Events_p2023_10_03" USING btree ("createdAt");


--
-- Name: Events_p2023_10_03_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_03_expr_idx" ON public."Events_p2023_10_03" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_03_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_03_expr_idx1" ON public."Events_p2023_10_03" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_03_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_03_name_idx" ON public."Events_p2023_10_03" USING btree (name);


--
-- Name: Events_p2023_10_04_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_04_createdAt_idx" ON public."Events_p2023_10_04" USING btree ("createdAt");


--
-- Name: Events_p2023_10_04_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_04_expr_idx" ON public."Events_p2023_10_04" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_04_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_04_expr_idx1" ON public."Events_p2023_10_04" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_04_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_04_name_idx" ON public."Events_p2023_10_04" USING btree (name);


--
-- Name: Events_p2023_10_05_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_05_createdAt_idx" ON public."Events_p2023_10_05" USING btree ("createdAt");


--
-- Name: Events_p2023_10_05_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_05_expr_idx" ON public."Events_p2023_10_05" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_05_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_05_expr_idx1" ON public."Events_p2023_10_05" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_05_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_05_name_idx" ON public."Events_p2023_10_05" USING btree (name);


--
-- Name: Events_p2023_10_06_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_06_createdAt_idx" ON public."Events_p2023_10_06" USING btree ("createdAt");


--
-- Name: Events_p2023_10_06_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_06_expr_idx" ON public."Events_p2023_10_06" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_06_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_06_expr_idx1" ON public."Events_p2023_10_06" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_06_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_06_name_idx" ON public."Events_p2023_10_06" USING btree (name);


--
-- Name: Events_p2023_10_07_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_07_createdAt_idx" ON public."Events_p2023_10_07" USING btree ("createdAt");


--
-- Name: Events_p2023_10_07_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_07_expr_idx" ON public."Events_p2023_10_07" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_07_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_07_expr_idx1" ON public."Events_p2023_10_07" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_07_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_07_name_idx" ON public."Events_p2023_10_07" USING btree (name);


--
-- Name: Events_p2023_10_08_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_08_createdAt_idx" ON public."Events_p2023_10_08" USING btree ("createdAt");


--
-- Name: Events_p2023_10_08_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_08_expr_idx" ON public."Events_p2023_10_08" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_08_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_08_expr_idx1" ON public."Events_p2023_10_08" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_08_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_08_name_idx" ON public."Events_p2023_10_08" USING btree (name);


--
-- Name: Events_p2023_10_09_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_09_createdAt_idx" ON public."Events_p2023_10_09" USING btree ("createdAt");


--
-- Name: Events_p2023_10_09_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_09_expr_idx" ON public."Events_p2023_10_09" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_09_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_09_expr_idx1" ON public."Events_p2023_10_09" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_09_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_09_name_idx" ON public."Events_p2023_10_09" USING btree (name);


--
-- Name: Events_p2023_10_10_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_10_createdAt_idx" ON public."Events_p2023_10_10" USING btree ("createdAt");


--
-- Name: Events_p2023_10_10_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_10_expr_idx" ON public."Events_p2023_10_10" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_10_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_10_expr_idx1" ON public."Events_p2023_10_10" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_10_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_10_name_idx" ON public."Events_p2023_10_10" USING btree (name);


--
-- Name: Events_p2023_10_11_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_11_createdAt_idx" ON public."Events_p2023_10_11" USING btree ("createdAt");


--
-- Name: Events_p2023_10_11_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_11_expr_idx" ON public."Events_p2023_10_11" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_11_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_11_expr_idx1" ON public."Events_p2023_10_11" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_11_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_11_name_idx" ON public."Events_p2023_10_11" USING btree (name);


--
-- Name: Events_p2023_10_12_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_12_createdAt_idx" ON public."Events_p2023_10_12" USING btree ("createdAt");


--
-- Name: Events_p2023_10_12_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_12_expr_idx" ON public."Events_p2023_10_12" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_12_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_12_expr_idx1" ON public."Events_p2023_10_12" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_12_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_12_name_idx" ON public."Events_p2023_10_12" USING btree (name);


--
-- Name: Events_p2023_10_13_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_13_createdAt_idx" ON public."Events_p2023_10_13" USING btree ("createdAt");


--
-- Name: Events_p2023_10_13_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_13_expr_idx" ON public."Events_p2023_10_13" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_13_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_13_expr_idx1" ON public."Events_p2023_10_13" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_13_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_13_name_idx" ON public."Events_p2023_10_13" USING btree (name);


--
-- Name: Events_p2023_10_14_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_14_createdAt_idx" ON public."Events_p2023_10_14" USING btree ("createdAt");


--
-- Name: Events_p2023_10_14_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_14_expr_idx" ON public."Events_p2023_10_14" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_14_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_14_expr_idx1" ON public."Events_p2023_10_14" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_14_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_14_name_idx" ON public."Events_p2023_10_14" USING btree (name);


--
-- Name: Events_p2023_10_15_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_15_createdAt_idx" ON public."Events_p2023_10_15" USING btree ("createdAt");


--
-- Name: Events_p2023_10_15_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_15_expr_idx" ON public."Events_p2023_10_15" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_15_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_15_expr_idx1" ON public."Events_p2023_10_15" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_15_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_15_name_idx" ON public."Events_p2023_10_15" USING btree (name);


--
-- Name: Events_p2023_10_16_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_16_createdAt_idx" ON public."Events_p2023_10_16" USING btree ("createdAt");


--
-- Name: Events_p2023_10_16_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_16_expr_idx" ON public."Events_p2023_10_16" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_16_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_16_expr_idx1" ON public."Events_p2023_10_16" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_16_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_16_name_idx" ON public."Events_p2023_10_16" USING btree (name);


--
-- Name: Events_p2023_10_17_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_17_createdAt_idx" ON public."Events_p2023_10_17" USING btree ("createdAt");


--
-- Name: Events_p2023_10_17_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_17_expr_idx" ON public."Events_p2023_10_17" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_17_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_17_expr_idx1" ON public."Events_p2023_10_17" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_17_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_17_name_idx" ON public."Events_p2023_10_17" USING btree (name);


--
-- Name: Events_p2023_10_18_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_18_createdAt_idx" ON public."Events_p2023_10_18" USING btree ("createdAt");


--
-- Name: Events_p2023_10_18_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_18_expr_idx" ON public."Events_p2023_10_18" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_18_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_18_expr_idx1" ON public."Events_p2023_10_18" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_18_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_18_name_idx" ON public."Events_p2023_10_18" USING btree (name);


--
-- Name: Events_p2023_10_19_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_19_createdAt_idx" ON public."Events_p2023_10_19" USING btree ("createdAt");


--
-- Name: Events_p2023_10_19_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_19_expr_idx" ON public."Events_p2023_10_19" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_19_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_19_expr_idx1" ON public."Events_p2023_10_19" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_19_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_19_name_idx" ON public."Events_p2023_10_19" USING btree (name);


--
-- Name: Events_p2023_10_20_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_20_createdAt_idx" ON public."Events_p2023_10_20" USING btree ("createdAt");


--
-- Name: Events_p2023_10_20_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_20_expr_idx" ON public."Events_p2023_10_20" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_20_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_20_expr_idx1" ON public."Events_p2023_10_20" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_20_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_20_name_idx" ON public."Events_p2023_10_20" USING btree (name);


--
-- Name: Events_p2023_10_21_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_21_createdAt_idx" ON public."Events_p2023_10_21" USING btree ("createdAt");


--
-- Name: Events_p2023_10_21_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_21_expr_idx" ON public."Events_p2023_10_21" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_21_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_21_expr_idx1" ON public."Events_p2023_10_21" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_21_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_21_name_idx" ON public."Events_p2023_10_21" USING btree (name);


--
-- Name: Events_p2023_10_22_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_22_createdAt_idx" ON public."Events_p2023_10_22" USING btree ("createdAt");


--
-- Name: Events_p2023_10_22_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_22_expr_idx" ON public."Events_p2023_10_22" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_22_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_22_expr_idx1" ON public."Events_p2023_10_22" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_22_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_22_name_idx" ON public."Events_p2023_10_22" USING btree (name);


--
-- Name: Events_p2023_10_23_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_23_createdAt_idx" ON public."Events_p2023_10_23" USING btree ("createdAt");


--
-- Name: Events_p2023_10_23_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_23_expr_idx" ON public."Events_p2023_10_23" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_23_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_23_expr_idx1" ON public."Events_p2023_10_23" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_23_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_23_name_idx" ON public."Events_p2023_10_23" USING btree (name);


--
-- Name: Events_p2023_10_24_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_24_createdAt_idx" ON public."Events_p2023_10_24" USING btree ("createdAt");


--
-- Name: Events_p2023_10_24_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_24_expr_idx" ON public."Events_p2023_10_24" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_24_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_24_expr_idx1" ON public."Events_p2023_10_24" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_24_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_24_name_idx" ON public."Events_p2023_10_24" USING btree (name);


--
-- Name: Events_p2023_10_25_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_25_createdAt_idx" ON public."Events_p2023_10_25" USING btree ("createdAt");


--
-- Name: Events_p2023_10_25_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_25_expr_idx" ON public."Events_p2023_10_25" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_25_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_25_expr_idx1" ON public."Events_p2023_10_25" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_25_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_25_name_idx" ON public."Events_p2023_10_25" USING btree (name);


--
-- Name: Events_p2023_10_26_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_26_createdAt_idx" ON public."Events_p2023_10_26" USING btree ("createdAt");


--
-- Name: Events_p2023_10_26_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_26_expr_idx" ON public."Events_p2023_10_26" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_26_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_26_expr_idx1" ON public."Events_p2023_10_26" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_26_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_26_name_idx" ON public."Events_p2023_10_26" USING btree (name);


--
-- Name: Events_p2023_10_27_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_27_createdAt_idx" ON public."Events_p2023_10_27" USING btree ("createdAt");


--
-- Name: Events_p2023_10_27_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_27_expr_idx" ON public."Events_p2023_10_27" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_27_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_27_expr_idx1" ON public."Events_p2023_10_27" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_27_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_27_name_idx" ON public."Events_p2023_10_27" USING btree (name);


--
-- Name: Events_p2023_10_28_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_28_createdAt_idx" ON public."Events_p2023_10_28" USING btree ("createdAt");


--
-- Name: Events_p2023_10_28_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_28_expr_idx" ON public."Events_p2023_10_28" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_28_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_28_expr_idx1" ON public."Events_p2023_10_28" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_28_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_28_name_idx" ON public."Events_p2023_10_28" USING btree (name);


--
-- Name: Events_p2023_10_29_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_29_createdAt_idx" ON public."Events_p2023_10_29" USING btree ("createdAt");


--
-- Name: Events_p2023_10_29_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_29_expr_idx" ON public."Events_p2023_10_29" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_29_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_29_expr_idx1" ON public."Events_p2023_10_29" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_29_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_29_name_idx" ON public."Events_p2023_10_29" USING btree (name);


--
-- Name: Events_p2023_10_30_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_30_createdAt_idx" ON public."Events_p2023_10_30" USING btree ("createdAt");


--
-- Name: Events_p2023_10_30_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_30_expr_idx" ON public."Events_p2023_10_30" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_30_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_30_expr_idx1" ON public."Events_p2023_10_30" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_30_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_30_name_idx" ON public."Events_p2023_10_30" USING btree (name);


--
-- Name: Events_p2023_10_31_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_31_createdAt_idx" ON public."Events_p2023_10_31" USING btree ("createdAt");


--
-- Name: Events_p2023_10_31_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_31_expr_idx" ON public."Events_p2023_10_31" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_10_31_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_31_expr_idx1" ON public."Events_p2023_10_31" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_10_31_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_10_31_name_idx" ON public."Events_p2023_10_31" USING btree (name);


--
-- Name: Events_p2023_11_01_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_01_createdAt_idx" ON public."Events_p2023_11_01" USING btree ("createdAt");


--
-- Name: Events_p2023_11_01_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_01_expr_idx" ON public."Events_p2023_11_01" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_01_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_01_expr_idx1" ON public."Events_p2023_11_01" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_01_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_01_name_idx" ON public."Events_p2023_11_01" USING btree (name);


--
-- Name: Events_p2023_11_02_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_02_createdAt_idx" ON public."Events_p2023_11_02" USING btree ("createdAt");


--
-- Name: Events_p2023_11_02_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_02_expr_idx" ON public."Events_p2023_11_02" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_02_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_02_expr_idx1" ON public."Events_p2023_11_02" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_02_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_02_name_idx" ON public."Events_p2023_11_02" USING btree (name);


--
-- Name: Events_p2023_11_03_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_03_createdAt_idx" ON public."Events_p2023_11_03" USING btree ("createdAt");


--
-- Name: Events_p2023_11_03_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_03_expr_idx" ON public."Events_p2023_11_03" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_03_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_03_expr_idx1" ON public."Events_p2023_11_03" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_03_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_03_name_idx" ON public."Events_p2023_11_03" USING btree (name);


--
-- Name: Events_p2023_11_04_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_04_createdAt_idx" ON public."Events_p2023_11_04" USING btree ("createdAt");


--
-- Name: Events_p2023_11_04_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_04_expr_idx" ON public."Events_p2023_11_04" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_04_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_04_expr_idx1" ON public."Events_p2023_11_04" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_04_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_04_name_idx" ON public."Events_p2023_11_04" USING btree (name);


--
-- Name: Events_p2023_11_05_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_05_createdAt_idx" ON public."Events_p2023_11_05" USING btree ("createdAt");


--
-- Name: Events_p2023_11_05_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_05_expr_idx" ON public."Events_p2023_11_05" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_05_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_05_expr_idx1" ON public."Events_p2023_11_05" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_05_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_05_name_idx" ON public."Events_p2023_11_05" USING btree (name);


--
-- Name: Events_p2023_11_06_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_06_createdAt_idx" ON public."Events_p2023_11_06" USING btree ("createdAt");


--
-- Name: Events_p2023_11_06_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_06_expr_idx" ON public."Events_p2023_11_06" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_06_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_06_expr_idx1" ON public."Events_p2023_11_06" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_06_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_06_name_idx" ON public."Events_p2023_11_06" USING btree (name);


--
-- Name: Events_p2023_11_07_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_07_createdAt_idx" ON public."Events_p2023_11_07" USING btree ("createdAt");


--
-- Name: Events_p2023_11_07_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_07_expr_idx" ON public."Events_p2023_11_07" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_07_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_07_expr_idx1" ON public."Events_p2023_11_07" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_07_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_07_name_idx" ON public."Events_p2023_11_07" USING btree (name);


--
-- Name: Events_p2023_11_08_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_08_createdAt_idx" ON public."Events_p2023_11_08" USING btree ("createdAt");


--
-- Name: Events_p2023_11_08_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_08_expr_idx" ON public."Events_p2023_11_08" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_08_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_08_expr_idx1" ON public."Events_p2023_11_08" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_08_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_08_name_idx" ON public."Events_p2023_11_08" USING btree (name);


--
-- Name: Events_p2023_11_09_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_09_createdAt_idx" ON public."Events_p2023_11_09" USING btree ("createdAt");


--
-- Name: Events_p2023_11_09_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_09_expr_idx" ON public."Events_p2023_11_09" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_09_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_09_expr_idx1" ON public."Events_p2023_11_09" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_09_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_09_name_idx" ON public."Events_p2023_11_09" USING btree (name);


--
-- Name: Events_p2023_11_10_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_10_createdAt_idx" ON public."Events_p2023_11_10" USING btree ("createdAt");


--
-- Name: Events_p2023_11_10_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_10_expr_idx" ON public."Events_p2023_11_10" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_10_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_10_expr_idx1" ON public."Events_p2023_11_10" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_10_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_10_name_idx" ON public."Events_p2023_11_10" USING btree (name);


--
-- Name: Events_p2023_11_11_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_11_createdAt_idx" ON public."Events_p2023_11_11" USING btree ("createdAt");


--
-- Name: Events_p2023_11_11_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_11_expr_idx" ON public."Events_p2023_11_11" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_11_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_11_expr_idx1" ON public."Events_p2023_11_11" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_11_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_11_name_idx" ON public."Events_p2023_11_11" USING btree (name);


--
-- Name: Events_p2023_11_12_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_12_createdAt_idx" ON public."Events_p2023_11_12" USING btree ("createdAt");


--
-- Name: Events_p2023_11_12_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_12_expr_idx" ON public."Events_p2023_11_12" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_12_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_12_expr_idx1" ON public."Events_p2023_11_12" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_12_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_12_name_idx" ON public."Events_p2023_11_12" USING btree (name);


--
-- Name: Events_p2023_11_13_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_13_createdAt_idx" ON public."Events_p2023_11_13" USING btree ("createdAt");


--
-- Name: Events_p2023_11_13_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_13_expr_idx" ON public."Events_p2023_11_13" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_13_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_13_expr_idx1" ON public."Events_p2023_11_13" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_13_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_13_name_idx" ON public."Events_p2023_11_13" USING btree (name);


--
-- Name: Events_p2023_11_14_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_14_createdAt_idx" ON public."Events_p2023_11_14" USING btree ("createdAt");


--
-- Name: Events_p2023_11_14_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_14_expr_idx" ON public."Events_p2023_11_14" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_14_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_14_expr_idx1" ON public."Events_p2023_11_14" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_14_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_14_name_idx" ON public."Events_p2023_11_14" USING btree (name);


--
-- Name: Events_p2023_11_15_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_15_createdAt_idx" ON public."Events_p2023_11_15" USING btree ("createdAt");


--
-- Name: Events_p2023_11_15_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_15_expr_idx" ON public."Events_p2023_11_15" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_15_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_15_expr_idx1" ON public."Events_p2023_11_15" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_15_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_15_name_idx" ON public."Events_p2023_11_15" USING btree (name);


--
-- Name: Events_p2023_11_16_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_16_createdAt_idx" ON public."Events_p2023_11_16" USING btree ("createdAt");


--
-- Name: Events_p2023_11_16_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_16_expr_idx" ON public."Events_p2023_11_16" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_16_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_16_expr_idx1" ON public."Events_p2023_11_16" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_16_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_16_name_idx" ON public."Events_p2023_11_16" USING btree (name);


--
-- Name: Events_p2023_11_17_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_17_createdAt_idx" ON public."Events_p2023_11_17" USING btree ("createdAt");


--
-- Name: Events_p2023_11_17_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_17_expr_idx" ON public."Events_p2023_11_17" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_17_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_17_expr_idx1" ON public."Events_p2023_11_17" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_17_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_17_name_idx" ON public."Events_p2023_11_17" USING btree (name);


--
-- Name: Events_p2023_11_18_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_18_createdAt_idx" ON public."Events_p2023_11_18" USING btree ("createdAt");


--
-- Name: Events_p2023_11_18_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_18_expr_idx" ON public."Events_p2023_11_18" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_18_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_18_expr_idx1" ON public."Events_p2023_11_18" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_18_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_18_name_idx" ON public."Events_p2023_11_18" USING btree (name);


--
-- Name: Events_p2023_11_19_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_19_createdAt_idx" ON public."Events_p2023_11_19" USING btree ("createdAt");


--
-- Name: Events_p2023_11_19_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_19_expr_idx" ON public."Events_p2023_11_19" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_19_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_19_expr_idx1" ON public."Events_p2023_11_19" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_19_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_19_name_idx" ON public."Events_p2023_11_19" USING btree (name);


--
-- Name: Events_p2023_11_20_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_20_createdAt_idx" ON public."Events_p2023_11_20" USING btree ("createdAt");


--
-- Name: Events_p2023_11_20_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_20_expr_idx" ON public."Events_p2023_11_20" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_20_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_20_expr_idx1" ON public."Events_p2023_11_20" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_20_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_20_name_idx" ON public."Events_p2023_11_20" USING btree (name);


--
-- Name: Events_p2023_11_21_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_21_createdAt_idx" ON public."Events_p2023_11_21" USING btree ("createdAt");


--
-- Name: Events_p2023_11_21_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_21_expr_idx" ON public."Events_p2023_11_21" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_21_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_21_expr_idx1" ON public."Events_p2023_11_21" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_21_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_21_name_idx" ON public."Events_p2023_11_21" USING btree (name);


--
-- Name: Events_p2023_11_22_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_22_createdAt_idx" ON public."Events_p2023_11_22" USING btree ("createdAt");


--
-- Name: Events_p2023_11_22_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_22_expr_idx" ON public."Events_p2023_11_22" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_22_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_22_expr_idx1" ON public."Events_p2023_11_22" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_22_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_22_name_idx" ON public."Events_p2023_11_22" USING btree (name);


--
-- Name: Events_p2023_11_23_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_23_createdAt_idx" ON public."Events_p2023_11_23" USING btree ("createdAt");


--
-- Name: Events_p2023_11_23_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_23_expr_idx" ON public."Events_p2023_11_23" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_23_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_23_expr_idx1" ON public."Events_p2023_11_23" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_23_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_23_name_idx" ON public."Events_p2023_11_23" USING btree (name);


--
-- Name: Events_p2023_11_24_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_24_createdAt_idx" ON public."Events_p2023_11_24" USING btree ("createdAt");


--
-- Name: Events_p2023_11_24_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_24_expr_idx" ON public."Events_p2023_11_24" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_24_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_24_expr_idx1" ON public."Events_p2023_11_24" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_24_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_24_name_idx" ON public."Events_p2023_11_24" USING btree (name);


--
-- Name: Events_p2023_11_25_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_25_createdAt_idx" ON public."Events_p2023_11_25" USING btree ("createdAt");


--
-- Name: Events_p2023_11_25_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_25_expr_idx" ON public."Events_p2023_11_25" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_25_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_25_expr_idx1" ON public."Events_p2023_11_25" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_25_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_25_name_idx" ON public."Events_p2023_11_25" USING btree (name);


--
-- Name: Events_p2023_11_26_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_26_createdAt_idx" ON public."Events_p2023_11_26" USING btree ("createdAt");


--
-- Name: Events_p2023_11_26_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_26_expr_idx" ON public."Events_p2023_11_26" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_26_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_26_expr_idx1" ON public."Events_p2023_11_26" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_26_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_26_name_idx" ON public."Events_p2023_11_26" USING btree (name);


--
-- Name: Events_p2023_11_27_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_27_createdAt_idx" ON public."Events_p2023_11_27" USING btree ("createdAt");


--
-- Name: Events_p2023_11_27_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_27_expr_idx" ON public."Events_p2023_11_27" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_27_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_27_expr_idx1" ON public."Events_p2023_11_27" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_27_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_27_name_idx" ON public."Events_p2023_11_27" USING btree (name);


--
-- Name: Events_p2023_11_28_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_28_createdAt_idx" ON public."Events_p2023_11_28" USING btree ("createdAt");


--
-- Name: Events_p2023_11_28_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_28_expr_idx" ON public."Events_p2023_11_28" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_28_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_28_expr_idx1" ON public."Events_p2023_11_28" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_28_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_28_name_idx" ON public."Events_p2023_11_28" USING btree (name);


--
-- Name: Events_p2023_11_29_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_29_createdAt_idx" ON public."Events_p2023_11_29" USING btree ("createdAt");


--
-- Name: Events_p2023_11_29_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_29_expr_idx" ON public."Events_p2023_11_29" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_29_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_29_expr_idx1" ON public."Events_p2023_11_29" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_29_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_29_name_idx" ON public."Events_p2023_11_29" USING btree (name);


--
-- Name: Events_p2023_11_30_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_30_createdAt_idx" ON public."Events_p2023_11_30" USING btree ("createdAt");


--
-- Name: Events_p2023_11_30_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_30_expr_idx" ON public."Events_p2023_11_30" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_11_30_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_30_expr_idx1" ON public."Events_p2023_11_30" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_11_30_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_11_30_name_idx" ON public."Events_p2023_11_30" USING btree (name);


--
-- Name: Events_p2023_12_01_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_01_createdAt_idx" ON public."Events_p2023_12_01" USING btree ("createdAt");


--
-- Name: Events_p2023_12_01_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_01_expr_idx" ON public."Events_p2023_12_01" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_01_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_01_expr_idx1" ON public."Events_p2023_12_01" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_01_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_01_name_idx" ON public."Events_p2023_12_01" USING btree (name);


--
-- Name: Events_p2023_12_02_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_02_createdAt_idx" ON public."Events_p2023_12_02" USING btree ("createdAt");


--
-- Name: Events_p2023_12_02_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_02_expr_idx" ON public."Events_p2023_12_02" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_02_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_02_expr_idx1" ON public."Events_p2023_12_02" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_02_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_02_name_idx" ON public."Events_p2023_12_02" USING btree (name);


--
-- Name: Events_p2023_12_03_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_03_createdAt_idx" ON public."Events_p2023_12_03" USING btree ("createdAt");


--
-- Name: Events_p2023_12_03_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_03_expr_idx" ON public."Events_p2023_12_03" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_03_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_03_expr_idx1" ON public."Events_p2023_12_03" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_03_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_03_name_idx" ON public."Events_p2023_12_03" USING btree (name);


--
-- Name: Events_p2023_12_04_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_04_createdAt_idx" ON public."Events_p2023_12_04" USING btree ("createdAt");


--
-- Name: Events_p2023_12_04_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_04_expr_idx" ON public."Events_p2023_12_04" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_04_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_04_expr_idx1" ON public."Events_p2023_12_04" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_04_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_04_name_idx" ON public."Events_p2023_12_04" USING btree (name);


--
-- Name: Events_p2023_12_05_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_05_createdAt_idx" ON public."Events_p2023_12_05" USING btree ("createdAt");


--
-- Name: Events_p2023_12_05_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_05_expr_idx" ON public."Events_p2023_12_05" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_05_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_05_expr_idx1" ON public."Events_p2023_12_05" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_05_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_05_name_idx" ON public."Events_p2023_12_05" USING btree (name);


--
-- Name: Events_p2023_12_06_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_06_createdAt_idx" ON public."Events_p2023_12_06" USING btree ("createdAt");


--
-- Name: Events_p2023_12_06_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_06_expr_idx" ON public."Events_p2023_12_06" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_06_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_06_expr_idx1" ON public."Events_p2023_12_06" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_06_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_06_name_idx" ON public."Events_p2023_12_06" USING btree (name);


--
-- Name: Events_p2023_12_07_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_07_createdAt_idx" ON public."Events_p2023_12_07" USING btree ("createdAt");


--
-- Name: Events_p2023_12_07_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_07_expr_idx" ON public."Events_p2023_12_07" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_07_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_07_expr_idx1" ON public."Events_p2023_12_07" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_07_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_07_name_idx" ON public."Events_p2023_12_07" USING btree (name);


--
-- Name: Events_p2023_12_08_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_08_createdAt_idx" ON public."Events_p2023_12_08" USING btree ("createdAt");


--
-- Name: Events_p2023_12_08_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_08_expr_idx" ON public."Events_p2023_12_08" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_08_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_08_expr_idx1" ON public."Events_p2023_12_08" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_08_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_08_name_idx" ON public."Events_p2023_12_08" USING btree (name);


--
-- Name: Events_p2023_12_09_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_09_createdAt_idx" ON public."Events_p2023_12_09" USING btree ("createdAt");


--
-- Name: Events_p2023_12_09_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_09_expr_idx" ON public."Events_p2023_12_09" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_09_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_09_expr_idx1" ON public."Events_p2023_12_09" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_09_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_09_name_idx" ON public."Events_p2023_12_09" USING btree (name);


--
-- Name: Events_p2023_12_10_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_10_createdAt_idx" ON public."Events_p2023_12_10" USING btree ("createdAt");


--
-- Name: Events_p2023_12_10_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_10_expr_idx" ON public."Events_p2023_12_10" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_10_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_10_expr_idx1" ON public."Events_p2023_12_10" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_10_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_10_name_idx" ON public."Events_p2023_12_10" USING btree (name);


--
-- Name: Events_p2023_12_11_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_11_createdAt_idx" ON public."Events_p2023_12_11" USING btree ("createdAt");


--
-- Name: Events_p2023_12_11_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_11_expr_idx" ON public."Events_p2023_12_11" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_11_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_11_expr_idx1" ON public."Events_p2023_12_11" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_11_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_11_name_idx" ON public."Events_p2023_12_11" USING btree (name);


--
-- Name: Events_p2023_12_12_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_12_createdAt_idx" ON public."Events_p2023_12_12" USING btree ("createdAt");


--
-- Name: Events_p2023_12_12_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_12_expr_idx" ON public."Events_p2023_12_12" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_12_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_12_expr_idx1" ON public."Events_p2023_12_12" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_12_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_12_name_idx" ON public."Events_p2023_12_12" USING btree (name);


--
-- Name: Events_p2023_12_13_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_13_createdAt_idx" ON public."Events_p2023_12_13" USING btree ("createdAt");


--
-- Name: Events_p2023_12_13_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_13_expr_idx" ON public."Events_p2023_12_13" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_13_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_13_expr_idx1" ON public."Events_p2023_12_13" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_13_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_13_name_idx" ON public."Events_p2023_12_13" USING btree (name);


--
-- Name: Events_p2023_12_14_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_14_createdAt_idx" ON public."Events_p2023_12_14" USING btree ("createdAt");


--
-- Name: Events_p2023_12_14_expr_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_14_expr_idx" ON public."Events_p2023_12_14" USING btree (((body ->> 'objectId'::text)));


--
-- Name: Events_p2023_12_14_expr_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_14_expr_idx1" ON public."Events_p2023_12_14" USING btree (((body ->> 'externalImageId'::text)));


--
-- Name: Events_p2023_12_14_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Events_p2023_12_14_name_idx" ON public."Events_p2023_12_14" USING btree (name);


--
-- Name: ImageAnalysisMirrors_imageManifestId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ImageAnalysisMirrors_imageManifestId" ON public."ImageAnalysisMirrors" USING btree ("imageManifestId");


--
-- Name: ImagingPatientsSources_imagingPatientSource_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ImagingPatientsSources_imagingPatientSource_index" ON public."ImagingPatientsSources" USING btree ("imagingPatientSource");


--
-- Name: PmsTreatments_practiceId_treatmentDate; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "PmsTreatments_practiceId_treatmentDate" ON public."PmsTreatments" USING btree ("practiceId", "treatmentDate");


--
-- Name: analyzed_images_practice_id_organization_id_external_image_id_d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX analyzed_images_practice_id_organization_id_external_image_id_d ON public."AnalyzedImages" USING btree ("practiceId", "organizationId", "externalImageId", "deletedAt");


--
-- Name: cdt_codes_to_analyses_labels_cdt_code_label_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cdt_codes_to_analyses_labels_cdt_code_label_id ON public."CdtCodesToAnalysesLabels" USING btree ("cdtCode", "labelId");


--
-- Name: connector_backfill_configs_organization_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX connector_backfill_configs_organization_id ON public."ConnectorBackfillConfigs" USING btree ("organizationId");


--
-- Name: data_upload_audit_practice_videa_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_upload_audit_practice_videa_id ON public."DataUploadAudit" USING btree ("practiceVideaId");


--
-- Name: data_upload_triggers_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_upload_triggers_practice_id ON public."DataUploadTriggers" USING btree ("practiceId");


--
-- Name: entity_aliases_videa_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX entity_aliases_videa_id ON public."EntityAliases" USING btree ("videaId");


--
-- Name: estimated_visit_image_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX estimated_visit_image_created_at_idx ON public."EstimatedVisit" USING btree ("imageCreatedAt");


--
-- Name: estimated_visit_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX estimated_visit_patient_id ON public."EstimatedVisit" USING btree ("patientId");


--
-- Name: estimated_visit_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX estimated_visit_practice_id ON public."EstimatedVisit" USING btree ("practiceId");


--
-- Name: estimated_visit_practice_id_image_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX estimated_visit_practice_id_image_created_at ON public."EstimatedVisit" USING btree ("practiceId", "imageCreatedAt" DESC);


--
-- Name: idx_display_name_gin_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_display_name_gin_trgm ON public."PmsPatients" USING gin ("displayName" public.gin_trgm_ops);


--
-- Name: idx_estimatedVisitId_imageCount_userId_eventName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_estimatedVisitId_imageCount_userId_eventName" ON public."UserEvents" USING btree ("estimatedVisitId", "imageCount", "userId", "eventName");


--
-- Name: idx_name_gin_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_name_gin_trgm ON public."ImagingPatients" USING gin (name public.gin_trgm_ops);


--
-- Name: idx_organizationId_practiceId_status_procedureDate; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_organizationId_practiceId_status_procedureDate" ON public."CustomerTreatments" USING btree ("organizationId", "practiceId", status, "procedureDate");


--
-- Name: idx_organizationId_status_procedureDate; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_organizationId_status_procedureDate" ON public."CustomerTreatments" USING btree ("organizationId", status, "procedureDate");


--
-- Name: idx_practiceId_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_practiceId_status" ON public."CustomerTreatments" USING btree ("practiceId", status);


--
-- Name: idx_tokenOwnerId_tokenOwnerType_accessToken; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_tokenOwnerId_tokenOwnerType_accessToken" ON public."ExternalAccessTokens" USING btree ("tokenOwnerId", "tokenOwnerType", "accessToken");


--
-- Name: image_analysis_mirrors_mongo_db_analysis_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX image_analysis_mirrors_mongo_db_analysis_id ON public."ImageAnalysisMirrors" USING btree ("mongodbAnalysisId");


--
-- Name: image_catalog_image_manifest_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX image_catalog_image_manifest_id ON public."ImageCatalog" USING btree ("imageManifestId");


--
-- Name: imaging_patient_identifiers_chart_num_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX imaging_patient_identifiers_chart_num_idx ON public."ImagingPatientIdentifiers" USING btree ("chartNum");


--
-- Name: imaging_patient_identifiers_image_metadata_patient_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX imaging_patient_identifiers_image_metadata_patient_id_idx ON public."ImagingPatientIdentifiers" USING btree ("imageMetadataPatientId");


--
-- Name: imaging_patient_identifiers_imaging_patient_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX imaging_patient_identifiers_imaging_patient_id_idx ON public."ImagingPatientIdentifiers" USING btree ("imagingPatientId");


--
-- Name: imaging_patient_identifiers_practice_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX imaging_patient_identifiers_practice_id_idx ON public."ImagingPatientIdentifiers" USING btree ("practiceId");


--
-- Name: imaging_patient_sources_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX imaging_patient_sources_idx ON public."ImagingPatientsSources" USING btree ("imagingPatientSource");


--
-- Name: imaging_patients_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX imaging_patients_practice_id ON public."ImagingPatients" USING btree ("practiceId");


--
-- Name: integration_job_runs_practice_id_name_status_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX integration_job_runs_practice_id_name_status_updated_at ON public."IntegrationJobRuns" USING btree ("practiceId", name, status, "updatedAt");


--
-- Name: magic_link_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX magic_link_deleted_at ON public."MagicLink" USING btree ("deletedAt");


--
-- Name: magic_link_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX magic_link_key ON public."MagicLink" USING btree (key);


--
-- Name: magic_link_practice_id_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX magic_link_practice_id_created_at ON public."MagicLink" USING btree ("practiceId", "createdAt" DESC);


--
-- Name: organization_preferences_organization_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX organization_preferences_organization_id ON public."OrganizationPreferences" USING btree ("organizationId");


--
-- Name: patient_id_matches_imaging_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX patient_id_matches_imaging_patient_id ON public."PatientIdMatches" USING btree ("imagingPatientId");


--
-- Name: patient_id_matches_pms_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX patient_id_matches_pms_patient_id ON public."PatientIdMatches" USING btree ("pmsPatientId");


--
-- Name: patient_id_matches_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX patient_id_matches_practice_id ON public."PatientIdMatches" USING btree ("practiceId");


--
-- Name: patient_id_matches_unique_index_pmsPatientId_imagingPatientId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "patient_id_matches_unique_index_pmsPatientId_imagingPatientId" ON public."PatientIdMatches" USING btree ("pmsPatientId", "imagingPatientId");


--
-- Name: pms_appointment_to_treatments_appointment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_appointment_to_treatments_appointment_id ON public."PmsAppointmentToTreatments" USING btree ("appointmentId");


--
-- Name: pms_appointment_to_treatments_treatment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_appointment_to_treatments_treatment_id ON public."PmsAppointmentToTreatments" USING btree ("treatmentId");


--
-- Name: pms_appointments_operatory_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_appointments_operatory_id ON public."PmsAppointments" USING btree ("operatoryId");


--
-- Name: pms_appointments_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_appointments_patient_id ON public."PmsAppointments" USING btree ("patientId");


--
-- Name: pms_appointments_practice_id_pms_id_pms_integration_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pms_appointments_practice_id_pms_id_pms_integration_type ON public."PmsAppointments" USING btree ("practiceId", "pmsId", "pmsIntegrationType");


--
-- Name: pms_appointments_provider_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_appointments_provider_id ON public."PmsAppointments" USING btree ("providerId");


--
-- Name: pms_appointments_start_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_appointments_start_date_idx ON public."PmsAppointments" USING btree ("startDate");


--
-- Name: pms_operatories_practice_id_pms_id_pms_integration_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pms_operatories_practice_id_pms_id_pms_integration_type ON public."PmsOperatories" USING btree ("practiceId", "pmsId", "pmsIntegrationType");


--
-- Name: pms_patients_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_patients_practice_id ON public."PmsPatients" USING btree ("practiceId");


--
-- Name: pms_patients_practice_id_pms_id_pms_integration_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pms_patients_practice_id_pms_id_pms_integration_type ON public."PmsPatients" USING btree ("practiceId", "pmsId", "pmsIntegrationType");


--
-- Name: pms_providers_practice_id_pms_id_pms_integration_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pms_providers_practice_id_pms_id_pms_integration_type ON public."PmsProviders" USING btree ("practiceId", "pmsId", "pmsIntegrationType");


--
-- Name: pms_treatments_cdt_code_gin_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_treatments_cdt_code_gin_idx ON public."PmsTreatments" USING gin ("cdtCode" public.gin_trgm_ops);


--
-- Name: pms_treatments_cdt_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_treatments_cdt_code_idx ON public."PmsTreatments" USING btree ("cdtCode");


--
-- Name: pms_treatments_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pms_treatments_patient_id ON public."PmsTreatments" USING btree ("patientId");


--
-- Name: pms_treatments_practice_id_pms_id_pms_integration_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pms_treatments_practice_id_pms_id_pms_integration_type ON public."PmsTreatments" USING btree ("practiceId", "pmsId", "pmsIntegrationType");


--
-- Name: pmspatients_organizationId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "pmspatients_organizationId_idx" ON public."PmsPatients" USING btree ("organizationId");


--
-- Name: pmsproviders_organizationId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "pmsproviders_organizationId_idx" ON public."PmsProviders" USING btree ("organizationId");


--
-- Name: practice_preferences_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX practice_preferences_practice_id ON public."PracticePreferences" USING btree ("practiceId");


--
-- Name: product_keys_practice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_keys_practice_id ON public."ProductKeys" USING btree ("practiceId");


--
-- Name: provisioned_entities_videa_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provisioned_entities_videa_id ON public."ProvisionedEntities" USING btree ("videaId");


--
-- Name: quarantine_images_image_manifest_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX quarantine_images_image_manifest_id ON public."QuarantineImages" USING btree ("imageManifestId");


--
-- Name: unified_appointments_appointment_on; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX unified_appointments_appointment_on ON public."UnifiedAppointments" USING btree ("appointmentOn");


--
-- Name: unified_appointments_estimated_visit_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unified_appointments_estimated_visit_id ON public."UnifiedAppointments" USING btree ("estimatedVisitId") WHERE ("estimatedVisitId" IS NOT NULL);


--
-- Name: unified_appointments_imaging_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX unified_appointments_imaging_patient_id ON public."UnifiedAppointments" USING btree ("imagingPatientId");


--
-- Name: unified_appointments_pms_appointment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unified_appointments_pms_appointment_id ON public."UnifiedAppointments" USING btree ("pmsAppointmentId") WHERE ("pmsAppointmentId" IS NOT NULL);


--
-- Name: unified_appointments_pms_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX unified_appointments_pms_patient_id ON public."UnifiedAppointments" USING btree ("pmsPatientId");


--
-- Name: unified_appointments_practice_id_appointment_on; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX unified_appointments_practice_id_appointment_on ON public."UnifiedAppointments" USING btree ("practiceId", "appointmentOn" DESC);


--
-- Name: unifiedappointments_organizationId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "unifiedappointments_organizationId_idx" ON public."UnifiedAppointments" USING btree ("organizationId");


--
-- Name: unique_ci_constraint_organization_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_ci_constraint_organization_name ON public."Organizations" USING btree (lower((name)::text));


--
-- Name: unique_ci_constraint_practice_name_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_ci_constraint_practice_name_org ON public."Practices" USING btree (lower((name)::text), "organizationId");


--
-- Name: unique_constraint_practiceid_chartnum_metadataid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_constraint_practiceid_chartnum_metadataid ON public."ImagingPatientIdentifiers" USING btree (COALESCE("imageMetadataPatientId", '-1'::character varying), COALESCE("chartNum", '-1'::character varying), "practiceId");


--
-- Name: user_preferences_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_preferences_user_id ON public."UserPreferences" USING btree ("userId");


--
-- Name: Events_default_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_default_createdAt_idx";


--
-- Name: Events_default_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_default_expr_idx";


--
-- Name: Events_default_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_default_expr_idx1";


--
-- Name: Events_default_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_default_name_idx";


--
-- Name: Events_default_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_default_pkey";


--
-- Name: Events_p2023_07_17_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_17_createdAt_idx";


--
-- Name: Events_p2023_07_17_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_17_expr_idx";


--
-- Name: Events_p2023_07_17_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_17_expr_idx1";


--
-- Name: Events_p2023_07_17_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_17_name_idx";


--
-- Name: Events_p2023_07_17_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_17_pkey";


--
-- Name: Events_p2023_07_18_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_18_createdAt_idx";


--
-- Name: Events_p2023_07_18_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_18_expr_idx";


--
-- Name: Events_p2023_07_18_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_18_expr_idx1";


--
-- Name: Events_p2023_07_18_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_18_name_idx";


--
-- Name: Events_p2023_07_18_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_18_pkey";


--
-- Name: Events_p2023_07_19_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_19_createdAt_idx";


--
-- Name: Events_p2023_07_19_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_19_expr_idx";


--
-- Name: Events_p2023_07_19_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_19_expr_idx1";


--
-- Name: Events_p2023_07_19_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_19_name_idx";


--
-- Name: Events_p2023_07_19_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_19_pkey";


--
-- Name: Events_p2023_07_20_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_20_createdAt_idx";


--
-- Name: Events_p2023_07_20_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_20_expr_idx";


--
-- Name: Events_p2023_07_20_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_20_expr_idx1";


--
-- Name: Events_p2023_07_20_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_20_name_idx";


--
-- Name: Events_p2023_07_20_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_20_pkey";


--
-- Name: Events_p2023_07_21_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_21_createdAt_idx";


--
-- Name: Events_p2023_07_21_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_21_expr_idx";


--
-- Name: Events_p2023_07_21_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_21_expr_idx1";


--
-- Name: Events_p2023_07_21_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_21_name_idx";


--
-- Name: Events_p2023_07_21_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_21_pkey";


--
-- Name: Events_p2023_07_22_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_22_createdAt_idx";


--
-- Name: Events_p2023_07_22_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_22_expr_idx";


--
-- Name: Events_p2023_07_22_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_22_expr_idx1";


--
-- Name: Events_p2023_07_22_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_22_name_idx";


--
-- Name: Events_p2023_07_22_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_22_pkey";


--
-- Name: Events_p2023_07_23_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_23_createdAt_idx";


--
-- Name: Events_p2023_07_23_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_23_expr_idx";


--
-- Name: Events_p2023_07_23_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_23_expr_idx1";


--
-- Name: Events_p2023_07_23_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_23_name_idx";


--
-- Name: Events_p2023_07_23_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_23_pkey";


--
-- Name: Events_p2023_07_24_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_24_createdAt_idx";


--
-- Name: Events_p2023_07_24_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_24_expr_idx";


--
-- Name: Events_p2023_07_24_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_24_expr_idx1";


--
-- Name: Events_p2023_07_24_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_24_name_idx";


--
-- Name: Events_p2023_07_24_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_24_pkey";


--
-- Name: Events_p2023_07_25_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_25_createdAt_idx";


--
-- Name: Events_p2023_07_25_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_25_expr_idx";


--
-- Name: Events_p2023_07_25_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_25_expr_idx1";


--
-- Name: Events_p2023_07_25_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_25_name_idx";


--
-- Name: Events_p2023_07_25_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_25_pkey";


--
-- Name: Events_p2023_07_26_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_26_createdAt_idx";


--
-- Name: Events_p2023_07_26_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_26_expr_idx";


--
-- Name: Events_p2023_07_26_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_26_expr_idx1";


--
-- Name: Events_p2023_07_26_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_26_name_idx";


--
-- Name: Events_p2023_07_26_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_26_pkey";


--
-- Name: Events_p2023_07_27_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_27_createdAt_idx";


--
-- Name: Events_p2023_07_27_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_27_expr_idx";


--
-- Name: Events_p2023_07_27_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_27_expr_idx1";


--
-- Name: Events_p2023_07_27_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_27_name_idx";


--
-- Name: Events_p2023_07_27_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_27_pkey";


--
-- Name: Events_p2023_07_28_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_28_createdAt_idx";


--
-- Name: Events_p2023_07_28_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_28_expr_idx";


--
-- Name: Events_p2023_07_28_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_28_expr_idx1";


--
-- Name: Events_p2023_07_28_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_28_name_idx";


--
-- Name: Events_p2023_07_28_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_28_pkey";


--
-- Name: Events_p2023_07_29_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_29_createdAt_idx";


--
-- Name: Events_p2023_07_29_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_29_expr_idx";


--
-- Name: Events_p2023_07_29_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_29_expr_idx1";


--
-- Name: Events_p2023_07_29_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_29_name_idx";


--
-- Name: Events_p2023_07_29_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_29_pkey";


--
-- Name: Events_p2023_07_30_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_30_createdAt_idx";


--
-- Name: Events_p2023_07_30_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_30_expr_idx";


--
-- Name: Events_p2023_07_30_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_30_expr_idx1";


--
-- Name: Events_p2023_07_30_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_30_name_idx";


--
-- Name: Events_p2023_07_30_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_30_pkey";


--
-- Name: Events_p2023_07_31_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_07_31_createdAt_idx";


--
-- Name: Events_p2023_07_31_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_07_31_expr_idx";


--
-- Name: Events_p2023_07_31_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_07_31_expr_idx1";


--
-- Name: Events_p2023_07_31_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_07_31_name_idx";


--
-- Name: Events_p2023_07_31_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_07_31_pkey";


--
-- Name: Events_p2023_08_01_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_01_createdAt_idx";


--
-- Name: Events_p2023_08_01_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_01_expr_idx";


--
-- Name: Events_p2023_08_01_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_01_expr_idx1";


--
-- Name: Events_p2023_08_01_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_01_name_idx";


--
-- Name: Events_p2023_08_01_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_01_pkey";


--
-- Name: Events_p2023_08_02_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_02_createdAt_idx";


--
-- Name: Events_p2023_08_02_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_02_expr_idx";


--
-- Name: Events_p2023_08_02_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_02_expr_idx1";


--
-- Name: Events_p2023_08_02_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_02_name_idx";


--
-- Name: Events_p2023_08_02_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_02_pkey";


--
-- Name: Events_p2023_08_03_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_03_createdAt_idx";


--
-- Name: Events_p2023_08_03_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_03_expr_idx";


--
-- Name: Events_p2023_08_03_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_03_expr_idx1";


--
-- Name: Events_p2023_08_03_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_03_name_idx";


--
-- Name: Events_p2023_08_03_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_03_pkey";


--
-- Name: Events_p2023_08_04_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_04_createdAt_idx";


--
-- Name: Events_p2023_08_04_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_04_expr_idx";


--
-- Name: Events_p2023_08_04_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_04_expr_idx1";


--
-- Name: Events_p2023_08_04_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_04_name_idx";


--
-- Name: Events_p2023_08_04_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_04_pkey";


--
-- Name: Events_p2023_08_05_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_05_createdAt_idx";


--
-- Name: Events_p2023_08_05_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_05_expr_idx";


--
-- Name: Events_p2023_08_05_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_05_expr_idx1";


--
-- Name: Events_p2023_08_05_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_05_name_idx";


--
-- Name: Events_p2023_08_05_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_05_pkey";


--
-- Name: Events_p2023_08_06_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_06_createdAt_idx";


--
-- Name: Events_p2023_08_06_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_06_expr_idx";


--
-- Name: Events_p2023_08_06_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_06_expr_idx1";


--
-- Name: Events_p2023_08_06_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_06_name_idx";


--
-- Name: Events_p2023_08_06_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_06_pkey";


--
-- Name: Events_p2023_08_07_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_07_createdAt_idx";


--
-- Name: Events_p2023_08_07_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_07_expr_idx";


--
-- Name: Events_p2023_08_07_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_07_expr_idx1";


--
-- Name: Events_p2023_08_07_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_07_name_idx";


--
-- Name: Events_p2023_08_07_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_07_pkey";


--
-- Name: Events_p2023_08_08_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_08_createdAt_idx";


--
-- Name: Events_p2023_08_08_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_08_expr_idx";


--
-- Name: Events_p2023_08_08_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_08_expr_idx1";


--
-- Name: Events_p2023_08_08_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_08_name_idx";


--
-- Name: Events_p2023_08_08_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_08_pkey";


--
-- Name: Events_p2023_08_09_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_09_createdAt_idx";


--
-- Name: Events_p2023_08_09_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_09_expr_idx";


--
-- Name: Events_p2023_08_09_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_09_expr_idx1";


--
-- Name: Events_p2023_08_09_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_09_name_idx";


--
-- Name: Events_p2023_08_09_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_09_pkey";


--
-- Name: Events_p2023_08_10_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_10_createdAt_idx";


--
-- Name: Events_p2023_08_10_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_10_expr_idx";


--
-- Name: Events_p2023_08_10_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_10_expr_idx1";


--
-- Name: Events_p2023_08_10_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_10_name_idx";


--
-- Name: Events_p2023_08_10_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_10_pkey";


--
-- Name: Events_p2023_08_11_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_11_createdAt_idx";


--
-- Name: Events_p2023_08_11_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_11_expr_idx";


--
-- Name: Events_p2023_08_11_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_11_expr_idx1";


--
-- Name: Events_p2023_08_11_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_11_name_idx";


--
-- Name: Events_p2023_08_11_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_11_pkey";


--
-- Name: Events_p2023_08_12_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_12_createdAt_idx";


--
-- Name: Events_p2023_08_12_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_12_expr_idx";


--
-- Name: Events_p2023_08_12_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_12_expr_idx1";


--
-- Name: Events_p2023_08_12_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_12_name_idx";


--
-- Name: Events_p2023_08_12_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_12_pkey";


--
-- Name: Events_p2023_08_13_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_13_createdAt_idx";


--
-- Name: Events_p2023_08_13_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_13_expr_idx";


--
-- Name: Events_p2023_08_13_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_13_expr_idx1";


--
-- Name: Events_p2023_08_13_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_13_name_idx";


--
-- Name: Events_p2023_08_13_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_13_pkey";


--
-- Name: Events_p2023_08_14_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_14_createdAt_idx";


--
-- Name: Events_p2023_08_14_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_14_expr_idx";


--
-- Name: Events_p2023_08_14_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_14_expr_idx1";


--
-- Name: Events_p2023_08_14_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_14_name_idx";


--
-- Name: Events_p2023_08_14_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_14_pkey";


--
-- Name: Events_p2023_08_15_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_15_createdAt_idx";


--
-- Name: Events_p2023_08_15_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_15_expr_idx";


--
-- Name: Events_p2023_08_15_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_15_expr_idx1";


--
-- Name: Events_p2023_08_15_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_15_name_idx";


--
-- Name: Events_p2023_08_15_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_15_pkey";


--
-- Name: Events_p2023_08_16_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_16_createdAt_idx";


--
-- Name: Events_p2023_08_16_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_16_expr_idx";


--
-- Name: Events_p2023_08_16_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_16_expr_idx1";


--
-- Name: Events_p2023_08_16_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_16_name_idx";


--
-- Name: Events_p2023_08_16_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_16_pkey";


--
-- Name: Events_p2023_08_17_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_17_createdAt_idx";


--
-- Name: Events_p2023_08_17_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_17_expr_idx";


--
-- Name: Events_p2023_08_17_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_17_expr_idx1";


--
-- Name: Events_p2023_08_17_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_17_name_idx";


--
-- Name: Events_p2023_08_17_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_17_pkey";


--
-- Name: Events_p2023_08_18_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_18_createdAt_idx";


--
-- Name: Events_p2023_08_18_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_18_expr_idx";


--
-- Name: Events_p2023_08_18_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_18_expr_idx1";


--
-- Name: Events_p2023_08_18_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_18_name_idx";


--
-- Name: Events_p2023_08_18_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_18_pkey";


--
-- Name: Events_p2023_08_19_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_19_createdAt_idx";


--
-- Name: Events_p2023_08_19_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_19_expr_idx";


--
-- Name: Events_p2023_08_19_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_19_expr_idx1";


--
-- Name: Events_p2023_08_19_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_19_name_idx";


--
-- Name: Events_p2023_08_19_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_19_pkey";


--
-- Name: Events_p2023_08_20_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_20_createdAt_idx";


--
-- Name: Events_p2023_08_20_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_20_expr_idx";


--
-- Name: Events_p2023_08_20_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_20_expr_idx1";


--
-- Name: Events_p2023_08_20_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_20_name_idx";


--
-- Name: Events_p2023_08_20_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_20_pkey";


--
-- Name: Events_p2023_08_21_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_21_createdAt_idx";


--
-- Name: Events_p2023_08_21_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_21_expr_idx";


--
-- Name: Events_p2023_08_21_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_21_expr_idx1";


--
-- Name: Events_p2023_08_21_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_21_name_idx";


--
-- Name: Events_p2023_08_21_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_21_pkey";


--
-- Name: Events_p2023_08_22_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_22_createdAt_idx";


--
-- Name: Events_p2023_08_22_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_22_expr_idx";


--
-- Name: Events_p2023_08_22_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_22_expr_idx1";


--
-- Name: Events_p2023_08_22_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_22_name_idx";


--
-- Name: Events_p2023_08_22_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_22_pkey";


--
-- Name: Events_p2023_08_23_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_23_createdAt_idx";


--
-- Name: Events_p2023_08_23_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_23_expr_idx";


--
-- Name: Events_p2023_08_23_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_23_expr_idx1";


--
-- Name: Events_p2023_08_23_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_23_name_idx";


--
-- Name: Events_p2023_08_23_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_23_pkey";


--
-- Name: Events_p2023_08_24_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_24_createdAt_idx";


--
-- Name: Events_p2023_08_24_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_24_expr_idx";


--
-- Name: Events_p2023_08_24_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_24_expr_idx1";


--
-- Name: Events_p2023_08_24_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_24_name_idx";


--
-- Name: Events_p2023_08_24_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_24_pkey";


--
-- Name: Events_p2023_08_25_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_25_createdAt_idx";


--
-- Name: Events_p2023_08_25_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_25_expr_idx";


--
-- Name: Events_p2023_08_25_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_25_expr_idx1";


--
-- Name: Events_p2023_08_25_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_25_name_idx";


--
-- Name: Events_p2023_08_25_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_25_pkey";


--
-- Name: Events_p2023_08_26_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_26_createdAt_idx";


--
-- Name: Events_p2023_08_26_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_26_expr_idx";


--
-- Name: Events_p2023_08_26_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_26_expr_idx1";


--
-- Name: Events_p2023_08_26_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_26_name_idx";


--
-- Name: Events_p2023_08_26_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_26_pkey";


--
-- Name: Events_p2023_08_27_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_27_createdAt_idx";


--
-- Name: Events_p2023_08_27_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_27_expr_idx";


--
-- Name: Events_p2023_08_27_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_27_expr_idx1";


--
-- Name: Events_p2023_08_27_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_27_name_idx";


--
-- Name: Events_p2023_08_27_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_27_pkey";


--
-- Name: Events_p2023_08_28_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_28_createdAt_idx";


--
-- Name: Events_p2023_08_28_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_28_expr_idx";


--
-- Name: Events_p2023_08_28_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_28_expr_idx1";


--
-- Name: Events_p2023_08_28_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_28_name_idx";


--
-- Name: Events_p2023_08_28_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_28_pkey";


--
-- Name: Events_p2023_08_29_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_29_createdAt_idx";


--
-- Name: Events_p2023_08_29_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_29_expr_idx";


--
-- Name: Events_p2023_08_29_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_29_expr_idx1";


--
-- Name: Events_p2023_08_29_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_29_name_idx";


--
-- Name: Events_p2023_08_29_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_29_pkey";


--
-- Name: Events_p2023_08_30_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_30_createdAt_idx";


--
-- Name: Events_p2023_08_30_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_30_expr_idx";


--
-- Name: Events_p2023_08_30_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_30_expr_idx1";


--
-- Name: Events_p2023_08_30_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_30_name_idx";


--
-- Name: Events_p2023_08_30_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_30_pkey";


--
-- Name: Events_p2023_08_31_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_08_31_createdAt_idx";


--
-- Name: Events_p2023_08_31_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_08_31_expr_idx";


--
-- Name: Events_p2023_08_31_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_08_31_expr_idx1";


--
-- Name: Events_p2023_08_31_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_08_31_name_idx";


--
-- Name: Events_p2023_08_31_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_08_31_pkey";


--
-- Name: Events_p2023_09_01_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_01_createdAt_idx";


--
-- Name: Events_p2023_09_01_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_01_expr_idx";


--
-- Name: Events_p2023_09_01_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_01_expr_idx1";


--
-- Name: Events_p2023_09_01_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_01_name_idx";


--
-- Name: Events_p2023_09_01_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_01_pkey";


--
-- Name: Events_p2023_09_02_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_02_createdAt_idx";


--
-- Name: Events_p2023_09_02_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_02_expr_idx";


--
-- Name: Events_p2023_09_02_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_02_expr_idx1";


--
-- Name: Events_p2023_09_02_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_02_name_idx";


--
-- Name: Events_p2023_09_02_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_02_pkey";


--
-- Name: Events_p2023_09_03_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_03_createdAt_idx";


--
-- Name: Events_p2023_09_03_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_03_expr_idx";


--
-- Name: Events_p2023_09_03_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_03_expr_idx1";


--
-- Name: Events_p2023_09_03_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_03_name_idx";


--
-- Name: Events_p2023_09_03_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_03_pkey";


--
-- Name: Events_p2023_09_04_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_04_createdAt_idx";


--
-- Name: Events_p2023_09_04_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_04_expr_idx";


--
-- Name: Events_p2023_09_04_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_04_expr_idx1";


--
-- Name: Events_p2023_09_04_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_04_name_idx";


--
-- Name: Events_p2023_09_04_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_04_pkey";


--
-- Name: Events_p2023_09_05_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_05_createdAt_idx";


--
-- Name: Events_p2023_09_05_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_05_expr_idx";


--
-- Name: Events_p2023_09_05_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_05_expr_idx1";


--
-- Name: Events_p2023_09_05_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_05_name_idx";


--
-- Name: Events_p2023_09_05_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_05_pkey";


--
-- Name: Events_p2023_09_06_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_06_createdAt_idx";


--
-- Name: Events_p2023_09_06_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_06_expr_idx";


--
-- Name: Events_p2023_09_06_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_06_expr_idx1";


--
-- Name: Events_p2023_09_06_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_06_name_idx";


--
-- Name: Events_p2023_09_06_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_06_pkey";


--
-- Name: Events_p2023_09_07_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_07_createdAt_idx";


--
-- Name: Events_p2023_09_07_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_07_expr_idx";


--
-- Name: Events_p2023_09_07_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_07_expr_idx1";


--
-- Name: Events_p2023_09_07_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_07_name_idx";


--
-- Name: Events_p2023_09_07_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_07_pkey";


--
-- Name: Events_p2023_09_08_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_08_createdAt_idx";


--
-- Name: Events_p2023_09_08_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_08_expr_idx";


--
-- Name: Events_p2023_09_08_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_08_expr_idx1";


--
-- Name: Events_p2023_09_08_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_08_name_idx";


--
-- Name: Events_p2023_09_08_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_08_pkey";


--
-- Name: Events_p2023_09_09_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_09_createdAt_idx";


--
-- Name: Events_p2023_09_09_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_09_expr_idx";


--
-- Name: Events_p2023_09_09_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_09_expr_idx1";


--
-- Name: Events_p2023_09_09_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_09_name_idx";


--
-- Name: Events_p2023_09_09_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_09_pkey";


--
-- Name: Events_p2023_09_10_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_10_createdAt_idx";


--
-- Name: Events_p2023_09_10_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_10_expr_idx";


--
-- Name: Events_p2023_09_10_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_10_expr_idx1";


--
-- Name: Events_p2023_09_10_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_10_name_idx";


--
-- Name: Events_p2023_09_10_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_10_pkey";


--
-- Name: Events_p2023_09_11_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_11_createdAt_idx";


--
-- Name: Events_p2023_09_11_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_11_expr_idx";


--
-- Name: Events_p2023_09_11_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_11_expr_idx1";


--
-- Name: Events_p2023_09_11_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_11_name_idx";


--
-- Name: Events_p2023_09_11_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_11_pkey";


--
-- Name: Events_p2023_09_12_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_12_createdAt_idx";


--
-- Name: Events_p2023_09_12_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_12_expr_idx";


--
-- Name: Events_p2023_09_12_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_12_expr_idx1";


--
-- Name: Events_p2023_09_12_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_12_name_idx";


--
-- Name: Events_p2023_09_12_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_12_pkey";


--
-- Name: Events_p2023_09_13_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_13_createdAt_idx";


--
-- Name: Events_p2023_09_13_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_13_expr_idx";


--
-- Name: Events_p2023_09_13_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_13_expr_idx1";


--
-- Name: Events_p2023_09_13_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_13_name_idx";


--
-- Name: Events_p2023_09_13_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_13_pkey";


--
-- Name: Events_p2023_09_14_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_14_createdAt_idx";


--
-- Name: Events_p2023_09_14_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_14_expr_idx";


--
-- Name: Events_p2023_09_14_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_14_expr_idx1";


--
-- Name: Events_p2023_09_14_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_14_name_idx";


--
-- Name: Events_p2023_09_14_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_14_pkey";


--
-- Name: Events_p2023_09_15_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_15_createdAt_idx";


--
-- Name: Events_p2023_09_15_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_15_expr_idx";


--
-- Name: Events_p2023_09_15_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_15_expr_idx1";


--
-- Name: Events_p2023_09_15_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_15_name_idx";


--
-- Name: Events_p2023_09_15_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_15_pkey";


--
-- Name: Events_p2023_09_16_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_16_createdAt_idx";


--
-- Name: Events_p2023_09_16_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_16_expr_idx";


--
-- Name: Events_p2023_09_16_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_16_expr_idx1";


--
-- Name: Events_p2023_09_16_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_16_name_idx";


--
-- Name: Events_p2023_09_16_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_16_pkey";


--
-- Name: Events_p2023_09_17_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_17_createdAt_idx";


--
-- Name: Events_p2023_09_17_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_17_expr_idx";


--
-- Name: Events_p2023_09_17_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_17_expr_idx1";


--
-- Name: Events_p2023_09_17_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_17_name_idx";


--
-- Name: Events_p2023_09_17_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_17_pkey";


--
-- Name: Events_p2023_09_18_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_18_createdAt_idx";


--
-- Name: Events_p2023_09_18_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_18_expr_idx";


--
-- Name: Events_p2023_09_18_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_18_expr_idx1";


--
-- Name: Events_p2023_09_18_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_18_name_idx";


--
-- Name: Events_p2023_09_18_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_18_pkey";


--
-- Name: Events_p2023_09_19_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_19_createdAt_idx";


--
-- Name: Events_p2023_09_19_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_19_expr_idx";


--
-- Name: Events_p2023_09_19_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_19_expr_idx1";


--
-- Name: Events_p2023_09_19_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_19_name_idx";


--
-- Name: Events_p2023_09_19_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_19_pkey";


--
-- Name: Events_p2023_09_20_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_20_createdAt_idx";


--
-- Name: Events_p2023_09_20_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_20_expr_idx";


--
-- Name: Events_p2023_09_20_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_20_expr_idx1";


--
-- Name: Events_p2023_09_20_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_20_name_idx";


--
-- Name: Events_p2023_09_20_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_20_pkey";


--
-- Name: Events_p2023_09_21_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_21_createdAt_idx";


--
-- Name: Events_p2023_09_21_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_21_expr_idx";


--
-- Name: Events_p2023_09_21_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_21_expr_idx1";


--
-- Name: Events_p2023_09_21_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_21_name_idx";


--
-- Name: Events_p2023_09_21_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_21_pkey";


--
-- Name: Events_p2023_09_22_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_22_createdAt_idx";


--
-- Name: Events_p2023_09_22_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_22_expr_idx";


--
-- Name: Events_p2023_09_22_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_22_expr_idx1";


--
-- Name: Events_p2023_09_22_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_22_name_idx";


--
-- Name: Events_p2023_09_22_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_22_pkey";


--
-- Name: Events_p2023_09_23_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_23_createdAt_idx";


--
-- Name: Events_p2023_09_23_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_23_expr_idx";


--
-- Name: Events_p2023_09_23_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_23_expr_idx1";


--
-- Name: Events_p2023_09_23_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_23_name_idx";


--
-- Name: Events_p2023_09_23_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_23_pkey";


--
-- Name: Events_p2023_09_24_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_24_createdAt_idx";


--
-- Name: Events_p2023_09_24_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_24_expr_idx";


--
-- Name: Events_p2023_09_24_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_24_expr_idx1";


--
-- Name: Events_p2023_09_24_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_24_name_idx";


--
-- Name: Events_p2023_09_24_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_24_pkey";


--
-- Name: Events_p2023_09_25_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_25_createdAt_idx";


--
-- Name: Events_p2023_09_25_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_25_expr_idx";


--
-- Name: Events_p2023_09_25_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_25_expr_idx1";


--
-- Name: Events_p2023_09_25_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_25_name_idx";


--
-- Name: Events_p2023_09_25_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_25_pkey";


--
-- Name: Events_p2023_09_26_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_26_createdAt_idx";


--
-- Name: Events_p2023_09_26_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_26_expr_idx";


--
-- Name: Events_p2023_09_26_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_26_expr_idx1";


--
-- Name: Events_p2023_09_26_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_26_name_idx";


--
-- Name: Events_p2023_09_26_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_26_pkey";


--
-- Name: Events_p2023_09_27_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_27_createdAt_idx";


--
-- Name: Events_p2023_09_27_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_27_expr_idx";


--
-- Name: Events_p2023_09_27_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_27_expr_idx1";


--
-- Name: Events_p2023_09_27_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_27_name_idx";


--
-- Name: Events_p2023_09_27_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_27_pkey";


--
-- Name: Events_p2023_09_28_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_28_createdAt_idx";


--
-- Name: Events_p2023_09_28_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_28_expr_idx";


--
-- Name: Events_p2023_09_28_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_28_expr_idx1";


--
-- Name: Events_p2023_09_28_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_28_name_idx";


--
-- Name: Events_p2023_09_28_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_28_pkey";


--
-- Name: Events_p2023_09_29_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_29_createdAt_idx";


--
-- Name: Events_p2023_09_29_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_29_expr_idx";


--
-- Name: Events_p2023_09_29_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_29_expr_idx1";


--
-- Name: Events_p2023_09_29_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_29_name_idx";


--
-- Name: Events_p2023_09_29_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_29_pkey";


--
-- Name: Events_p2023_09_30_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_09_30_createdAt_idx";


--
-- Name: Events_p2023_09_30_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_09_30_expr_idx";


--
-- Name: Events_p2023_09_30_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_09_30_expr_idx1";


--
-- Name: Events_p2023_09_30_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_09_30_name_idx";


--
-- Name: Events_p2023_09_30_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_09_30_pkey";


--
-- Name: Events_p2023_10_01_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_01_createdAt_idx";


--
-- Name: Events_p2023_10_01_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_01_expr_idx";


--
-- Name: Events_p2023_10_01_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_01_expr_idx1";


--
-- Name: Events_p2023_10_01_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_01_name_idx";


--
-- Name: Events_p2023_10_01_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_01_pkey";


--
-- Name: Events_p2023_10_02_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_02_createdAt_idx";


--
-- Name: Events_p2023_10_02_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_02_expr_idx";


--
-- Name: Events_p2023_10_02_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_02_expr_idx1";


--
-- Name: Events_p2023_10_02_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_02_name_idx";


--
-- Name: Events_p2023_10_02_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_02_pkey";


--
-- Name: Events_p2023_10_03_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_03_createdAt_idx";


--
-- Name: Events_p2023_10_03_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_03_expr_idx";


--
-- Name: Events_p2023_10_03_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_03_expr_idx1";


--
-- Name: Events_p2023_10_03_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_03_name_idx";


--
-- Name: Events_p2023_10_03_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_03_pkey";


--
-- Name: Events_p2023_10_04_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_04_createdAt_idx";


--
-- Name: Events_p2023_10_04_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_04_expr_idx";


--
-- Name: Events_p2023_10_04_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_04_expr_idx1";


--
-- Name: Events_p2023_10_04_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_04_name_idx";


--
-- Name: Events_p2023_10_04_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_04_pkey";


--
-- Name: Events_p2023_10_05_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_05_createdAt_idx";


--
-- Name: Events_p2023_10_05_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_05_expr_idx";


--
-- Name: Events_p2023_10_05_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_05_expr_idx1";


--
-- Name: Events_p2023_10_05_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_05_name_idx";


--
-- Name: Events_p2023_10_05_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_05_pkey";


--
-- Name: Events_p2023_10_06_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_06_createdAt_idx";


--
-- Name: Events_p2023_10_06_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_06_expr_idx";


--
-- Name: Events_p2023_10_06_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_06_expr_idx1";


--
-- Name: Events_p2023_10_06_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_06_name_idx";


--
-- Name: Events_p2023_10_06_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_06_pkey";


--
-- Name: Events_p2023_10_07_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_07_createdAt_idx";


--
-- Name: Events_p2023_10_07_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_07_expr_idx";


--
-- Name: Events_p2023_10_07_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_07_expr_idx1";


--
-- Name: Events_p2023_10_07_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_07_name_idx";


--
-- Name: Events_p2023_10_07_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_07_pkey";


--
-- Name: Events_p2023_10_08_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_08_createdAt_idx";


--
-- Name: Events_p2023_10_08_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_08_expr_idx";


--
-- Name: Events_p2023_10_08_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_08_expr_idx1";


--
-- Name: Events_p2023_10_08_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_08_name_idx";


--
-- Name: Events_p2023_10_08_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_08_pkey";


--
-- Name: Events_p2023_10_09_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_09_createdAt_idx";


--
-- Name: Events_p2023_10_09_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_09_expr_idx";


--
-- Name: Events_p2023_10_09_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_09_expr_idx1";


--
-- Name: Events_p2023_10_09_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_09_name_idx";


--
-- Name: Events_p2023_10_09_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_09_pkey";


--
-- Name: Events_p2023_10_10_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_10_createdAt_idx";


--
-- Name: Events_p2023_10_10_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_10_expr_idx";


--
-- Name: Events_p2023_10_10_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_10_expr_idx1";


--
-- Name: Events_p2023_10_10_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_10_name_idx";


--
-- Name: Events_p2023_10_10_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_10_pkey";


--
-- Name: Events_p2023_10_11_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_11_createdAt_idx";


--
-- Name: Events_p2023_10_11_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_11_expr_idx";


--
-- Name: Events_p2023_10_11_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_11_expr_idx1";


--
-- Name: Events_p2023_10_11_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_11_name_idx";


--
-- Name: Events_p2023_10_11_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_11_pkey";


--
-- Name: Events_p2023_10_12_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_12_createdAt_idx";


--
-- Name: Events_p2023_10_12_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_12_expr_idx";


--
-- Name: Events_p2023_10_12_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_12_expr_idx1";


--
-- Name: Events_p2023_10_12_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_12_name_idx";


--
-- Name: Events_p2023_10_12_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_12_pkey";


--
-- Name: Events_p2023_10_13_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_13_createdAt_idx";


--
-- Name: Events_p2023_10_13_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_13_expr_idx";


--
-- Name: Events_p2023_10_13_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_13_expr_idx1";


--
-- Name: Events_p2023_10_13_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_13_name_idx";


--
-- Name: Events_p2023_10_13_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_13_pkey";


--
-- Name: Events_p2023_10_14_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_14_createdAt_idx";


--
-- Name: Events_p2023_10_14_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_14_expr_idx";


--
-- Name: Events_p2023_10_14_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_14_expr_idx1";


--
-- Name: Events_p2023_10_14_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_14_name_idx";


--
-- Name: Events_p2023_10_14_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_14_pkey";


--
-- Name: Events_p2023_10_15_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_15_createdAt_idx";


--
-- Name: Events_p2023_10_15_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_15_expr_idx";


--
-- Name: Events_p2023_10_15_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_15_expr_idx1";


--
-- Name: Events_p2023_10_15_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_15_name_idx";


--
-- Name: Events_p2023_10_15_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_15_pkey";


--
-- Name: Events_p2023_10_16_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_16_createdAt_idx";


--
-- Name: Events_p2023_10_16_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_16_expr_idx";


--
-- Name: Events_p2023_10_16_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_16_expr_idx1";


--
-- Name: Events_p2023_10_16_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_16_name_idx";


--
-- Name: Events_p2023_10_16_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_16_pkey";


--
-- Name: Events_p2023_10_17_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_17_createdAt_idx";


--
-- Name: Events_p2023_10_17_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_17_expr_idx";


--
-- Name: Events_p2023_10_17_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_17_expr_idx1";


--
-- Name: Events_p2023_10_17_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_17_name_idx";


--
-- Name: Events_p2023_10_17_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_17_pkey";


--
-- Name: Events_p2023_10_18_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_18_createdAt_idx";


--
-- Name: Events_p2023_10_18_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_18_expr_idx";


--
-- Name: Events_p2023_10_18_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_18_expr_idx1";


--
-- Name: Events_p2023_10_18_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_18_name_idx";


--
-- Name: Events_p2023_10_18_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_18_pkey";


--
-- Name: Events_p2023_10_19_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_19_createdAt_idx";


--
-- Name: Events_p2023_10_19_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_19_expr_idx";


--
-- Name: Events_p2023_10_19_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_19_expr_idx1";


--
-- Name: Events_p2023_10_19_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_19_name_idx";


--
-- Name: Events_p2023_10_19_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_19_pkey";


--
-- Name: Events_p2023_10_20_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_20_createdAt_idx";


--
-- Name: Events_p2023_10_20_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_20_expr_idx";


--
-- Name: Events_p2023_10_20_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_20_expr_idx1";


--
-- Name: Events_p2023_10_20_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_20_name_idx";


--
-- Name: Events_p2023_10_20_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_20_pkey";


--
-- Name: Events_p2023_10_21_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_21_createdAt_idx";


--
-- Name: Events_p2023_10_21_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_21_expr_idx";


--
-- Name: Events_p2023_10_21_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_21_expr_idx1";


--
-- Name: Events_p2023_10_21_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_21_name_idx";


--
-- Name: Events_p2023_10_21_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_21_pkey";


--
-- Name: Events_p2023_10_22_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_22_createdAt_idx";


--
-- Name: Events_p2023_10_22_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_22_expr_idx";


--
-- Name: Events_p2023_10_22_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_22_expr_idx1";


--
-- Name: Events_p2023_10_22_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_22_name_idx";


--
-- Name: Events_p2023_10_22_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_22_pkey";


--
-- Name: Events_p2023_10_23_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_23_createdAt_idx";


--
-- Name: Events_p2023_10_23_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_23_expr_idx";


--
-- Name: Events_p2023_10_23_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_23_expr_idx1";


--
-- Name: Events_p2023_10_23_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_23_name_idx";


--
-- Name: Events_p2023_10_23_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_23_pkey";


--
-- Name: Events_p2023_10_24_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_24_createdAt_idx";


--
-- Name: Events_p2023_10_24_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_24_expr_idx";


--
-- Name: Events_p2023_10_24_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_24_expr_idx1";


--
-- Name: Events_p2023_10_24_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_24_name_idx";


--
-- Name: Events_p2023_10_24_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_24_pkey";


--
-- Name: Events_p2023_10_25_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_25_createdAt_idx";


--
-- Name: Events_p2023_10_25_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_25_expr_idx";


--
-- Name: Events_p2023_10_25_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_25_expr_idx1";


--
-- Name: Events_p2023_10_25_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_25_name_idx";


--
-- Name: Events_p2023_10_25_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_25_pkey";


--
-- Name: Events_p2023_10_26_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_26_createdAt_idx";


--
-- Name: Events_p2023_10_26_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_26_expr_idx";


--
-- Name: Events_p2023_10_26_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_26_expr_idx1";


--
-- Name: Events_p2023_10_26_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_26_name_idx";


--
-- Name: Events_p2023_10_26_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_26_pkey";


--
-- Name: Events_p2023_10_27_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_27_createdAt_idx";


--
-- Name: Events_p2023_10_27_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_27_expr_idx";


--
-- Name: Events_p2023_10_27_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_27_expr_idx1";


--
-- Name: Events_p2023_10_27_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_27_name_idx";


--
-- Name: Events_p2023_10_27_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_27_pkey";


--
-- Name: Events_p2023_10_28_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_28_createdAt_idx";


--
-- Name: Events_p2023_10_28_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_28_expr_idx";


--
-- Name: Events_p2023_10_28_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_28_expr_idx1";


--
-- Name: Events_p2023_10_28_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_28_name_idx";


--
-- Name: Events_p2023_10_28_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_28_pkey";


--
-- Name: Events_p2023_10_29_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_29_createdAt_idx";


--
-- Name: Events_p2023_10_29_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_29_expr_idx";


--
-- Name: Events_p2023_10_29_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_29_expr_idx1";


--
-- Name: Events_p2023_10_29_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_29_name_idx";


--
-- Name: Events_p2023_10_29_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_29_pkey";


--
-- Name: Events_p2023_10_30_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_30_createdAt_idx";


--
-- Name: Events_p2023_10_30_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_30_expr_idx";


--
-- Name: Events_p2023_10_30_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_30_expr_idx1";


--
-- Name: Events_p2023_10_30_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_30_name_idx";


--
-- Name: Events_p2023_10_30_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_30_pkey";


--
-- Name: Events_p2023_10_31_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_10_31_createdAt_idx";


--
-- Name: Events_p2023_10_31_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_10_31_expr_idx";


--
-- Name: Events_p2023_10_31_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_10_31_expr_idx1";


--
-- Name: Events_p2023_10_31_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_10_31_name_idx";


--
-- Name: Events_p2023_10_31_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_10_31_pkey";


--
-- Name: Events_p2023_11_01_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_01_createdAt_idx";


--
-- Name: Events_p2023_11_01_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_01_expr_idx";


--
-- Name: Events_p2023_11_01_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_01_expr_idx1";


--
-- Name: Events_p2023_11_01_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_01_name_idx";


--
-- Name: Events_p2023_11_01_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_01_pkey";


--
-- Name: Events_p2023_11_02_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_02_createdAt_idx";


--
-- Name: Events_p2023_11_02_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_02_expr_idx";


--
-- Name: Events_p2023_11_02_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_02_expr_idx1";


--
-- Name: Events_p2023_11_02_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_02_name_idx";


--
-- Name: Events_p2023_11_02_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_02_pkey";


--
-- Name: Events_p2023_11_03_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_03_createdAt_idx";


--
-- Name: Events_p2023_11_03_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_03_expr_idx";


--
-- Name: Events_p2023_11_03_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_03_expr_idx1";


--
-- Name: Events_p2023_11_03_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_03_name_idx";


--
-- Name: Events_p2023_11_03_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_03_pkey";


--
-- Name: Events_p2023_11_04_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_04_createdAt_idx";


--
-- Name: Events_p2023_11_04_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_04_expr_idx";


--
-- Name: Events_p2023_11_04_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_04_expr_idx1";


--
-- Name: Events_p2023_11_04_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_04_name_idx";


--
-- Name: Events_p2023_11_04_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_04_pkey";


--
-- Name: Events_p2023_11_05_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_05_createdAt_idx";


--
-- Name: Events_p2023_11_05_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_05_expr_idx";


--
-- Name: Events_p2023_11_05_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_05_expr_idx1";


--
-- Name: Events_p2023_11_05_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_05_name_idx";


--
-- Name: Events_p2023_11_05_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_05_pkey";


--
-- Name: Events_p2023_11_06_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_06_createdAt_idx";


--
-- Name: Events_p2023_11_06_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_06_expr_idx";


--
-- Name: Events_p2023_11_06_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_06_expr_idx1";


--
-- Name: Events_p2023_11_06_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_06_name_idx";


--
-- Name: Events_p2023_11_06_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_06_pkey";


--
-- Name: Events_p2023_11_07_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_07_createdAt_idx";


--
-- Name: Events_p2023_11_07_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_07_expr_idx";


--
-- Name: Events_p2023_11_07_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_07_expr_idx1";


--
-- Name: Events_p2023_11_07_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_07_name_idx";


--
-- Name: Events_p2023_11_07_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_07_pkey";


--
-- Name: Events_p2023_11_08_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_08_createdAt_idx";


--
-- Name: Events_p2023_11_08_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_08_expr_idx";


--
-- Name: Events_p2023_11_08_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_08_expr_idx1";


--
-- Name: Events_p2023_11_08_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_08_name_idx";


--
-- Name: Events_p2023_11_08_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_08_pkey";


--
-- Name: Events_p2023_11_09_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_09_createdAt_idx";


--
-- Name: Events_p2023_11_09_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_09_expr_idx";


--
-- Name: Events_p2023_11_09_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_09_expr_idx1";


--
-- Name: Events_p2023_11_09_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_09_name_idx";


--
-- Name: Events_p2023_11_09_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_09_pkey";


--
-- Name: Events_p2023_11_10_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_10_createdAt_idx";


--
-- Name: Events_p2023_11_10_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_10_expr_idx";


--
-- Name: Events_p2023_11_10_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_10_expr_idx1";


--
-- Name: Events_p2023_11_10_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_10_name_idx";


--
-- Name: Events_p2023_11_10_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_10_pkey";


--
-- Name: Events_p2023_11_11_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_11_createdAt_idx";


--
-- Name: Events_p2023_11_11_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_11_expr_idx";


--
-- Name: Events_p2023_11_11_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_11_expr_idx1";


--
-- Name: Events_p2023_11_11_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_11_name_idx";


--
-- Name: Events_p2023_11_11_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_11_pkey";


--
-- Name: Events_p2023_11_12_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_12_createdAt_idx";


--
-- Name: Events_p2023_11_12_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_12_expr_idx";


--
-- Name: Events_p2023_11_12_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_12_expr_idx1";


--
-- Name: Events_p2023_11_12_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_12_name_idx";


--
-- Name: Events_p2023_11_12_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_12_pkey";


--
-- Name: Events_p2023_11_13_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_13_createdAt_idx";


--
-- Name: Events_p2023_11_13_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_13_expr_idx";


--
-- Name: Events_p2023_11_13_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_13_expr_idx1";


--
-- Name: Events_p2023_11_13_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_13_name_idx";


--
-- Name: Events_p2023_11_13_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_13_pkey";


--
-- Name: Events_p2023_11_14_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_14_createdAt_idx";


--
-- Name: Events_p2023_11_14_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_14_expr_idx";


--
-- Name: Events_p2023_11_14_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_14_expr_idx1";


--
-- Name: Events_p2023_11_14_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_14_name_idx";


--
-- Name: Events_p2023_11_14_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_14_pkey";


--
-- Name: Events_p2023_11_15_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_15_createdAt_idx";


--
-- Name: Events_p2023_11_15_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_15_expr_idx";


--
-- Name: Events_p2023_11_15_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_15_expr_idx1";


--
-- Name: Events_p2023_11_15_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_15_name_idx";


--
-- Name: Events_p2023_11_15_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_15_pkey";


--
-- Name: Events_p2023_11_16_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_16_createdAt_idx";


--
-- Name: Events_p2023_11_16_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_16_expr_idx";


--
-- Name: Events_p2023_11_16_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_16_expr_idx1";


--
-- Name: Events_p2023_11_16_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_16_name_idx";


--
-- Name: Events_p2023_11_16_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_16_pkey";


--
-- Name: Events_p2023_11_17_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_17_createdAt_idx";


--
-- Name: Events_p2023_11_17_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_17_expr_idx";


--
-- Name: Events_p2023_11_17_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_17_expr_idx1";


--
-- Name: Events_p2023_11_17_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_17_name_idx";


--
-- Name: Events_p2023_11_17_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_17_pkey";


--
-- Name: Events_p2023_11_18_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_18_createdAt_idx";


--
-- Name: Events_p2023_11_18_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_18_expr_idx";


--
-- Name: Events_p2023_11_18_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_18_expr_idx1";


--
-- Name: Events_p2023_11_18_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_18_name_idx";


--
-- Name: Events_p2023_11_18_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_18_pkey";


--
-- Name: Events_p2023_11_19_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_19_createdAt_idx";


--
-- Name: Events_p2023_11_19_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_19_expr_idx";


--
-- Name: Events_p2023_11_19_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_19_expr_idx1";


--
-- Name: Events_p2023_11_19_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_19_name_idx";


--
-- Name: Events_p2023_11_19_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_19_pkey";


--
-- Name: Events_p2023_11_20_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_20_createdAt_idx";


--
-- Name: Events_p2023_11_20_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_20_expr_idx";


--
-- Name: Events_p2023_11_20_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_20_expr_idx1";


--
-- Name: Events_p2023_11_20_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_20_name_idx";


--
-- Name: Events_p2023_11_20_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_20_pkey";


--
-- Name: Events_p2023_11_21_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_21_createdAt_idx";


--
-- Name: Events_p2023_11_21_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_21_expr_idx";


--
-- Name: Events_p2023_11_21_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_21_expr_idx1";


--
-- Name: Events_p2023_11_21_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_21_name_idx";


--
-- Name: Events_p2023_11_21_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_21_pkey";


--
-- Name: Events_p2023_11_22_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_22_createdAt_idx";


--
-- Name: Events_p2023_11_22_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_22_expr_idx";


--
-- Name: Events_p2023_11_22_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_22_expr_idx1";


--
-- Name: Events_p2023_11_22_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_22_name_idx";


--
-- Name: Events_p2023_11_22_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_22_pkey";


--
-- Name: Events_p2023_11_23_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_23_createdAt_idx";


--
-- Name: Events_p2023_11_23_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_23_expr_idx";


--
-- Name: Events_p2023_11_23_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_23_expr_idx1";


--
-- Name: Events_p2023_11_23_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_23_name_idx";


--
-- Name: Events_p2023_11_23_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_23_pkey";


--
-- Name: Events_p2023_11_24_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_24_createdAt_idx";


--
-- Name: Events_p2023_11_24_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_24_expr_idx";


--
-- Name: Events_p2023_11_24_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_24_expr_idx1";


--
-- Name: Events_p2023_11_24_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_24_name_idx";


--
-- Name: Events_p2023_11_24_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_24_pkey";


--
-- Name: Events_p2023_11_25_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_25_createdAt_idx";


--
-- Name: Events_p2023_11_25_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_25_expr_idx";


--
-- Name: Events_p2023_11_25_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_25_expr_idx1";


--
-- Name: Events_p2023_11_25_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_25_name_idx";


--
-- Name: Events_p2023_11_25_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_25_pkey";


--
-- Name: Events_p2023_11_26_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_26_createdAt_idx";


--
-- Name: Events_p2023_11_26_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_26_expr_idx";


--
-- Name: Events_p2023_11_26_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_26_expr_idx1";


--
-- Name: Events_p2023_11_26_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_26_name_idx";


--
-- Name: Events_p2023_11_26_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_26_pkey";


--
-- Name: Events_p2023_11_27_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_27_createdAt_idx";


--
-- Name: Events_p2023_11_27_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_27_expr_idx";


--
-- Name: Events_p2023_11_27_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_27_expr_idx1";


--
-- Name: Events_p2023_11_27_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_27_name_idx";


--
-- Name: Events_p2023_11_27_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_27_pkey";


--
-- Name: Events_p2023_11_28_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_28_createdAt_idx";


--
-- Name: Events_p2023_11_28_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_28_expr_idx";


--
-- Name: Events_p2023_11_28_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_28_expr_idx1";


--
-- Name: Events_p2023_11_28_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_28_name_idx";


--
-- Name: Events_p2023_11_28_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_28_pkey";


--
-- Name: Events_p2023_11_29_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_29_createdAt_idx";


--
-- Name: Events_p2023_11_29_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_29_expr_idx";


--
-- Name: Events_p2023_11_29_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_29_expr_idx1";


--
-- Name: Events_p2023_11_29_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_29_name_idx";


--
-- Name: Events_p2023_11_29_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_29_pkey";


--
-- Name: Events_p2023_11_30_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_11_30_createdAt_idx";


--
-- Name: Events_p2023_11_30_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_11_30_expr_idx";


--
-- Name: Events_p2023_11_30_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_11_30_expr_idx1";


--
-- Name: Events_p2023_11_30_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_11_30_name_idx";


--
-- Name: Events_p2023_11_30_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_11_30_pkey";


--
-- Name: Events_p2023_12_01_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_01_createdAt_idx";


--
-- Name: Events_p2023_12_01_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_01_expr_idx";


--
-- Name: Events_p2023_12_01_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_01_expr_idx1";


--
-- Name: Events_p2023_12_01_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_01_name_idx";


--
-- Name: Events_p2023_12_01_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_01_pkey";


--
-- Name: Events_p2023_12_02_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_02_createdAt_idx";


--
-- Name: Events_p2023_12_02_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_02_expr_idx";


--
-- Name: Events_p2023_12_02_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_02_expr_idx1";


--
-- Name: Events_p2023_12_02_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_02_name_idx";


--
-- Name: Events_p2023_12_02_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_02_pkey";


--
-- Name: Events_p2023_12_03_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_03_createdAt_idx";


--
-- Name: Events_p2023_12_03_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_03_expr_idx";


--
-- Name: Events_p2023_12_03_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_03_expr_idx1";


--
-- Name: Events_p2023_12_03_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_03_name_idx";


--
-- Name: Events_p2023_12_03_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_03_pkey";


--
-- Name: Events_p2023_12_04_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_04_createdAt_idx";


--
-- Name: Events_p2023_12_04_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_04_expr_idx";


--
-- Name: Events_p2023_12_04_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_04_expr_idx1";


--
-- Name: Events_p2023_12_04_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_04_name_idx";


--
-- Name: Events_p2023_12_04_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_04_pkey";


--
-- Name: Events_p2023_12_05_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_05_createdAt_idx";


--
-- Name: Events_p2023_12_05_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_05_expr_idx";


--
-- Name: Events_p2023_12_05_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_05_expr_idx1";


--
-- Name: Events_p2023_12_05_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_05_name_idx";


--
-- Name: Events_p2023_12_05_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_05_pkey";


--
-- Name: Events_p2023_12_06_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_06_createdAt_idx";


--
-- Name: Events_p2023_12_06_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_06_expr_idx";


--
-- Name: Events_p2023_12_06_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_06_expr_idx1";


--
-- Name: Events_p2023_12_06_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_06_name_idx";


--
-- Name: Events_p2023_12_06_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_06_pkey";


--
-- Name: Events_p2023_12_07_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_07_createdAt_idx";


--
-- Name: Events_p2023_12_07_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_07_expr_idx";


--
-- Name: Events_p2023_12_07_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_07_expr_idx1";


--
-- Name: Events_p2023_12_07_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_07_name_idx";


--
-- Name: Events_p2023_12_07_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_07_pkey";


--
-- Name: Events_p2023_12_08_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_08_createdAt_idx";


--
-- Name: Events_p2023_12_08_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_08_expr_idx";


--
-- Name: Events_p2023_12_08_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_08_expr_idx1";


--
-- Name: Events_p2023_12_08_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_08_name_idx";


--
-- Name: Events_p2023_12_08_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_08_pkey";


--
-- Name: Events_p2023_12_09_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_09_createdAt_idx";


--
-- Name: Events_p2023_12_09_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_09_expr_idx";


--
-- Name: Events_p2023_12_09_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_09_expr_idx1";


--
-- Name: Events_p2023_12_09_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_09_name_idx";


--
-- Name: Events_p2023_12_09_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_09_pkey";


--
-- Name: Events_p2023_12_10_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_10_createdAt_idx";


--
-- Name: Events_p2023_12_10_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_10_expr_idx";


--
-- Name: Events_p2023_12_10_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_10_expr_idx1";


--
-- Name: Events_p2023_12_10_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_10_name_idx";


--
-- Name: Events_p2023_12_10_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_10_pkey";


--
-- Name: Events_p2023_12_11_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_11_createdAt_idx";


--
-- Name: Events_p2023_12_11_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_11_expr_idx";


--
-- Name: Events_p2023_12_11_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_11_expr_idx1";


--
-- Name: Events_p2023_12_11_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_11_name_idx";


--
-- Name: Events_p2023_12_11_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_11_pkey";


--
-- Name: Events_p2023_12_12_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_12_createdAt_idx";


--
-- Name: Events_p2023_12_12_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_12_expr_idx";


--
-- Name: Events_p2023_12_12_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_12_expr_idx1";


--
-- Name: Events_p2023_12_12_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_12_name_idx";


--
-- Name: Events_p2023_12_12_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_12_pkey";


--
-- Name: Events_p2023_12_13_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_13_createdAt_idx";


--
-- Name: Events_p2023_12_13_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_13_expr_idx";


--
-- Name: Events_p2023_12_13_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_13_expr_idx1";


--
-- Name: Events_p2023_12_13_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_13_name_idx";


--
-- Name: Events_p2023_12_13_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_13_pkey";


--
-- Name: Events_p2023_12_14_createdAt_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_created_at ATTACH PARTITION public."Events_p2023_12_14_createdAt_idx";


--
-- Name: Events_p2023_12_14_expr_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_object_id ATTACH PARTITION public."Events_p2023_12_14_expr_idx";


--
-- Name: Events_p2023_12_14_expr_idx1; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_body_external_image_id ATTACH PARTITION public."Events_p2023_12_14_expr_idx1";


--
-- Name: Events_p2023_12_14_name_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.event_name ATTACH PARTITION public."Events_p2023_12_14_name_idx";


--
-- Name: Events_p2023_12_14_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.pk_data_mart_event ATTACH PARTITION public."Events_p2023_12_14_pkey";


--
-- Name: Labels updated_at; Type: TRIGGER; Schema: analyses; Owner: postgres
--

CREATE TRIGGER updated_at BEFORE UPDATE ON analyses."Labels" FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: EntityAliases trigger_update_practice_type_entityaliases; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_practice_type_entityaliases AFTER INSERT ON public."EntityAliases" FOR EACH ROW EXECUTE FUNCTION public.update_practice_configuration();


--
-- Name: Practices trigger_update_practice_type_practices; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_practice_type_practices AFTER INSERT ON public."Practices" FOR EACH ROW EXECUTE FUNCTION public.update_practice_configuration();


--
-- Name: ProductKeys trigger_update_practice_type_productkeys; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_practice_type_productkeys AFTER INSERT ON public."ProductKeys" FOR EACH ROW EXECUTE FUNCTION public.update_practice_configuration();


--
-- Name: ProvisionedEntities trigger_update_practice_type_provisionedentities; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_practice_type_provisionedentities AFTER INSERT ON public."ProvisionedEntities" FOR EACH ROW EXECUTE FUNCTION public.update_practice_configuration();


--
-- Name: CdtCodesToAnalysesLabels updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updated_at BEFORE UPDATE ON public."CdtCodesToAnalysesLabels" FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


