`timescale 1ns / 1ps

module experiment3_tb();
	
	// ----- Inputs & Outputs
	reg a,b,c,d; 
	wire f0,f1,f2,f3;

	// ----- Testbench Parameters ----- //
	parameter wait_time = 50;
	integer i;

	reg [3:0]correct_results[0:15];
	initial begin
		correct_results[0]  = 0; correct_results[1]  = 0; correct_results[2]  = 0 ;correct_results[3] = 0;
		correct_results[4]  = 0; correct_results[5]  = 1; correct_results[6]  = 2 ;correct_results[7] = 3;
		correct_results[8]  = 0; correct_results[9]  = 2; correct_results[10] = 4 ;correct_results[11] = 6;
		correct_results[12] = 0; correct_results[13] = 3; correct_results[14] = 6 ;correct_results[15] = 9;
	end
	// --------------------------------- //
	
	// ---------- UUT Instantiation -------------- //
	
	/*with_decoder*/ 
	with_MUX 
	/*with_SSI*/ UUT(.a(a),
		.b(b),
		.c(c),
		.d(d),
		.f0(f0),
		.f1(f1),
		.f2(f2),
		.f3(f3));

	// ------- Test Procedure ------- //
	initial 
	begin
		
		for(i=0;i<16;i=i+1)
		begin

			{a,b,c,d} = i;
			#(wait_time);
			$write("{a,b,c,d}=%d%d%d%d => {f3,f2,f1,f0} = %d%d%d%d -- ",a,b,c,d,f3,f2,f1,f0);
			if({f3,f2,f1,f0} == correct_results[i])
				$display("TRUE");
			else
				$display("FALSE");
			
		end
		
		$finish();
		
	end
	// ------------------------------- //
	
endmodule
