---
layout: post
title:  "How to repair MacBook Magsafe and Magsafe 2 chargers"
date: 2021-03-14 11:26:000 +0100
tags: macbook charger repair magsafe magsafe2 guide diy
comments_id: 24
---


![Title Image](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/title.jpg)

The flimsy and non-user replaceable cables found in the Magsafe 1 and 2 chargers are always the main point of failure. The new USB-C chargers have fixed this by making the cables removable to [allow Apple to sell you one at 20€](https://amzn.to/3eBWn1a)... but those of us using an older MacBook with a torn charger cable still have to shell out [80€ for a brand new one](https://amzn.to/3bMv6Yg) or, even worse, go for a [cheap/fake eBay/Amazon counterpart](https://amzn.to/2NOL62s) for 1/4 of the cost.

There is a third alternative. Why not fix your current one and help save the planet by reducing e-Waste? Here is a complete guide to help you recover your MacBook's MagSafe charger by replacing only the torn cable with a new one.

{% include danger.html content="Disclaimer: Perform these repairs at your own risk and peril. I am not responsible for any damage caused by the following of this guide. Always consult a professional and, in doubt, simply buy a new charger from an authorized Apple retailer." %}

## Why you should not buy a knockoff charger

Please do **not** buy one of these. If you do not think you are able to undertake this repair, please take it to a local repair shop and have them do it for you, or simply buy a genuine Apple charger.

Here are the main problems with knockoff chargers:

1. Their cables are flimsier than the original (as if that were possible...)
2. Manufacturers cut down on costs heavily, a.k.a. you really get what you pay for. Such chargers are much lighter, indicating the presence of less components, crude construction and no copper at all. In particular, the AC to DC conversion is performed using lower quality components, resulting in increased waste heat (inefficiency).
3. Buzzing and static in the 3.5mm headphone jack. I once had one of these chargers and its bad grounding caused my laptop's headphones to constantly buzz.
4. Voltage fluctuations can lead to unexpected shutdowns when the system is under load.
5. The so-called __coil whine__, where you hear buzzing or hissing sounds coming from the charger.
6. Lower or no overcurrent protection, which can simply fry your computer when there is a thunder storm or a failure in the power grid.
6. Electric shocks! Yes, with my now deceased fake eBay charger I got a shock in my ears if I wore metal headphones, like my [Xiaomi Piston Headphones](https://amzn.to/3dSK6Fk).

## Parts


![The charger that we will fix in this guide](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/charger.jpg){:class="img-center"}
*The charger that we will fix in this guide.*{:class="img-caption"}


- Your broken MagSafe 1 or MagSafe 2 charger.
- A Magsafe 1 or Magsafe 2 replacement cable ([Amazon link](https://amzn.to/3eEwnSS)).
- Heat-shrinkable tubing for insulating the ends of the new cable ([Amazon Link](https://amzn.to/3qJIC2L))
- A roll of 0.6mm solder wire. ([Amazon Link](https://amzn.to/38GuH7s))
- Temperature-resistant adhesive assembly glue, commonly used in house work as an alternative to screws and nails. I got one with approx. 80ºC max temperature, the one in the link should be even more resistant. ([Amazon Link](https://amzn.to/3tlkohk)).

## Tools

![Tools necessary for replacing MacBook charger's cable](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/tools.jpg){:class="img-center"}
*Tools necessary for replacing MacBook charger's cable.*{:class="img-caption"}

- Long-nosed pliers ([Amazon Link](https://amzn.to/3ljWHD1)).
- Flat head pliers ([Amazon Link](https://amzn.to/30JhDdm)).
- Soldering iron (65W-100W) ([Amazon Link](https://amzn.to/3cvsfSr)).
- Universal gun for adhesive tubes ([Amazon Link](https://amzn.to/3qM9ak6)).
- Old wet sponge for cleaning soldering iron.

**Optional Tools**

- Desoldering pump, useful for pumping out the old solder when removing the broken cable. ([Amazon Link](https://amzn.to/3eHclaj)).
- Multimeter, for checking for continuity between the 12V and Ground wires after you solder, making sure that you do not have a short circuit. ([Amazon Link](https://amzn.to/2Q4k4oI)).


## Procedure

### Open up the old charger

Position the tips of your flat head pliers on the edge of the charger where the folding clips for the wire are. Crack the charger open by exerting force on the pliers in the direction shown in the picture. 

![Using flat head pliers to open a MacBook Charger](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/open-charger-1.jpg){:class="img-center"}
*Using flat head pliers to open a MacBook Charger.*{:class="img-caption"}

![Using flat head pliers to open a MacBook Charger - Result](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/open-charger-2.jpg){:class="img-center"}
*Using flat head pliers to open a MacBook Charger - Result.*{:class="img-caption"}

It takes some force as the interior cage of the charger is glued to the outside shell with some sort of high-power white adhesive.

### Desoldering the old cable

After cracking open the charger you will see that the cable is soldered to two large contacts.

![GND and 12v contacts - detail of the contacts to desolder from the charger](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/contacts-detail-1.jpg){:class="img-center"}
![GND and 12v contacts - detail of the contacts to desolder from the charger](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/contacts-detail-2.jpg){:class="img-center"}
![GND and 12v contacts - detail of the contacts to desolder from the charger](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/contacts-detail-3.jpg){:class="img-center"}
*GND and 12v contacts - detail of the contacts to desolder from the charger.*{:class="img-caption"}


{% include danger.html content="Disclaimer: Make sure to solder the wires of the same color when you put in the new cable, otherwise you will fry something! Take a picture of your charger's wires so that you know which contact holds the black wire (Ground) and the white wire (12V) before you unsolder them." %}

Time to desolder the old cable. I used a 65W soldering iron, which is quite weak for the purpose. The tip would not heat up the solder enough so I had to slide the iron across the contacts to supply enough heat. If you have a stronger soldering iron I recommend using that instead. Place it on a heat-resistant surface so that it does not burn through or melt anything while it is hot but not being used.

![My 65W soldering iron](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/soldering-iron.jpg){:class="img-center"}
*My 65W soldering iron.*{:class="img-caption"}

![My desoldering pump](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/desoldering-pump.jpg){:class="img-center"}
*My desoldering pump.*{:class="img-caption"}


If you have a desoldering pump, you can use it to pump out the solder as you liquify it with your soldering iron. Less solder in the contact will make it easier and easier to loosen the cable, especially when you use a weak soldering iron. A weak iron will have difficulty keeping the entire solder blob liquid, so the less solder the better when wiggling out the old cable.

![Wire ends now free of solder blobs](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/contacts-no-excess-solder.jpg){:class="img-center"}
*Wire ends now free of solder blobs, after using the desoldering pump to suck out the excess solder.*{:class="img-caption"}

After heating up the contacts and pumping out the excess solder, the large round solder blobs are gone and you can see the ends of the wire.

Using a desoldering pump is easy: You arm it, heat up your solder and trigger it close to the liquid solder. The spring will fire and quickly suck out the old solder. When you arm it again, the pumped solder, now solid, will come out from the desoldering pump's nose.

![Excess solder extracted by the desoldering pump](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/excess-solder.jpg){:class="img-center"}


Now let's start pulling out the cables while applying heat with the soldering iron. Use your thin-nosed pliers to apply some force to the wire while you heat up the contacts on the other end using your soldering iron. Try to apply the least amount of force to the wire until you see the solder liquify on the other side, otherwise you risk ripping the cable out altogether or to damage the circuit board. 

![Pulling out the cables while applying heat with the soldering iron](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/thin-nosed-pliers-force.jpg){:class="img-center"}
![Wire out of the board](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/wire-pulled-out-1.jpg){:class="img-center"}
![Wire out of the board - Second wire](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/wire-pulled-out-2.jpg){:class="img-center"}
![Wire out of the board - Holes visible wire](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/wire-pulled-out-3.jpg){:class="img-center"}
*Desoldering wires out of the circuit board.*{:class="img-caption"}

Here is the same result for an 85W Charger (MacBook Pro 15 inch):

![85W charger - removing wires 1](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/macbook-pro-15-unsolder.jpg){:class="img-center"}
![85W charger - removing wires 2](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/macbook-pro-15-unsolder-2.jpg){:class="img-center"}
*The same result in a 15-inch MacBook charger*{:class="img-caption"}

### Prepare new cable with heat-shrinkable insulation sleeve

Add some heat-shrinkable tube to the ends of the new cable. This is a special type of plastic insulation that will retract when it is heated, forming an insulating layer over an exposed wire. 

![Box of heat shrinkable tubing for wire insulation (in multiple sizes)](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/heatshrink.jpg){:class="img-center"}
*Box of heat shrinkable tubing for wire insulation (in multiple sizes).*{:class="img-caption"}

Cut two pieces of insulation sleeve, roughly around 1 centimeters each.

![Insulation tubing now cut to size, around 1 centimeter will be enough](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/heatshrink-cut-to-size.jpg){:class="img-center"}
*Insulation tubing now cut to size, around 1 centimeter will be enough.*{:class="img-caption"}

Run one tube into each wire and you will be ready to start soldering. Normally you need to heat up the sleeve using a lighter or a candle, but in this case the residual heat of the soldering iron turned out to be sufficient. The sleeve will shrink as you solder.

![Insulation tubing now placed into the wires, ready to solder](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/heatshrink-tubing-in-wire.jpg){:class="img-center"}

*Insulation tubing now placed into the wires, ready to solder.*{:class="img-caption"}

### Solder the new wires

Recall the picture you took before showing the colors of the wires in each hole of the charger's circuit board. Run the same color wires into each hole.

![Wires placed into the holes of the charger circuit board](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/ready-to-solder.jpg){:class="img-center"}
*Wires placed into the holes of the charger circuit board.*{:class="img-caption"}

Solder the two wires using your soldering iron. I recomment heating up the wire and then applying solder to the wire. The heat will be transmitted to the board and make the solder flow around each hole, as the metal in the board will heat up almost instantly when compared to the thick wire.

![One wire, already soldered...](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/soldered-1.jpg){:class="img-center"}
*One wire, already soldered....*{:class="img-caption"}

![...and the second wire as well.](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/soldered-2.jpg){:class="img-center"}
*...and the second wire as well.*{:class="img-caption"}

### Test the charger

Use your multimeter to check for continuity between the two terminals. This is to make sure that you did not solder them together, creating a dangerous short-circuit!

![Testing for continuity](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/testing-for-continuity.jpg){:class="img-center"}
*Testing for continuity.*{:class="img-caption"}

If you get around 178 kΩ, that is fine. 0Ω means a short circuit! 

![Finished result](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/soldered-1.jpg){:class="img-center"}
![Finished result - second angle](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/soldered-2.jpg){:class="img-center"}
*Finished result. Wires soldered and insulation covers the ends.*{:class="img-caption"}


### Re-sealing the charger

Get some high-temperature assembly adhesive and and coat the interior of the two halves of the charger. I used this high-strength glue that i found at a local supermarket chain. As long as it is resistant to temperature you should be good to go. If you find white adhesive instead of my off-white color may even get a better finish.

![Brand of the adhesive](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-1.jpg){:class="img-center"}
![Strength of the adhesive](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-3.jpg){:class="img-center"}
![Temperature range of the adhesive](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-2.jpg){:class="img-center"}
*Brand, Strength rating and Temperature range of my adhesive*{:class="img-caption"}

Apply it using the adhesive gun:

![Adhesive gun](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-gun.jpg){:class="img-center"}
*Adhesive gun*{:class="img-caption"}

Align the two halves and apply some more adhesive to the outside edge.

![Applying adhesive to the edge of the charger (1/4)](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-edge-charger-1.jpg){:class="img-center"}
![Applying adhesive to the edge of the charger (2/4)](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-edge-charger-2.jpg){:class="img-center"}
![Applying adhesive to the edge of the charger (3/4)](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-edge-charger-3.jpg){:class="img-center"}
![Applying adhesive to the edge of the charger (4/4)](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/adhesive-edge-charger-3.jpg){:class="img-center"}
*Apply adhesive to the inside of the charger's two plastic halves.*{:class="img-caption"}

Wipe off the excess adhesive that can come out the sides before you let it dry.

![Wiping off excess adhesive](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/wipe-off-excess.jpg){:class="img-center"}
*Applying adhesive to the edge of the charger*{:class="img-caption"}

Press the charger securely in a vice for 72 hours for the adhesive to achieve maximum strength (not too much otherwise you will crush the fragile plastic). Place a rag around the charger so that the jaws of the vice do not damage the casing of the charger.

![MacBook charger clamped in the vice](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/charger-in-vice.jpg){:class="img-center"}
*The MacBook charger, clamped in a vice for the adhesive to cure*{:class="img-caption"}

### Final result


![Final Result](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/final-result.jpg){:class="img-center"}

![MagSafe Charger charging a Macbook](/assets/images/post-images/2021-02-28-how-to-repair-macbook-chargers/final-result-2.jpg){:class="img-center"}