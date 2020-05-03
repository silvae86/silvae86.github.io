---
layout: page
title: Solutions for UML Class to Relational
permalink: /teaching/solutions/uml/conversion_to_relational/
crumbtitle: UML Class to Relational exercises
---

{% include info.html content="These are the solutions of the [UML Class to Relational exercises](/teaching/exercises/uml/conversion_to_relational) exercises. They should be used as the starting point for building SQL scripts for building each schema." %}

## Veterinary Clinic

**Animals**(<u>id</u>, name, breed &rarr;Breed, owner&rarr;Owner)

NOT NULL(breed)

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

NOT NULL(name)

**Physicians**(<u>id</u>, name, person, address, phone_no)

NOT NULL(name)

## Auto Repair Shop


**Persons**(<u>id</u>, name, address)

NOT NULL(name)

**Employees**(<u>id</u>&rarr;Person)

**Owners**(<u>id</u>&rarr;Person)

**Services**(<u>id</u>, car_km, hours_spent, adm_date, finish_date, employee &rarr; Employee, car &rarr;Car)

CHECK(strftime('%s', finish_date) >= strftime('%s', adm_date))

CHECK(hours_spent >=1)

NOT NULL(employee)

NOT NULL(car)

**Cars**(<u>plate</u>, color)

NOT NULL(car)

**Models**(<u>id</u>, description, make &rarr;Make)

NOT NULL (make)

`Comment: This considers that model names are not unique. For example, there are multiple generations of 'Toyota Corolla', which can have the same name but are effectively different models`. You could also consider the model names to be unique. In that case, the description could be the primary key. Any tables referencing this one would need to have their foreign keys updated as well.

**Makes**(<u>name</u>)

**Parts**(<u>id</u>, serial_no, service &rarr;Service)

NOT NULL(service)

NOT NULL (serial_no)

`Comment: even if the serial number is unique within a given part type, there can be collisions between serial numbers of different part types`

**PartTypes**(<u>id</u>, current_price)

NOT NULL(current_price)

CHECK(current_price > 0)

**Compatibilities**(<u>car_model</u>&rarr;Model, <u>part_type</u>&rarr;PartType)

## Restaurant

**Persons**(<u>id</u>, name, address)

NOT NULL(name)

**Waiters**(<u>id</u>&rarr;Person, identifier, phone_number)

`Comment: Why 2 Ids? Identifier is what will show up on a waiter's badge (has a meaning), while the id is the internal identifier of the record, i.e. a surrogate (i.e. generated, and without meaning) key`

NOT NULL(identifier)

NOT NULL(phone_number)

UNIQUE(identifier)


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

CHECK(qtt_stock >= 0)



**QuantitiesNeededForDishes**(<u>dish</u>&rarr;Dish, <u>ingredient</u> &rarr;Ingredient, qtt_needed)

CHECK(qtt_needed > 0)



**TimesServed**(<u>dish</u>&rarr;Dish, <u>meal</u> &rarr;Meal, times_served)

CHECK(times_served > 0)



**Table**(<u>identifier</u>, capacity)

CHECK(capacity > 0)

## Deliveries



**Couriers**(<u>id</u>, name, vat_no, phone_num)

**Customers**(<u>id</u>, vat_no,name, phone_num, address, closest_delivery_center &rarr; DeliveryCenter)

`Comment: a complete and disjoint generalization means that we can omit the Person relation.`

**Packages**(<u>identifier</u>, weight, urgency, dropoff_point &rarr;DeliveryCenter, sender &rarr;Customer, recipient &rarr;Customer, courier &rarr;Courier)

CHECK(urgency = "normal" OR urgency ="urgent")

CHECK(weight > 0)

NOT NULL(dropoff_point)

**DeliveryCenter**(<u>id</u>, name, address)

InternalTracking(<u>package</u>&rarr;Package, <u>delivery_center</u>&rarr;DeliveryCenter, date_time_of_arrival, date_time_of_departure)

CHECK(date_time_of_arrival >= date_time_of_departure)

## Furniture Factory

**Pieces**(<u>reference</u>, price, line &rarr; Line)

NOT NULL(line)

NOT NULL(price)

CHECK(price > 0)



**Lines**(<u>id</u>, type)

NOT NULL(type)

UNIQUE(type)

**Components**(<u>code</u>, price, component_type &rarr; ComponentTypes)

NOT NULL(component_type)

NOT NULL(price)

CHECK(price > 0)



**PieceComponents**(<u>piece</u> &rarr; Piece, <u>component</u> &rarr; Component, quantity)


NOT NULL(quantity)

CHECK(quantity > 0)



**ComponentTypes**(<u>name</u>)


**Orders**(<u>number</u>, date)

NOT NULL(date)



**OrderPieces**(<u>order</u> &rarr; Order, piece &rarr; <u>Piece</u>, quantity)

CHECK(quantity > 0)



**Stores**(<u>id</u>, name, address, fax_no)

NOT NULL(name)

NOT NULL(address)

## Factory



**Clients**(<u>id</u>, first name, surname, address, phone, name_contact)

**Workers**(<u>id</u>, first name, surname, address, birth_date)

`Comment: The generalization is disjoint, so we adopt an Object-Oriented strategy for mapping. The Person relation does not exist, because the generalization is complete, so there is no need for the relation usuallu derived from the superclass. If the generalization was partial instead of complete, we would have to retain the Person relation.`

**Skills**(<u>name</u>)

**WorkerSkills**(<u>worker</u> &rarr; Worker, <u>skill</u> &rarr; Skill)

**Machine**(<u>serial_no</u>, make, model, purchase_date)

NOT NULL(purchase_date)

**MachineWorkers**(<u>worker</u> &rarr; Worker, <u>machine</u> &rarr; Machine)

**Products**(<u>identifier</u>, name, product_type &rarr; ProductTypes)

NOT NULL(name)

**ProductTypes**(<u>id</u>, material, weight, produced_by &rarr; Machine)

NOT NULL(material)

CHECK(weight > 0)

**PurchaseOrder**(<u>number</u>, date_made, expected_delivery, actual_delivery, issuer &rarr; Client)

NOT NULL(date_made)

NOT NULL(expected_delivery)

NOT NULL(actual_delivery)

NOT NULL(issuer)

CHECK(date_made <= expected_delivery AND date_made <= actual_delivery)

**OrdersProducts**(<u>product</u> &rarr; Products, <u>purchase_order</u> &rarr; PurchaseOrders, quantity)

CHECK(quantity > 0)

## Bicycles

**Clients**(<u>id</u>, NIN, TIN, name, address)

UNIQUE(NIN)

UNIQUE(TIN)

NOT NULL(name)



**Reservations**(<u>id</u>, pickup_day, return_day, actual_rented_bike &rarr; Bicycle, desired_model &rarr; BicycleModel, pickup_place &rarr; Store, client &rarr; Client)

NOT NULL(pickup_day)

NOT NULL(requested_model)

NOT NULL(pickup_place)

NOT NULL(model)

CHECK(return_day >= pickup_day)



**Stores**(<u>name</u>, address)

NOT NULL(address)



**Bicycles**(<u>number</u>, model &rarr; BicycleModels)

NOT NULL(model)



**BicycleModels**(<u>name</u>, type, no_gears)

NOT NULL(type)

CHECK(no_gears >= 1)
