### Team members

* David Bartoň (initial idea of dunction blocks; signalTransmitter.vhd)
* Šimon Bárta (signalTransmitter.vhd; top.vhd; tb_MorseDecoder.vhd)
* Jakub Fojtík (7seg_decoder.vhd; tb_MorseDecoder.vhd)

## prvotni napady + poznamky
- prijimac musi vykreslit nejak signal tzn nejlepe slovnik znaku a pokud nam prijde spravna sekvence .- tak vykreslime nejaky znak nejlepe ten odpovidajici na hexadecimalu treba
- vstup a vystup bude v constrain file odkomentovany a pridany jako OUT nebo IN v designu
- jedno tlacitko co bude ovladat tecky i carky: tecka bude tecka; carka budou 3 tecky; konec vety oznacen napr 7 sek bez stisku naseho tlacitka
- jak zapsat data z BTNC na soubor nekolika 1 a 0 abzchom je mohli precist nebo vyslat? ASI COUNTER.vhd by mel pomoct


## Theoretical description and explanation

Our assignment was to do morse code transmitter and reciever using Nexys A7-50T development board in VHDL language. We wanted to use one button that would send 1 for HIGH and 0 for LOW, then using time intervals of 250 ms. One interaval of 250 ms should be dot and space between, 1000 ms should be dash. These characters (dot, dash, space) are then written into array of 4 double digits. The array is then 8-bits long and each two digits represents sign: 00 = nothing, 01 = dot, 10 = dash. These 8-bit numbers are then used in our case-when statement to light-up correct letter from alphabet on 7 segment display.

## Hardware description of demo application

Insert descriptive text and schematic(s) of your implementation.

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

### Component(s) simulation

Write descriptive text and simulation screenshots of your components.

## Instructions

Write an instruction manual for your application, including photos or a link to a video.

## References

1. Put here the literature references you used.
2. ...
