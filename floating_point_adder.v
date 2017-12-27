
module fp_adder(a, b, result);

input[31:0] a;
input[31:0] b;
output reg[31:0] result;

reg[7:0] exp_a, exp_b, delta_exp;
reg[23:0] frac_a, frac_b;

reg[7:0] big_exp, final_exp;
reg[23:0] small_frac;
reg[23:0] big_frac;
reg select_exp_frac;
reg[23:0] shifted_small_frac;
reg[24:0] added_fraction;
integer normalize_shift_count,i;

always@(*)
begin
	exp_a = a[30:23];
	exp_b = b[30:23];
	frac_a = a[22:0];
	frac_b = b[22:0];
	frac_a[23] = 1'b1;
	frac_b[23] = 1'b1;
	
	if(exp_a >= exp_b)
	begin	
		delta_exp = exp_a - exp_b;
		select_exp_frac = 0;
	end
	else
	begin
		delta_exp = exp_b - exp_a;
		select_exp_frac = 1;
	end
	
	big_exp = (select_exp_frac)? exp_b : exp_a;
	small_frac = (select_exp_frac)? frac_a : frac_b;
	big_frac = (select_exp_frac)? frac_b : frac_a;
	
	if(delta_exp == 0)
		shifted_small_frac = small_frac;
	else
		shifted_small_frac = small_frac >> delta_exp;
	
	if(a[31] && b[31] == 0)
		added_fraction = shifted_small_frac - big_frac;
	else if(a[31] == 0 && b[31])
		added_fraction = big_frac - shifted_small_frac;
	else
		added_fraction = big_frac + shifted_small_frac;
	
	normalize_shift_count = 0;
	
	if(added_fraction[24] == 0 && added_fraction[23])
	begin
		normalize_shift_count = 0;	
	end
	else if(added_fraction[24])
	begin
		normalize_shift_count = 1;
		added_fraction = added_fraction >> normalize_shift_count;
	end
	else
	begin
		for (i = 22; i >= 0; i = i - 1) begin
            if (added_fraction[i] == 1) begin
                normalize_shift_count = 22 - i + 1;
                i = -1;
            end
        end
		
		added_fraction = added_fraction << normalize_shift_count;
		normalize_shift_count = normalize_shift_count * -1;
	end
	
	// Same numbers (+,-) or (-,+)
	if(added_fraction == 0 && (a[30:0] == b[30:0]))
		normalize_shift_count = -big_exp;
		
	if(shifted_small_frac == 24'd0 && delta_exp > 23)
	begin
		added_fraction = big_frac;
		normalize_shift_count = 0;
	end
	
	final_exp = big_exp + normalize_shift_count;
	
	if (final_exp < 0 || final_exp >= 255)
        $display("Exception");
	else
	begin
		if(shifted_small_frac == 24'd0 && delta_exp > 23)
		begin
			result[31] = select_exp_frac? b[31] : a[31];
		end
		else
			result[31] = added_fraction[22];
			
		result[30:23] = final_exp[7:0];
		result[22:0] = added_fraction;
	end
end

endmodule