/*

This is the plastic bar that holds the springs at the bottom of the camera mount (camera_mount.scad)

*/

$fa = 0.2;
$fs = 0.2;

rotate([90,0,0]) cylinder(h=23, r=1,center=true);
translate([0,0,-0.5]) cube([2,23,1], center=true);