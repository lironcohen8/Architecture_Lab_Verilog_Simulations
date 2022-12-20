module parity(clk, in, reset, out);

   input clk, in, reset;
   output out;

   reg 	  out;
   reg 	  state;

   localparam zero=0, one=1;

   always @(posedge clk)
     begin
	if (reset)
	  state <= zero;
	else
	  case (state)
	    0 :
		begin
		    state <= in;
	        end
	    1 :
		begin
		    state <= ~in;
	        end
	    default :
		begin
		    state <= 1;
		end
	  endcase
     end

   always @(state) 
     begin
	case (state)
	    0 :
		begin
		    out <= 0;
	        end
	    1 :
		begin
		    out <= 1;
	        end
	    default :
		begin
		    out <= 1;
		end
	endcase
     end

endmodule
