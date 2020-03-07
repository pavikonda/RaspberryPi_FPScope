/*

A mount to attach an Adafruit 8x8 high density DotStar LED array onto a Raspberry Pi like a HAT.

*/

$fs = 0.2;
$fa = 0.2;

screw_r = 1.5;
outer_r = 3.1;

height = 9;

bolt_length = 58;
bolt_width = 49;

extra = 3.5;

top_width = bolt_width + extra + extra;
top_length = bolt_length + extra + extra;

thickness = 2;

attachment_r = 1.5;
side = 25.4;
attachment_side = 5;

///////////////////////////////////////////////
/*

dimensions for the adafruit 8x8 dotstar led array:

side = 25.4mm
attachment side = 5mm

locations of attchements should therefore be 

in the x direction:
top_length/2 +/- side/2 +/- attachment/2 

in the y direction:
top_width/2 +/- side/2 +/- attachment/2


*/
/////////////////////////////////////////////

module foot(){
    cylinder(r=outer_r,h=height);
}

difference(){
    union(){
        cube([top_length, top_width,thickness]);
        translate([extra,extra,-height]) foot();
        translate([bolt_length+extra,extra,-height]) foot();
        translate([extra,bolt_width+extra,-height]) foot();
        translate([bolt_length+extra,bolt_width+extra,-height]) foot();
    };
    
    
    translate([extra+extra,-0.001,-0.001]) cube([bolt_length-extra-extra,extra+extra,thickness+0.002]);    
    translate([top_length/2-side/2+1,extra+extra-0.01,-1]) cube([side-2,side+(top_width-side-extra-extra)/2,thickness+2]);
    
    // HOLES FOR THE FOUR LEGS
    translate([extra,extra,-height-1]) cylinder(r=screw_r,h=height+thickness+2);
    translate([bolt_length+extra,extra,-height-1]) cylinder(r=screw_r,h=height+thickness+2);
    translate([extra,bolt_width+extra,-height-1]) cylinder(r=screw_r,h=height+thickness+2);
    translate([bolt_length+extra,bolt_width+extra,-height-1]) cylinder(r=screw_r,h=height+thickness+2);
    
    // HOLES FOR LED ARRAY ATTACHMENTS
    translate([top_length/2+side/2+attachment_side/2,top_width/2+side/2-attachment_side/2,-1]) cylinder(r=attachment_r,h=height);
    translate([top_length/2-side/2-attachment_side/2,top_width/2+side/2-attachment_side/2,-1]) cylinder(r=attachment_r,h=height);
    translate([top_length/2+side/2+attachment_side/2,top_width/2-side/2+attachment_side/2,-1]) cylinder(r=attachment_r,h=height);
    translate([top_length/2-side/2-attachment_side/2,top_width/2-side/2+attachment_side/2,-1]) cylinder(r=attachment_r,h=height);
};


