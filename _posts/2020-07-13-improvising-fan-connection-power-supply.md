---
layout: post
title:  "Improvising a fan from a PC power supply and a computer fan"
date:   2020-07-13 12:05:000 +0100
tags: corsair power supply ax860 summer heat power supply
---

These days have been blistering hot, so I had to improvise a fan with some hardware I had at home. Here I am using a [Corsair AX860 Power Supply](http://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&pub=5575597576&toolid=10001&campid=5338700334&customid=&mpre=https%3A%2F%2Fwww.ebay.com%2Fsch%2Fi.html%3F_from%3DR40%26_trksid%3Dp2334524.m570.l1313.TR5.TRC1.A0.H0.XCorsair%2BAX860.TRS0%26_nkw%3DCorsair%2BAX860%26_sacat%3D42017%26LH_TitleDesc%3D0%26_odkw%3Dcorsair%2Bml120) and a [120mm Corsair ML120 fan](http://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&pub=5575597576&toolid=10001&campid=5338700334&customid=&mpre=https%3A%2F%2Fwww.ebay.com%2Fsch%2Fi.html%3F_from%3DR40%26_trksid%3Dp2499334.m570.l1313.TR11.TRC1.A0.H0.Xcorsair%2Bml120.TRS0%26_nkw%3Dcorsair%2Bml120%26_sacat%3D42017) that I had lying around.

![Computer fan hooked up to a power supply!](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/final_product.jpg){:class="img-center fullwidth"}
*Computer fan hooked up to a power supply!*{:class="img-caption"}

## Bill of materials

 -	An ATX PC Power Supply
 -	A PC fan (I am using a 120mm one)
 -	A 3-pin fan extension cable
 -	Short piece of wire
 -	Electrical tape
	
## Procedure

1. Cut a short (e.g. 4cm) piece of wire and stript the ends. 
	![A short piece of wire with ends stripped](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/short_stripped_cable.jpg){:class="img-center fullwidth"}
*A short piece of wire with ends stripped*{:class="img-caption"}

2. Using a knife or boxcutter, cut the edge of the female end of the 3-pin fan extension cable so that it can fit into the 4-pin PWM male header of the fan.
	![3-pin extension with one of the sides removed](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/cut_female_header.jpg){:class="img-center fullwidth"}
*3-pin extension with one of the sides removed*{:class="img-caption"}

3. Unpin the red and yellow wires from the male connector of the fan extension. You can use a needle to press against the visible metal on the back of the connector and gently pull the wires out.
	![Male fan header connector pins](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/fan_male_header_pins.jpg){:class="img-center fullwidth"}
*Male fan header connector pins. Press with a needle to unpin each cable*{:class="img-caption"}

4. Insert the short piece of wire into the 24-pin ATX cable of the PSU, as shown in the diagram below.
	![Electrical connections](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/ATX_PS_signals.png){:class="img-center fullwidth"}
*Electrical connections on the ATX PSU. Image based on this one: [click](https://en.wikipedia.org/wiki/ATX#/media/File:ATX_PS_signals.svg)*{:class="img-caption"}

5. Insert the red wire of the fan extension into a +12V hole of the 24-pin plug. Any hole marked as +12V1 or +12V2 in the diagram will work.

6. Insert the black wire of the fan extension  Any hole marked as COM in the diagram will work.
	![Final Product](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/final_connections.jpg)
*Finished connections*{:class="img-caption"}

7. Connect the male plug of the fan to the female end of the extension.

8. Turn on the PSU. The fan should start up immediately.

9. If everything is ok, isolate the ends of the fan extension and stick them to the 24-pin cable holes so that it holds in place and protects you from shocks.

![A roll of Electrical tape](/assets/images/post-images/2020-07-13-improvising-fan-connection-power-supply/electrical_tape.jpg)
*Do not forget to isolate the pins connected to the PSU, especially the 12V-GND ones of the fan!*{:class="img-caption"}
