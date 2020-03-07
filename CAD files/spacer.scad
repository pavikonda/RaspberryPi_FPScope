/*

Spacers to be used with Raspberry Pi HATs to keep the HAT parallel to the Raspberry Pi

*/

$fa = 0.2;
$fs = 0.2;

height = 9;
inner_r = 1.5;
outer_r = 3;

difference(){
    cylinder(r = outer_r, h = height);
    
    translate([0,0,-1]) cylinder(r = inner_r, h = height + 2);
};
