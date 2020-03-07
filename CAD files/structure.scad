/*

Structure that connects to the Raspberry Pi and holds the camera translation stage above it. 
top.scad fits onto the top, the cylindrical spaces in the fitting make room for screws.

*/

include <prism.scad>;

$fa = 0.5;
$fs = 0.5;

bolt_separation = 49;

//height of the setup, NOT including the "fitting"
height = 51;

//dimensions of the "feet", part of the legs which stick out and have holes to attach to the Raspberry Pi
foot_width = 7;
foot_length = 6 + 0.5 + 0.5 + 1;
foot_thickness = 3;
//radii of the holes in the feet
foot_r = 1.5;
nut_r = 3;

//distance by which the structure is larger than the Raspberry Pi board, which therefore corresponds to the thickness of the legs ang "beam" which connect the legs
extra = 7;

//the - 1 is since the holes in the feel arent at foot_length/2 but at foot_length/2 - 0.5.
top_width = bolt_separation + 2*extra + foot_length - 1;
//the last +0.5 is tolerance so that the legs aren't that close to the actual LEDs
top_length = 58 + 3 + 3 + 0.5 + 0.5 + 0.5;
top_length = (58 + 3 + 3 + 0.5 + 0.5) + 0.5;
top_thickness = 2;

total_length = 85;
beam_height = extra;
fitting_height = 5;
//the corresponding fitting on top.scad is extra/3 minus some tolerance
fitting_width = extra/3*2;

angle = 30;
prism_height = (foot_length+extra) * tan(angle);

hole_height = 2.5;
hole_r = 2;

module leg(){
    
    difference(){
        union(){
            //foot
            cube([foot_width,foot_length+extra,foot_thickness]);
            //leg
            cube([foot_width, extra, height]);
            //prism
            rotate([0,0,90]) translate([0,-foot_width,foot_thickness]) prism(foot_width,foot_length + extra,prism_height);
        };
        
        translate([foot_width/2, extra+foot_length/2 - 0.5,-1]) 
        union(){
           cylinder(r=foot_r, h=foot_thickness+2);
           translate([0,0,1+foot_thickness]) rotate([0,0,30]) cylinder(r=nut_r, h=prism_height, $fn = 6);
        };
    };
};


// beam refers to the horizontal cuboids that connect the "legs"
module beam(length){
    cube([length,extra,beam_height]); 
};

// fitting refers to the square at the top of the structure, that is meant to fit into the "fitting" on top.scad
module fitting(width,length,thickness){
    cube([length,thickness,fitting_height]);
    cube([thickness,width,fitting_height]);
    translate([length-thickness,0,0]) cube([thickness,width,fitting_height]);
    translate([0,width-thickness,0]) cube([length,thickness,fitting_height]);
}






//lower beams
beam(top_length);
translate([0,top_width-extra,0]) beam(top_length);
union(){
        translate([foot_width-0.001,0,beam_height]) prism(extra,prism_height,prism_height);
        rotate([0,0,180]) translate([-0.001-top_length+foot_width,-extra,beam_height]) prism(extra,prism_height,prism_height);
    };
translate([0,top_width-extra,0]) union(){
        translate([foot_width-0.001,0,beam_height]) prism(extra,prism_height,prism_height);
        rotate([0,0,180]) translate([-0.001-top_length+foot_width,-extra,beam_height]) prism(extra,prism_height,prism_height);
    };


difference(){
    union(){
        //higher beams
        translate([0,extra,height]) rotate([180,0,0]){
            beam(top_length);
            translate([0,-top_width+extra,0]) beam(top_length);
        };
        translate([0,0,height]) rotate([180,0,90]){
            beam(top_width);
            translate([0,top_length-foot_width,0]) beam(top_width);
            
        };



        //fitting
        translate([foot_width-fitting_width,extra-fitting_width,height]) fitting(length=top_length-2*foot_width+2*fitting_width, width = top_width-2*extra+2*fitting_width,thickness = fitting_width);
        
        //make 4 legs in the correct positions
        leg();
        translate([top_length-foot_width,0,0]) leg();
        translate([foot_width,top_width,0]) rotate([0,0,180]) leg();
        translate([top_length,top_width,0]) rotate([0,0,180]) leg();
    };
    
    //Cutouts for the screws used to attach the translation stage to the top.scad. These values should be the same as in top.scad.
    aperture_x = top_length/2;
    aperture_y = top_width/2 -1;
    attachment_separation = 40;
    attachment_r = 9;
    aperture_to_attachment = 22.5;

    translate([0,0,height-2]){
        translate([aperture_x+attachment_separation/2,aperture_y-aperture_to_attachment,-fitting_height-1]) cylinder(r=attachment_r-1,h=top_thickness+fitting_height+8);
        translate([aperture_x-attachment_separation/2,aperture_y-aperture_to_attachment,-fitting_height-1]) cylinder(r=attachment_r-1,h=top_thickness+fitting_height+8);
    }
    };



