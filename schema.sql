--
-- PostgreSQL database dump
--


-- Dumped from database version 16.14 (Debian 16.14-1.pgdg13+1)
-- Dumped by pg_dump version 16.14 (Debian 16.14-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ai_leads; Type: TABLE; Schema: public; Owner: crmadmin
--

CREATE TABLE public.ai_leads (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    name text,
    email text,
    company_name text,
    industry text,
    company_size text,
    monthly_revenue text,
    automation_request text,
    timeline text,
    lead_score integer,
    lead_status text,
    reason text,
    priority text,
    recommended_action text
);


ALTER TABLE public.ai_leads OWNER TO crmadmin;

--
-- Name: ai_leads_id_seq; Type: SEQUENCE; Schema: public; Owner: crmadmin
--

CREATE SEQUENCE public.ai_leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ai_leads_id_seq OWNER TO crmadmin;

--
-- Name: ai_leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crmadmin
--

ALTER SEQUENCE public.ai_leads_id_seq OWNED BY public.ai_leads.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: crmadmin
--

CREATE TABLE public.leads (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    company character varying(255),
    budget integer,
    status character varying(50),
    pipeline character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.leads OWNER TO crmadmin;

--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: crmadmin
--

CREATE SEQUENCE public.leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leads_id_seq OWNER TO crmadmin;

--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crmadmin
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: ai_leads id; Type: DEFAULT; Schema: public; Owner: crmadmin
--

ALTER TABLE ONLY public.ai_leads ALTER COLUMN id SET DEFAULT nextval('public.ai_leads_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: crmadmin
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: ai_leads ai_leads_pkey; Type: CONSTRAINT; Schema: public; Owner: crmadmin
--

ALTER TABLE ONLY public.ai_leads
    ADD CONSTRAINT ai_leads_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: crmadmin
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


