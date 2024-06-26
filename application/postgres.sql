--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10
-- Dumped by pg_dump version 14.10

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
-- Name: myschema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA myschema;


ALTER SCHEMA myschema OWNER TO postgres;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.extra (
    id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.extra OWNER TO postgres;

--
-- Name: extra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.extra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extra_id_seq OWNER TO postgres;

--
-- Name: extra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.extra_id_seq OWNED BY public.extra.id;


--
-- Name: main; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main (
    id integer NOT NULL,
    extra_id integer,
    name_phone character varying(50) NOT NULL,
    price integer NOT NULL,
    color character varying(30) NOT NULL,
    manufacturer character varying(50) NOT NULL
);


ALTER TABLE public.main OWNER TO postgres;

--
-- Name: main_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.main_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_id_seq OWNER TO postgres;

--
-- Name: main_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.main_id_seq OWNED BY public.main.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id integer NOT NULL,
    "user" integer NOT NULL,
    role integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_roles_id_seq OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(40) NOT NULL,
    login character varying(10) NOT NULL,
    pass character varying(65) NOT NULL,
    CONSTRAINT users_login_len CHECK ((length((login)::text) >= 3)),
    CONSTRAINT users_pass_len CHECK ((length((pass)::text) >= 5))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: extra id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extra ALTER COLUMN id SET DEFAULT nextval('public.extra_id_seq'::regclass);


--
-- Name: main id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main ALTER COLUMN id SET DEFAULT nextval('public.main_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: extra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.extra (id, name) FROM stdin;
1	╨Ъ╨╕╤В╨░╨╣
2	╨б╨и╨Р
3	╨п╨┐╨╛╨╜╨╕╤П
4	╨о╨╢╨╜╨░╤П ╨Ъ╨╛╤А╨╡╤П
5	╨а╨╛╤Б╤Б╨╕╤П
\.


--
-- Data for Name: main; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main (id, extra_id, name_phone, price, color, manufacturer) FROM stdin;
60	1	Xiaomi 9T	45000	╨з╨╡╤А╨╜╤Л╨╣	Xiaomi
45	2	iPhone12 mini	56990	╨а╨╛╨╖╨╛╨▓╤Л╨╣	Apple
43	2	iPhone15 Pro Max	205000	╨С╨╡╨╗╤Л╨╣	Apple
52	2	iPhone14 Pro	128900	╨з╨╡╤А╨╜╤Л╨╣	Apple
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, code, name) FROM stdin;
1	USR	╨Я╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М
2	ADM	╨Р╨┤╨╝╨╕╨╜╨╕╤Б╤В╤А╨░╤В╨╛╤А
3	MOD	╨Ь╨╛╨┤╨╡╤А╨░╤В╨╛╤А
4	STAT	╨б╤В╨░╤В╨╕╤Б╤В╨╕╨║
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, "user", role) FROM stdin;
1	1	1
2	2	1
3	2	3
4	3	3
5	3	4
6	4	2
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, login, pass) FROM stdin;
2	╨Я╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М2	user2	$2y$10$2fyKRn6kGnAqiVt17ITZbORbeqCyPZVwT6rXetFmfvEH3okjSSnbK
3	╨Я╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М3	user3	$2y$10$/6QdtAJEPc0IQJvxldLhGutRcs2blUVeRa68sYHg2lcgwiQZkqGFi
4	╨Р╨╜╨┤╤А╨╡╨╣	admin	$2y$10$7Iz9JPwgQiYd/DjvG/Xa8OVfgC8aLg8nZ4mSu4hhjQxB50pIbjkfK
1	╨Я╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М1	user1	$2y$10$VEZnQcZc5Y/eVvtRhhJXDu.8ZgQzMVB/EhfmDI0Ylq8AI.gXd.nNG
\.


--
-- Name: extra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.extra_id_seq', 5, true);


--
-- Name: main_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_id_seq', 62, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: extra extra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extra
    ADD CONSTRAINT extra_pkey PRIMARY KEY (id);


--
-- Name: main main_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main
    ADD CONSTRAINT main_pkey PRIMARY KEY (id);


--
-- Name: roles roles_code_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_code_uk UNIQUE (code);


--
-- Name: roles roles_name_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_uk UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_login_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_uk UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: main main_extra_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main
    ADD CONSTRAINT main_extra_id_fk FOREIGN KEY (extra_id) REFERENCES public.extra(id);


--
-- Name: user_roles user_roles_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_fk FOREIGN KEY (role) REFERENCES public.roles(id);


--
-- Name: user_roles user_roles_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_fk FOREIGN KEY ("user") REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

