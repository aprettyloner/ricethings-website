--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg19.04+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg19.04+1)

-- Started on 2020-03-23 17:28:28 PDT

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

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 32883)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    name character varying NOT NULL,
    category character varying NOT NULL,
    price double precision NOT NULL,
    description character varying,
    image character varying
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- TOC entry 2928 (class 0 OID 32883)
-- Dependencies: 196
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (name, category, price, description, image) FROM stdin;
California Roll	Sushi Roll	5.17999999999999972	Crab Mix, Mayo, Cucumber, Avocado	https://cdn.doordash.com/media/photos/e820e6e1-3366-4aa4-8e0c-62926185fa1e-retina-large-jpeg
Calamari Salad	Salads	8.63000000000000078	\N	images/Salads.jpg
Salmon Skin Salad	Salads	8.63000000000000078	\N	images/Salads.jpg
Spicy California Roll	Sushi Roll	5.17999999999999972	Crab Mix, Mayo, Cucumber, Avocado, Spicy Sauce Blend	images/SushiRoll.jpg
Vegetable Roll	Sushi Roll	5.17999999999999972	Cucumber, Avocado, Kaiware Sprouts, Pickled Yamagobo	images/SushiRoll.jpg
Cucumber Roll	Sushi Roll	5.17999999999999972	Cucumber	images/SushiRoll.jpg
Avocado Roll	Sushi Roll	5.17999999999999972	Avocado	images/SushiRoll.jpg
Inari Roll (3pc)	Sushi Roll	5.17999999999999972	Fried Tofu Skin, Sweet Soy Flavored, Sushi Rice	images/SushiRoll.jpg
Tuna Roll	Sushi Roll	6.90000000000000036	Freshwater Tuna, Cucumber	images/SushiRoll.jpg
Spicy Tuna Roll	Sushi Roll	6.90000000000000036	Freshwater Tuna, Cucumber, Spicy Sauce Blend	images/SushiRoll.jpg
Salmon Roll	Sushi Roll	6.90000000000000036	Freshwater Salmon, Cucumber	images/SushiRoll.jpg
Salmon Avocado Roll	Sushi Roll	6.90000000000000036	Freshwater Salmon, Avocado	images/SushiRoll.jpg
Philly Roll	Sushi Roll	6.90000000000000036	Freshwater Salmon, Cucumber, Cream Cheese	images/SushiRoll.jpg
Crunchy Roll (5pc)	Sushi Roll	6.90000000000000036	Shrimp Tempura, Cucumber, Avocado, Kaiware Sprouts, Spicy Mayo	images/SushiRoll.jpg
Veggie Crunchy Roll (5pc)	Sushi Roll	6.90000000000000036	Vegetable Tempura, Cucumber, Avocado, Kaiware Sprouts, Spicy Mayo	images/SushiRoll.jpg
Eel Roll	Sushi Roll	8.05000000000000071	Freshwater Eel, Cucumber, Eel Sauce	images/SushiRoll.jpg
Spicy Eel Roll	Sushi Roll	8.05000000000000071	Freshwater Eel, Cucumber, Eel Sauce, Spicy Sauce Blend	images/SushiRoll.jpg
Eel Avocado Roll	Sushi Roll	8.05000000000000071	Freshwater Eel, Eel Sauce, Avocado	images/SushiRoll.jpg
Salmon Crunchy Roll	Premium Sushi	10.3499999999999996	Salmon Tempura, Cucumber, Avocado, Kaiware Sprouts, Spicy Mayo	images/PremiumSushi.jpg
Salmon Skin Roll (5pc)	Premium Sushi	10.3499999999999996	Salmon Skin, Cucumber, Avocado, Kaiware Sprouts, Yamagoboo	images/PremiumSushi.jpg
California Tempura Roll	Premium Sushi	10.3499999999999996	California Roll, deep fried with Tempura Batter	images/PremiumSushi.jpg
Super California Roll	Premium Sushi	10.3499999999999996	Snow Crab meat, Mayo, Cucumber, Avocado	images/PremiumSushi.jpg
Eel Tempura Roll	Premium Sushi	10.3499999999999996	Eel Avocado Roll, Deep fried with Tempura Batter	images/PremiumSushi.jpg
Alaskan Roll	Premium Sushi	10.3499999999999996	Slices of Freshwater Salmon and Avocado over California roll	images/PremiumSushi.jpg
Hawaiian Roll	Premium Sushi	10.3499999999999996	Slices of Freshwater Tuna and Avocado over Spicy Tuna Roll	images/PremiumSushi.jpg
Caterpillar Roll	Premium Sushi	10.3499999999999996	Slices of Avocado over Eel Roll	images/PremiumSushi.jpg
Tuna Bowl	Fresh Sushi Bowl	12.6500000000000004	\N	images/FreshSushiBowl.jpg
Spicy Tuna Bowl	Fresh Sushi Bowl	12.6500000000000004	\N	images/FreshSushiBowl.jpg
Salmon Bowl	Fresh Sushi Bowl	12.6500000000000004	\N	images/FreshSushiBowl.jpg
Chirashi Bowl	Fresh Sushi Bowl	18.3999999999999986	Mixed sashimi.	images/FreshSushiBowl.jpg
Combo Plate (1 Item)	Combo Plate	6.90000000000000036	1 item combination plate	images/ComboPlate.jpg
Combo Plate (2 Items)	Combo Plate	9.77999999999999936	2 item combination plate	images/ComboPlate.jpg
Combo Plate (3 Items)	Combo Plate	12.0800000000000001	3 item combination plate	images/ComboPlate.jpg
Tonkotsu Ramen	Ramen Noodle	12.6500000000000004	Thin noodle, light tonkotsu based soup, served with chashu pork, hard boiled egg, green onion, sliced red pepper, garlic oil.	images/RamenNoodle.jpg
Miso Ramen	Ramen Noodle	12.6500000000000004	Thin noodle, miso based soup, served with chashu pork, hard boiled egg, crispy onion chips, bamboo shoots, corn, green onion, bean sprouts.	images/RamenNoodle.jpg
Plain Udon	Udon Noodle	9.77999999999999936	\N	images/UdonNoodle.jpg
Vegetable Udon	Udon Noodle	9.77999999999999936	\N	images/UdonNoodle.jpg
Chicken Udon	Udon Noodle	9.77999999999999936	\N	images/UdonNoodle.jpg
Beef Udon	Udon Noodle	10.9299999999999997	\N	images/UdonNoodle.jpg
Tempura Udon	Udon Noodle	10.9299999999999997	\N	images/UdonNoodle.jpg
Poke Bowl	Poke Bowl	11.5	Fresh sashimi grade fish (or tofu) on top of your choice of base. Served with miso soup.	images/PokeBowl.jpg
Curry Plate	Curry Plate	9.19999999999999929	Japanese style curry rice plate served with our original vegetable based savory curry sauce.	images/CurryPlate.jpg
Edamame	Side Orders	4.03000000000000025	\N	images/SideOrders.jpg
Miso Soup	Side Orders	2.29999999999999982	\N	https://cdn.doordash.com/media/photos/e57e3e17-6dcc-476b-8ed7-cd78cfbc6016-retina-large-jpeg
White Rice	Side Orders	2.29999999999999982	\N	https://cdn.doordash.com/media/photos/0058afb6-38e8-4dd2-a39a-87d12325d3ba-retina-large-jpeg
Brown Rice	Side Orders	3.45000000000000018	\N	images/SideOrders.jpg
Chicken Teriyaki	Side Orders	5.17999999999999972	Dark meat chicken teriyaki	images/SideOrders.jpg
Chicken Breast Teriyaki	Side Orders	6.33000000000000007	White meat chicken breast teriyaki	images/SideOrders.jpg
Karaage Chicken	Side Orders	5.17999999999999972	\N	images/SideOrders.jpg
Sesame Chicken	Side Orders	5.17999999999999972	\N	images/SideOrders.jpg
Chicken Katsu	Side Orders	5.17999999999999972	Dark meat chicken katsu	images/SideOrders.jpg
Chicken Breast Katsu	Side Orders	6.33000000000000007	White meat chicken breast katsu	images/SideOrders.jpg
Beef Teriyaki	Side Orders	6.33000000000000007	\N	images/SideOrders.jpg
Gyoza (5pc)	Side Orders	4.03000000000000025	\N	images/SideOrders.jpg
Vege Egg Roll (3pc)	Side Orders	4.59999999999999964	\N	images/SideOrders.jpg
Vegetable Teriyaki	Side Orders	5.17999999999999972	\N	images/SideOrders.jpg
Vegetable Tempura (7pc)	Side Orders	5.17999999999999972	\N	images/SideOrders.jpg
Shrimp Tempura (3pc)	Side Orders	5.75	\N	images/SideOrders.jpg
Potato Mac Salad	Side Orders	2.87999999999999989	\N	images/SideOrders.jpg
Curry Sauce (8 oz)	Side Orders	3.16000000000000014	\N	images/SideOrders.jpg
Hawaiian Sun Drinks	Beverages	3.25	Hawaiian Sun Can Juices	images/Beverages.jpg
\.


-- Completed on 2020-03-23 17:28:28 PDT

--
-- PostgreSQL database dump complete
--

