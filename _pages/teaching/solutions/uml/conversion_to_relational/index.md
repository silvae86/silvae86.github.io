---
layout: page
title: Solutions for UML Class to Relational
permalink: /teaching/solutions/uml/conversion_to_relational/
crumbtitle: Solutions for UML Class to Relational exercises
---

## Veterinary Clinic

**Animals**(<u>id</u>, name, breed &rarr;Breed, owner&rarr;Owner) 

​	{breed} NOT NULL

**Breeds**(<u>name</u>)

**Conditions**(<u>name</u>)

**Appointments**(<u>id</u>, date, time, animal &rarr;Animal, physician&rarr;Physician)

NOT NULL(animal)

NOT NULL(physician)

NOT NULL(date)

NOT NULL(time)

**ConditionsIdentified**(<u>condition</u> &rarr; Condition, <u>appointment</u> &rarr; Appointment)

**FrequentConditions**(<u>breed</u>&rarr;Breed, <u>condition</u> &rarr; Condition)

**Owners**(<u>id</u>, name, person, address, phone_no)

**Physicians**(<u>id</u>, name, person, address, phone_no)

## Auto Repair Shop



**Persons**(<u>id</u>, name, address)

**Employees**(<u>id</u>&rarr;Person)

**Owners**(<u>id</u>&rarr;Person)

**Services**(<u>id</u>, car_km, hours_spent, adm_date, finish_date, employee &rarr; Employee, car &rarr;Car)

CHECK(finish_date >= adm_date)

CHECK(hours_spent >=1)

NOT NULL(employee)

NOT NULL(car)

**Cars**(<u>plate</u>, color)

**Models**(<u>id</u>, description, make &rarr;Make) 

NOT NULL (make)

`Comment: There are multiple generations of 'Toyota Corolla', which can have the same name but are effectively different models` 

**Makes**(<u>name</u>)

**Parts**(<u>id</u>, serial_no, service &rarr;Service) 

NOT NULL(service)

NOT NULL (serial_no)

`Comment: even if the serial number is unique within a given part type, there can be collisions between serial numbers of different part types`

**PartTypes**(<u>id</u>, current_price)

**Compatibilities**(<u>car_model</u>&rarr;Model, <u>part_type</u>&rarr;PartType)

## Restaurant

**Persons**(<u>id</u>, name, address)



**Waiters**(<u>id</u>&rarr;Person, identifier, phone_number)

`Comment: Why 2 Ids? Identifier is what will show up on a waiter's badge (has a meaning), while the id is the internal identifier of the record, i.e. a surrogate (i.e. generated, and without meaning) key`

**Clients**(<u>id</u>&rarr;Person, tax_id)

**Meals**(id, served_to &rarr;Client, served_by &rarr; Waiter, date, start_time, end_time, table &rarr; Table)

CHECK(start_time < end_time OR end_time IS NULL) 

`Comment: if end_time is null, the meal is still going on, but we should be able to insert the record anyway, and then update it when the meal is finished.`

NOT NULL(served_to)

NOT NULL (served_by)

NOT NULL (date)

NOT NULL (start_time)



**Dishes**(<u>identifier</u>, name)

CHECK(name IS NOT NULL)

CHECK(

​	(

​	SELECT COUNT(*) 

​	FROM QuantitiesNeededForDishes 

​	JOIN Dishes ON Dishes.identifier = QuantitiesNeededForDishes.dish 	

​	WHERE Dishes.identifier = NEW.identifier

​	) >= 1 

)

`Comment: To enforce the 1..* constraint at the database )at least one ingredient in every dish), logic must be added to both the Dish and QuantitiesNeededForDish relations, so that no dish can be left without ingredients both upon creation of the dish and also upon modification of a dish's ingredients. We will see this later, as it is the most complicated part of this example; the constraint is left here as an example.`

**Ingredients**(<u>name</u>, meas_unit, qtt_stock)

CHECK(meas_unit IS NOT NULL)

CHECK(qtt_stock >=0)



**QuantitiesNeededForDishes**(<u>dish</u>&rarr;Dish, <u>ingredient</u> &rarr;Ingredient, qtt_needed)

CHECK(qtt_needed > 0)



**TimesServed**(<u>dish</u>&rarr;Dish, <u>meal</u> &rarr;Meal, times_served)

CHECK(times_served > 0)



**Table**(<u>identifier</u>, capacity)

CHECK(capacity > 0)

## Deliveries



**Couriers**(<u>id</u>, name, vat_no, name, phone_num)

**Customers**(<u>id</u>, vat_no ,name, phone_num, address, closest_delivery_center &rarr; DeliveryCenter)

`Comment: a complete and disjoint generalization means that we can omit the Person relation.`

**Packages**(<u>identifier</u>, weight, urgency, dropoff_point &rarr;DeliveryCenter, sender &rarr;Customer, recipient &rarr;Customer, courier &rarr;Courier)

CHECK(urgency = "normal" OR urgency ="urgent")

CHECK(weight > 0)

NOT NULL(dropoff_point)

**DeliveryCenter**(<u>id</u>, name, address)

InternalTracking(<u>package</u>&rarr;Package, <u>delivery_center</u>&rarr;DeliveryCenter, date_time_of_arrival, date_time_of_departure)

CHECK(date_time_of_arrival >= date_time_of_departure)

## Furniture Factory



WIP

## Factory



WIP

## Bicycles

WIP