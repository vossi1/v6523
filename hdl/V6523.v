/*
   V6523 - mos6523 Replacement (6525 without Interrupt Controller)
   Original Design: Copyright (c) 2024 Vossi
	www.mos6509.com
	
   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.

   V6523.v: Implements mos6523 with 3x 8bit I/O Port
	
	v.2 version:
	- cs combiuned with phi2 for the C64 IEEE488 interface
*/

module V6523(	inout [7:0]data,
				inout [7:0]porta,
				inout [7:0]portb,
				inout [7:0]portc,
				input [2:0]rs,
				input r_w,
				input _cs,
				output cs,
				input cs_oh,
				input _reset,
				input phi2
            	);

reg [7:0]data_out;
wire [7:0]porta_out;
wire [7:0]porta_data;
reg [7:0]porta_ddr_reg;
reg [7:0]porta_data_reg;
wire [7:0]portb_out;
wire [7:0]portb_data;
reg [7:0]portb_ddr_reg;
reg [7:0]portb_data_reg;
wire [7:0]portc_out;
wire [7:0]portc_data;
reg [7:0]portc_ddr_reg;
reg [7:0]portc_data_reg;
wire delay1, delay2, delay3, delay4;	// output hold delay wires
wire _csphi2;

assign data = data_out;			// data read output to 6502
assign porta = 	porta_out;		// output to io-port
assign portb = 	portb_out;		// output to io-port
assign portc = 	portc_out;		// output to io-port
assign _csphi2 = _cs | !phi2;	// cs only with phi2

// CS delay for databus output hold time ( about 20ns - each inverter needs 5ns )
(*S = "TRUE"*) inverter inv1(!_csphi2, delay1);		//(prefix *S prevents removing in optimization)
(*S = "TRUE"*) inverter inv2(delay1, delay2);
(*S = "TRUE"*) inverter inv3(delay2, delay3);
(*S = "TRUE"*) inverter inv4(delay3, delay4);
assign cs = !_csphi2 | delay4;		// cs with about 30ns extended incl. in/out (output hold time mos 6523 datasheet)

