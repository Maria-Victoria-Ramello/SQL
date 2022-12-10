CREATE TABLE public.colors (
	id_color serial primary key,
	color varchar (50) NOT NULL
);

CREATE TABLE public.currencies (
	id_currency serial primary key,
	currency varchar (10) NOT null,
    region varchar (50) NOT null
	);
	
CREATE TABLE public.insurance_companies (
	id_insurance_company serial primary key,
	insurance_company varchar (50) NOT null 
	);

CREATE TABLE public.companies (
	id_company serial primary key,
	company varchar (50) NOT null 
	);

CREATE TABLE public.brands (
	id_brand serial primary key,
	id_company int NOT null references public.companies(id_company),
	brand varchar (30) NOT null 
);

CREATE TABLE public.models (
	id_model serial primary key,
	id_brand int NOT null references public.brands(id_brand),
	model varchar (30) NOT null
	);


CREATE TABLE public.cars (
	id_car serial primary key,
	id_model int NOT null references public.models (id_model),
	id_color int NOT null references public.colors (id_color),
	date_of_purchase date  NOT null,
	license_plate int NOT null,
	km_total int NOT null
	);


CREATE TABLE public.inspections (
	id_inspection serial primary key,
	id_car int NOT null references public.cars (id_car),
	id_currency int NOT null references public.currencies (id_currency),
	km int NOT null,
	price money NOT null
	);

CREATE TABLE public.insurances (
	id_insurance serial primary key,
	id_car int NOT null references public.cars (id_car),
	id_insurance_company int NOT null references public.insurance_companies (id_insurance_company),
	insurance_number int NOT null
	);

INSERT INTO public.colors(color) values('Red'),('Blue'),('Yellow');
INSERT INTO public.currencies(currency,region) values('EUR','Europa'),('USD','USA'),('ARS','Argentina');
INSERT INTO public.insurance_companies(insurance_company) values('Lloyd’s Iberia'),('Zurich'),('Corte Ingles');
INSERT INTO public.companies(company) values('FCA'),('BMW Group'),('Daimler');
INSERT INTO public.brands(id_company, brand) values(1,'Mercedes-Benz'),(2,'Maserati'),(3,'Rolls Royce');
INSERT INTO public.models(id_brand, model) values(1,'AMG GT 4'),(2,'MC20'),(3,'Phantom IV');
INSERT INTO public.cars (id_model,id_color,date_of_purchase,license_plate,km_total) values(1,1,'2021-12-01',123,'52000'),(2,2,'2021-10-01',147,'12340'),(3,3,'2023-12-5',4562,'147500');
INSERT INTO public.inspections (id_car, id_currency,km,price) values(1,1,56265,50000),(2,2,65454,80000),(3,3,5465,500000);
INSERT INTO public.insurances (id_car, id_insurance_company,insurance_number) values(1,1,4502),(2,2,4568),(3,3,4865);


select company, brand, model, date_of_purchase, license_plate, color, km_total, insurance_company, insurance_number,  from public.cars c
left join public.models m on c.id_model  = m.id_model 
left join public.brands b on m.id_brand = b.id_brand 
left join public.companies c2 on b.id_company = c2.id_company 
left join public.colors c3 on c.id_color = c3.id_color 
left join public.insurances i on c.id_car = i.id_car 
left join public.insurance_companies ic on i.id_insurance_company = ic.id_insurance_company 