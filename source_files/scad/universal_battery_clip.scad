$inner_diameter = 18/2; //Radius of batter wall (mm)

$battery_offset = 1;

$clip_height = 3;

$number_of_batteries = 2;

$tolerence = 0.2;

//$number_of_fragents = 45;
$number_of_fragents = 360;

module reference_battery($fn = $number_of_fragents) {
    // reference stethoscope head as it was too complex to load into memory
    cylinder(h = 65, r = $inner_diameter);

}

module clip($fn = $number_of_fragents) {
    
    
    difference() {
    // the clip itself
    difference() {
        cylinder(h = $clip_height, r =  $inner_diameter + $battery_offset + $tolerence/2 );
        cylinder(h = $clip_height, r =  $inner_diameter + $tolerence/2);
        
    }
    
    // hole to pass the battery through
    translate(v = [0, -$inner_diameter, 0]){
        cube([2*0.6*$inner_diameter, 5, 20], center = true);
    }
    
    }
}


for (a =[0:1:$number_of_batteries - 1]){
    echo(a);
    translate(v = [a*($inner_diameter*2 + $battery_offset), 0, 0]){
      
//        reference_battery();
        clip();
    }
}   
