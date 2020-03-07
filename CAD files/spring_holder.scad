/*

Removable spring hanger to be used with the translation stage (mount_holder.scad) to make it easier to install the springs
Fits into the grove on the mount_holder.scad

*/

$fs =0.2;
$fa = 0.2;

block_height = 8;
block_width = 8;
block_length = 8;

bar_length = 30;
bar_width = 2.5;
bar_height = 2.5;

bushing_d = 4.7;

difference(){
    union(){
        cube([block_width,block_length,block_height],center=true);
        translate([0,0,-block_height/2+bar_height/2]) cube([bar_width,bar_length,bar_height],center=true);
    }
    cylinder(d = bushing_d, h = block_height+2, center=true);
}