always @(posedge _csphi2, negedge _reset)
begin
	if(!_reset) begin 					// reset all register
		porta_data_reg <= 0;
		portb_data_reg <= 0;
		portc_data_reg <= 0;
		porta_ddr_reg <= 0;
		portb_ddr_reg <= 0;
		portc_ddr_reg <= 0;
		end
	else if(!r_w) begin 				// write selected register
		if(rs == 3'b000)
			porta_data_reg <= data;
		if(rs == 3'b001)
			portb_data_reg <= data;
		if(rs == 3'b010)
			portc_data_reg <= data;
		if(rs == 3'b011)
			porta_ddr_reg <= data;
		if(rs == 3'b100)
			portb_ddr_reg <= data;
		if(rs == 3'b101)
			portc_ddr_reg <= data;
		end
end

assign porta_data[0] = (porta_ddr_reg[0] ? porta_data_reg[0] : porta[0]);	// port A read
assign porta_data[1] = (porta_ddr_reg[1] ? porta_data_reg[1] : porta[1]);
assign porta_data[2] = (porta_ddr_reg[2] ? porta_data_reg[2] : porta[2]);
assign porta_data[3] = (porta_ddr_reg[3] ? porta_data_reg[3] : porta[3]);
assign porta_data[4] = (porta_ddr_reg[4] ? porta_data_reg[4] : porta[4]);
assign porta_data[5] = (porta_ddr_reg[5] ? porta_data_reg[5] : porta[5]);
assign porta_data[6] = (porta_ddr_reg[6] ? porta_data_reg[6] : porta[6]);
assign porta_data[7] = (porta_ddr_reg[7] ? porta_data_reg[7] : porta[7]);

assign portb_data[0] = (portb_ddr_reg[0] ? portb_data_reg[0] : portb[0]);	// port B read
assign portb_data[1] = (portb_ddr_reg[1] ? portb_data_reg[1] : portb[1]);
assign portb_data[2] = (portb_ddr_reg[2] ? portb_data_reg[2] : portb[2]);
assign portb_data[3] = (portb_ddr_reg[3] ? portb_data_reg[3] : portb[3]);
assign portb_data[4] = (portb_ddr_reg[4] ? portb_data_reg[4] : portb[4]);
assign portb_data[5] = (portb_ddr_reg[5] ? portb_data_reg[5] : portb[5]);
assign portb_data[6] = (portb_ddr_reg[6] ? portb_data_reg[6] : portb[6]);
assign portb_data[7] = (portb_ddr_reg[7] ? portb_data_reg[7] : portb[7]);

assign portc_data[0] = (portc_ddr_reg[0] ? portc_data_reg[0] : portc[0]);	// port C read
assign portc_data[1] = (portc_ddr_reg[1] ? portc_data_reg[1] : portc[1]);
assign portc_data[2] = (portc_ddr_reg[2] ? portc_data_reg[2] : portc[2]);
assign portc_data[3] = (portc_ddr_reg[3] ? portc_data_reg[3] : portc[3]);
assign portc_data[4] = (portc_ddr_reg[4] ? portc_data_reg[4] : portc[4]);
assign portc_data[5] = (portc_ddr_reg[5] ? portc_data_reg[5] : portc[5]);
assign portc_data[6] = (portc_ddr_reg[6] ? portc_data_reg[6] : portc[6]);
assign portc_data[7] = (portc_ddr_reg[7] ? portc_data_reg[7] : portc[7]);

assign porta_out[0] = (porta_ddr_reg[0] ? porta_data_reg[0] : 1'bz);		// port A outputs
assign porta_out[1] = (porta_ddr_reg[1] ? porta_data_reg[1] : 1'bz);
assign porta_out[2] = (porta_ddr_reg[2] ? porta_data_reg[2] : 1'bz);
assign porta_out[3] = (porta_ddr_reg[3] ? porta_data_reg[3] : 1'bz);
assign porta_out[4] = (porta_ddr_reg[4] ? porta_data_reg[4] : 1'bz);
assign porta_out[5] = (porta_ddr_reg[5] ? porta_data_reg[5] : 1'bz);
assign porta_out[6] = (porta_ddr_reg[6] ? porta_data_reg[6] : 1'bz);
assign porta_out[7] = (porta_ddr_reg[7] ? porta_data_reg[7] : 1'bz);

assign portb_out[0] = (portb_ddr_reg[0] ? portb_data_reg[0] : 1'bz);		// port B outputs
assign portb_out[1] = (portb_ddr_reg[1] ? portb_data_reg[1] : 1'bz);
assign portb_out[2] = (portb_ddr_reg[2] ? portb_data_reg[2] : 1'bz);
assign portb_out[3] = (portb_ddr_reg[3] ? portb_data_reg[3] : 1'bz);
assign portb_out[4] = (portb_ddr_reg[4] ? portb_data_reg[4] : 1'bz);
assign portb_out[5] = (portb_ddr_reg[5] ? portb_data_reg[5] : 1'bz);
assign portb_out[6] = (portb_ddr_reg[6] ? portb_data_reg[6] : 1'bz);
assign portb_out[7] = (portb_ddr_reg[7] ? portb_data_reg[7] : 1'bz);

assign portc_out[0] = (portc_ddr_reg[0] ? portc_data_reg[0] : 1'bz);		// port C outputs
assign portc_out[1] = (portc_ddr_reg[1] ? portc_data_reg[1] : 1'bz);
assign portc_out[2] = (portc_ddr_reg[2] ? portc_data_reg[2] : 1'bz);
assign portc_out[3] = (portc_ddr_reg[3] ? portc_data_reg[3] : 1'bz);
assign portc_out[4] = (portc_ddr_reg[4] ? portc_data_reg[4] : 1'bz);
assign portc_out[5] = (portc_ddr_reg[5] ? portc_data_reg[5] : 1'bz);
assign portc_out[6] = (portc_ddr_reg[6] ? portc_data_reg[6] : 1'bz);
assign portc_out[7] = (portc_ddr_reg[7] ? portc_data_reg[7] : 1'bz);

always @(*)		// databus read
begin
	if(cs_oh & r_w) begin	// read - output with 30ns holdtime
		if(rs == 3'b000)
			data_out = porta_data;			// read port A data reg
		else if(rs == 3'b001)
			data_out = portb_data;			// read port B data reg
		else if(rs == 3'b010)
			data_out = portc_data;			// read port C data reg
		else if(rs == 3'b011)
			data_out = porta_ddr_reg;		// read port A ddr reg
		else if(rs == 3'b100)
			data_out = portb_ddr_reg;		// read port B ddr reg
		else if(rs == 3'b101)
			data_out = portc_ddr_reg;		// read port C ddr reg
		end
	else
		data_out = 8'bz;	// outputs hiz
end
endmodule