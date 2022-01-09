--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 13.4

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
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: insert_random_records(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_random_records(recordcount integer)
    LANGUAGE plpgsql
    AS $$
declare
    client_id uuid;
begin
for r in 1..recordCount 
loop
	client_id := (
		select uuid_generate_v4()
	);
	
	insert into public.clients(id, name, dob) 
	values(
		client_id
		,
		(
			select lipsum(10)
		), 
		(
			select random_date()
		)
	);
	
	insert into public.orders(id, client_id, created) 
	values(
		uuid_generate_v4()
		,
		client_id, 
		(
			select random_date()
		)
	);
end loop;
end;
$$;


ALTER PROCEDURE public.insert_random_records(recordcount integer) OWNER TO postgres;

--
-- Name: lipsum(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.lipsum(quantity_ integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
  declare
    words_       text[];
    returnValue_ text := '';
    random_      integer;
    ind_         integer;
  begin
  words_ := array['lorem', 'ipsum', 'dolor', 'sit', 'amet', 'consectetur', 'adipiscing', 'elit', 'a', 'ac', 'accumsan', 'ad', 'aenean', 'aliquam', 'aliquet', 'ante', 'aptent', 'arcu', 'at', 'auctor', 'augue', 'bibendum', 'blandit', 'class', 'commodo', 'condimentum', 'congue', 'consequat', 'conubia', 'convallis', 'cras', 'cubilia', 'cum', 'curabitur', 'curae', 'cursus', 'dapibus', 'diam', 'dictum', 'dictumst', 'dignissim', 'dis', 'donec', 'dui', 'duis', 'egestas', 'eget', 'eleifend', 'elementum', 'enim', 'erat', 'eros', 'est', 'et', 'etiam', 'eu', 'euismod', 'facilisi', 'facilisis', 'fames', 'faucibus', 'felis', 'fermentum', 'feugiat', 'fringilla', 'fusce', 'gravida', 'habitant', 'habitasse', 'hac', 'hendrerit', 'himenaeos', 'iaculis', 'id', 'imperdiet', 'in', 'inceptos', 'integer', 'interdum', 'justo', 'lacinia', 'lacus', 'laoreet', 'lectus', 'leo', 'libero', 'ligula', 'litora', 'lobortis', 'luctus', 'maecenas', 'magna', 'magnis', 'malesuada', 'massa', 'mattis', 'mauris', 'metus', 'mi', 'molestie', 'mollis', 'montes', 'morbi', 'mus', 'nam', 'nascetur', 'natoque', 'nec', 'neque', 'netus', 'nibh', 'nisi', 'nisl', 'non', 'nostra', 'nulla', 'nullam', 'nunc', 'odio', 'orci', 'ornare', 'parturient', 'pellentesque', 'penatibus', 'per', 'pharetra', 'phasellus', 'placerat', 'platea', 'porta', 'porttitor', 'posuere', 'potenti', 'praesent', 'pretium', 'primis', 'proin', 'pulvinar', 'purus', 'quam', 'quis', 'quisque', 'rhoncus', 'ridiculus', 'risus', 'rutrum', 'sagittis', 'sapien', 'scelerisque', 'sed', 'sem', 'semper', 'senectus', 'sociis', 'sociosqu', 'sodales', 'sollicitudin', 'suscipit', 'suspendisse', 'taciti', 'tellus', 'tempor', 'tempus', 'tincidunt', 'torquent', 'tortor', 'tristique', 'turpis', 'ullamcorper', 'ultrices', 'ultricies', 'urna', 'ut', 'varius', 'vehicula', 'vel', 'velit', 'venenatis', 'vestibulum', 'vitae', 'vivamus', 'viverra', 'volutpat', 'vulputate'];
    for ind_ in 1 .. quantity_ loop
      ind_ := ( random() * ( array_upper( words_, 1 ) - 1 ) )::integer + 1;
      returnValue_ := returnValue_ || ' ' || words_[ind_];
    end loop;
    return returnValue_;
  end;
$$;


ALTER FUNCTION public.lipsum(quantity_ integer) OWNER TO postgres;

--
-- Name: random_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.random_date() RETURNS date
    LANGUAGE plpgsql
    AS $$
  declare
    generatedDate       date;
  begin
  	generatedDate := (
		select NOW() + (random() * (NOW()+'90 days' - NOW())) + '30 days'
	);
    return generatedDate;
  end;
$$;


ALTER FUNCTION public.random_date() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id uuid NOT NULL,
    name text,
    dob date
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    client_id uuid,
    created date
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: fki_orders_clientid_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_orders_clientid_client_id ON public.orders USING btree (client_id);


--
-- Name: orders orders_clientid_client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_clientid_client_id FOREIGN KEY (client_id) REFERENCES public.clients(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

