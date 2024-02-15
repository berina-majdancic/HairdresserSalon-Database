# Hairdresser Salon MySQL Database
MySQL hairdresser salon database captures and manages essential information for a salon, including client details, appointment scheduling, stylist information, and inventory tracking

MySQL ER Diagram:

![ER](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/255cca6b-de74-497d-851e-c7b61501b06a)

Testing:

1. Display all appointments for today's date.

SELECT * FROM termin WHERE DATE(datum_vrijeme) = DATE(NOW());

![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/490c4065-59d9-4ea3-84a0-33e5155d365a)


2. Display all clients with the name Ema.

SELECT * FROM klijent WHERE Ime = 'Ema';

 ![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/4ab90a57-95a2-4994-814a-68e20383dccb)


3. Display all products from the 'products' table that belong to the Syoss brand.

SELECT * FROM proizvod WHERE brend = 'Syoss'; 

 
![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/ede49c62-e70a-487a-a70e-6c667eb798be)


4. Display all services with a price less than 60 KM.

SELECT * FROM usluga WHERE cijena < 60;
 
![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/03f9f43d-62ae-4f85-96b5-006b81636887)


5. Display all employees who have received/given notice.

SELECT * FROM zaposlenik WHERE radi_do IS NOT NULL;

![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/509163e1-922b-4e35-a430-26fd76b04613)



6. Display the names, surnames, and phone numbers of all clients who had scheduled appointments in the last week.
   
SELECT k.ime, k.prezime, k.br_tel 
FROM klijent k  
JOIN termin t ON k.id_Klijent = t.Klijent_id_Klijent 
WHERE t.datum_vrijeme > DATE_SUB(NOW(), INTERVAL 1 WEEK) 

![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/cca8e52c-ae7c-47bb-b455-400a2969d284)


7. Display the full names of employees who have invoiced products purchased in the past month.

SELECT DISTINCT z.Ime, z.prezime
FROM zaposlenik z
JOIN racun r ON z.id_zaposlenik = r.Zaposlenik_id_zaposlenik
JOIN proizvod_has_racun phr ON r.id_Racun = phr.Racun_id_Racun
JOIN proizvod p ON phr.proizvod_id_Proizvod = p.id_Proizvod
WHERE r.datum_racun > DATE_SUB(NOW(), INTERVAL 1 MONTH)

![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/576f24d0-0699-4179-a37d-c508102e5650)


8. Display the product name and the quantity sold for all products sold in the last 6 months.

SELECT p.naziv, SUM(phr.kolicina) AS broj_prodatih_komada
FROM proizvod p 
JOIN proizvod_has_racun phr ON p.id_Proizvod = phr.proizvod_id_Proizvod 
JOIN racun r ON phr.Racun_id_Racun = r.id_Racun 
WHERE r.datum_racun > DATE_SUB(NOW(), INTERVAL 6 MONTH) 
GROUP BY p.id_Proizvod

 ![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/6150c7cb-7feb-4981-9cd5-cef87c98ec4b)


9. Display the names, surnames, and phone numbers of all clients who have scheduled appointments with a specific employee.

SELECT k.Ime, k.prezime, k.br_tel
FROM klijent k 
JOIN termin t ON k.id_Klijent = t.Klijent_id_Klijent
JOIN zaposlenik z ON t.Zaposlenik_id_zaposlenik = z.id_zaposlenik
WHERE z.Ime = 'Adem' AND z.prezime = 'Mehic'

![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/911c9057-dd30-4bc9-b782-46960e97bf0f)


10. Display the full name of the employee who issued the highest invoice for appointments this month and print the invoice amount.

SELECT z.Ime, z.prezime, SUM(u.cijena) AS ukupna_cijena_racuna
FROM zaposlenik z
JOIN termin t 
JOIN usluga_has_termin tu ON t.id_Termin = tu.Termin_id_Termin
JOIN usluga u ON tu.Usluga_id_Usluga = u.id_Usluga
JOIN racun r ON t.Racun_id_Racun = r.id_Racun AND  z.id_zaposlenik = r.Zaposlenik_id_zaposlenik
WHERE MONTH(t.datum_vrijeme) = MONTH(NOW()) AND YEAR(t.datum_vrijeme) = YEAR(NOW())
GROUP BY r.id_Racun
ORDER BY ukupna_cijena_racuna DESC
LIMIT 1	
 
![image](https://github.com/berina-majdancic/HairdresserSalon-Database/assets/106923174/2fb0cd42-cdba-4ec6-a52f-ca781576f65e)


