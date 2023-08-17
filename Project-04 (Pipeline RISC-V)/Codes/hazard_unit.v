module hazard_unit(rs1_d, rs2_d, rd_e, rs1_e, rs2_e, pc_src_e,
    result_src_e_b0, rd_m, reg_write_m, rd_w, reg_write_w,
    stall_f, stall_d, flush_d, flush_e, forward_a_e, forward_b_e);
    input result_src_e_b0, reg_write_m, reg_write_w;
    input [1:0] pc_src_e;
    input [4:0] rs1_d ,rs2_d, rd_e, rs1_e, rs2_e, rd_m, rd_w;
    output stall_f, stall_d, flush_d, flush_e;
    output [1:0] forward_a_e, forward_b_e;
    wire lw_stall;

    assign forward_a_e = (((rs1_e==rd_m) & reg_write_m) &
        (rs1_e!=0)) ? 2'b10 : (((rs1_e==rd_w) &
        reg_write_w) & (rs1_e!=0)) ? 2'b01 : 2'b00;
    assign forward_b_e = (((rs2_e==rd_m) & reg_write_m) &
        (rs2_e!=0)) ? 2'b10 : (((rs2_e==rd_w) &
        reg_write_w) & (rs2_e!=0)) ? 2'b01 : 2'b00;
    assign lw_stall = (((rs1_d==rd_e) | (rs2_d==rd_e)) &
        result_src_e_b0);
    assign stall_f = lw_stall;
    assign stall_d = lw_stall;
    assign flush_d = pc_src_e;
    assign flush_e = (lw_stall | pc_src_e);
    
endmodule