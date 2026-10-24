	.amdgcn_target "amdgcn-amd-amdhsa--gfx1201"
	.amdhsa_code_object_version 6
	.text
	.protected	_Z12k_quant_rectPsiiiiii ; -- Begin function _Z12k_quant_rectPsiiiiii
	.globl	_Z12k_quant_rectPsiiiiii
	.p2align	8
	.type	_Z12k_quant_rectPsiiiiii,@function
_Z12k_quant_rectPsiiiiii:               ; @_Z12k_quant_rectPsiiiiii
; %bb.0:
	s_clause 0x2
	s_load_b32 s8, s[0:1], 0x2c
	s_load_b128 s[4:7], s[0:1], 0x8
	s_load_b64 s[2:3], s[0:1], 0x18
	v_and_b32_e32 v1, 0x3ff, v0
	v_bfe_u32 v2, v0, 10, 10
	s_wait_kmcnt 0x0
	s_lshr_b32 s9, s8, 16
	s_and_b32 s8, s8, 0xffff
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s8, v[1:2]
	v_mad_co_u64_u32 v[1:2], null, ttmp7, s9, v[2:3]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_gt_i32_e32 vcc_lo, s7, v0
	v_cmp_gt_i32_e64 s2, s2, v1
	s_and_b32 s2, vcc_lo, s2
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s7, s2
	s_cbranch_execz .LBB0_2
; %bb.1:
	v_add_nc_u32_e32 v1, s6, v1
	s_load_b64 s[0:1], s[0:1], 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v1, v1, s4
	v_add3_u32 v0, v0, s5, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
	s_wait_kmcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s0, v0
	v_add_co_ci_u32_e64 v1, null, s1, v1, vcc_lo
	s_lshl_b32 s0, -1, s3
	global_load_u16 v2, v[0:1], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_and_b32_e32 v2, s0, v2
	global_store_b16 v[0:1], v2, off
.LBB0_2:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z12k_quant_rectPsiiiiii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 288
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 4
		.amdhsa_next_free_sgpr 10
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 2
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end0:
	.size	_Z12k_quant_rectPsiiiiii, .Lfunc_end0-_Z12k_quant_rectPsiiiiii
                                        ; -- End function
	.set _Z12k_quant_rectPsiiiiii.num_vgpr, 4
	.set _Z12k_quant_rectPsiiiiii.num_agpr, 0
	.set _Z12k_quant_rectPsiiiiii.numbered_sgpr, 10
	.set _Z12k_quant_rectPsiiiiii.num_named_barrier, 0
	.set _Z12k_quant_rectPsiiiiii.private_seg_size, 0
	.set _Z12k_quant_rectPsiiiiii.uses_vcc, 1
	.set _Z12k_quant_rectPsiiiiii.uses_flat_scratch, 0
	.set _Z12k_quant_rectPsiiiiii.has_dyn_sized_stack, 0
	.set _Z12k_quant_rectPsiiiiii.has_recursion, 0
	.set _Z12k_quant_rectPsiiiiii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 224
; TotalNumSgprs: 12
; NumVgprs: 4
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 0
; NumSGPRsForWavesPerEU: 12
; NumVGPRsForWavesPerEU: 4
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.text
	.protected	_Z15k_dwt_fwd_splitPKsPsiiii3sprii ; -- Begin function _Z15k_dwt_fwd_splitPKsPsiiii3sprii
	.globl	_Z15k_dwt_fwd_splitPKsPsiiii3sprii
	.p2align	8
	.type	_Z15k_dwt_fwd_splitPKsPsiiii3sprii,@function
_Z15k_dwt_fwd_splitPKsPsiiii3sprii:     ; @_Z15k_dwt_fwd_splitPKsPsiiii3sprii
; %bb.0:
	s_load_b64 s[2:3], s[0:1], 0x1a0
	s_wait_kmcnt 0x0
	s_cmp_ge_i32 ttmp7, s2
	s_cbranch_scc1 .LBB1_54
; %bb.1:
	s_load_b32 s2, s[0:1], 0x1b4
	s_mov_b32 s4, ttmp7
	s_ashr_i32 s5, ttmp7, 31
	s_delay_alu instid0(SALU_CYCLE_1)
	s_lshl_b64 s[8:9], s[4:5], 2
	s_load_b128 s[4:7], s[0:1], 0x10
	s_add_nc_u64 s[8:9], s[0:1], s[8:9]
	s_load_b32 s10, s[8:9], 0x120
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, 0
	s_cmp_eq_u32 s7, 0
	v_sub_nc_u32_e32 v1, 0, v0
	s_cbranch_scc1 .LBB1_12
; %bb.2:
	s_abs_i32 s7, s10
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_2)
	s_cvt_f32_u32 s11, s7
	s_sub_co_i32 s12, 0, s7
	v_rcp_iflag_f32_e32 v2, s11
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_2)
	v_readfirstlane_b32 s11, v2
	v_max_i32_e32 v2, v0, v1
	s_mul_f32 s11, s11, 0x4f7ffffe
	s_wait_alu 0xfffe
	s_cvt_u32_f32 s11, s11
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_2) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_mul_i32 s12, s12, s11
	s_mul_hi_u32 s12, s11, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	s_add_co_i32 s11, s11, s12
	s_wait_alu 0xfffe
	v_mul_hi_u32 v3, v2, s11
	v_mul_lo_u32 v4, v3, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v2, v2, v4
	v_add_nc_u32_e32 v4, 1, v3
	v_subrev_nc_u32_e32 v5, s7, v2
	v_cmp_le_u32_e32 vcc_lo, s7, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_dual_cndmask_b32 v3, v3, v4 :: v_dual_cndmask_b32 v2, v2, v5
	v_xor_b32_e32 v4, s10, v0
	v_add_nc_u32_e32 v5, 1, v3
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_le_u32_e32 vcc_lo, s7, v2
	v_ashrrev_i32_e32 v4, 31, v4
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v2, v3, v5, vcc_lo
	v_xor_b32_e32 v2, v2, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u32_e32 v2, v2, v4
	v_mul_lo_u32 v3, v2, s10
	s_delay_alu instid0(VALU_DEP_1)
	v_sub_nc_u32_e32 v4, v0, v3
	s_load_b32 s7, s[8:9], 0xa0
	s_and_not1_b32 vcc_lo, exec_lo, s2
	s_wait_alu 0xfffe
	s_cbranch_vccnz .LBB1_4
.LBB1_3:
	s_wait_kmcnt 0x0
	s_abs_i32 s2, s7
	v_max_i32_e32 v1, v0, v1
	s_wait_alu 0xfffe
	s_cvt_f32_u32 s11, s2
	s_sub_co_i32 s12, 0, s2
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v2, s11
	v_readfirstlane_b32 s11, v2
	s_mul_f32 s11, s11, 0x4f7ffffe
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_2)
	s_cvt_u32_f32 s11, s11
	s_wait_alu 0xfffe
	s_mul_i32 s12, s12, s11
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_mul_hi_u32 s12, s11, s12
	s_add_co_i32 s11, s11, s12
	s_wait_alu 0xfffe
	v_mul_hi_u32 v2, v1, s11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v3, v2, s2
	v_sub_nc_u32_e32 v1, v1, v3
	v_add_nc_u32_e32 v3, 1, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_subrev_nc_u32_e32 v4, s2, v1
	v_cmp_le_u32_e32 vcc_lo, s2, v1
	s_wait_alu 0xfffd
	v_dual_cndmask_b32 v2, v2, v3 :: v_dual_cndmask_b32 v1, v1, v4
	v_xor_b32_e32 v3, s7, v0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v4, 1, v2
	v_cmp_le_u32_e32 vcc_lo, s2, v1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_ashrrev_i32_e32 v3, 31, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v1, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v1, v1, v3
	v_sub_nc_u32_e32 v4, v1, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v1, v4, s7
	v_sub_nc_u32_e32 v2, v0, v1
.LBB1_4:
	s_wait_kmcnt 0x0
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, s7, v2
	v_cmp_gt_i32_e64 s2, s10, v4
	s_and_b32 s2, vcc_lo, s2
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s7, s2
	s_cbranch_execz .LBB1_54
; %bb.5:
	s_add_nc_u64 s[8:9], s[8:9], 32
	v_mul_lo_u32 v0, v2, s5
	s_load_b32 s2, s[8:9], 0x0
	s_load_b128 s[12:15], s[0:1], 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64_e32 v[2:3], 1, v[0:1]
	s_wait_kmcnt 0x0
	s_mul_i32 s0, s2, s4
	s_wait_alu 0xfffe
	s_ashr_i32 s1, s0, 31
	s_wait_alu 0xfffe
	s_lshl_b64 s[0:1], s[0:1], 1
	s_cmp_gt_i32 s10, 1
	s_wait_alu 0xfffe
	s_add_nc_u64 s[4:5], s[12:13], s[0:1]
	s_add_nc_u64 s[0:1], s[14:15], s[0:1]
	s_wait_alu 0xfffe
	v_add_co_u32 v0, vcc_lo, s4, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s5, v3, vcc_lo
	v_add_co_u32 v2, vcc_lo, s0, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s1, v3, vcc_lo
	s_mov_b32 s0, -1
	s_cbranch_scc0 .LBB1_52
; %bb.6:
	s_lshr_b32 s0, s10, 31
	s_add_co_i32 s1, s10, 1
	s_wait_alu 0xfffe
	s_add_co_i32 s10, s10, s0
	s_lshr_b32 s0, s1, 31
	s_wait_alu 0xfffe
	s_ashr_i32 s2, s10, 1
	s_add_co_i32 s1, s1, s0
	s_wait_alu 0xfffe
	v_cmp_gt_i32_e64 s0, s2, v4
	s_ashr_i32 s1, s1, 1
	s_cmp_eq_u32 s3, 0
	s_cbranch_scc1 .LBB1_13
; %bb.7:
	v_mov_b32_e32 v5, 0
	s_and_saveexec_b32 s3, s0
	s_cbranch_execz .LBB1_9
; %bb.8:
	v_mul_lo_u32 v5, v4, s6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 1, v5
	v_add_nc_u32_e32 v7, s6, v5
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v8, 31, v7
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[7:8], 1, v[7:8]
	v_add_co_u32 v5, vcc_lo, v0, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v6, null, v1, v6, vcc_lo
	v_add_co_u32 v7, vcc_lo, v0, v7
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, v1, v8, vcc_lo
	s_clause 0x1
	global_load_i16 v9, v[5:6], off
	global_load_i16 v7, v[7:8], off
	s_wait_alu 0xfffe
	v_add_nc_u32_e32 v5, s1, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v5, v5, s6
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	s_wait_loadcnt 0x0
	v_sub_nc_u32_e32 v9, v7, v9
	v_add_co_u32 v7, vcc_lo, v2, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v8, null, v3, v6, vcc_lo
	v_lshrrev_b32_e32 v5, 1, v9
	global_store_b16 v[7:8], v9, off
.LBB1_9:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_mov_b32 s3, exec_lo
	v_cmpx_gt_i32_e64 s1, v4
	s_cbranch_execz .LBB1_11
; %bb.10:
	v_mul_lo_u32 v6, v4, s6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v7, 1, v6
	v_ashrrev_i32_e32 v8, 31, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[7:8], 1, v[7:8]
	v_add_co_u32 v7, vcc_lo, v0, v7
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v8, null, v1, v8, vcc_lo
	global_load_u16 v8, v[7:8], off
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64_e32 v[6:7], 1, v[6:7]
	s_wait_loadcnt 0x0
	v_add_nc_u16 v8, v8, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v5, vcc_lo, v2, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v3, v7, vcc_lo
	global_store_b16 v[5:6], v8, off
.LBB1_11:                               ; %Flow
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	s_branch .LBB1_51
.LBB1_12:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr4
	s_load_b32 s7, s[8:9], 0xa0
	s_branch .LBB1_3
.LBB1_13:
	s_cbranch_execz .LBB1_51
; %bb.14:
	s_and_saveexec_b32 s3, s0
	s_cbranch_execz .LBB1_24
; %bb.15:
	v_mov_b32_e32 v5, v4
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_le_u32_e64 s1, v4
	s_cbranch_execz .LBB1_19
; %bb.16:                               ; %.lr.ph.i.i
	v_mov_b32_e32 v5, v4
	s_lshl_b32 s5, s1, 1
	s_mov_b32 s4, 0
.LBB1_17:                               ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, -1, v5
	s_wait_alu 0xfffc
	v_cndmask_b32_e64 v6, 0, s5, vcc_lo
	v_xad_u32 v5, v5, -1, v6
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_u32_e32 vcc_lo, s1, v5
	s_or_b32 s4, vcc_lo, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB1_17
; %bb.18:                               ; %Flow179
	s_or_b32 exec_lo, exec_lo, s4
.LBB1_19:                               ; %Flow180
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	s_or_b32 exec_lo, exec_lo, s0
	s_lshl_b32 s0, s6, 1
	v_cmp_gt_i32_e64 s5, -1, v4
	s_wait_alu 0xfffe
	v_mul_lo_u32 v5, v5, s0
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	v_add_co_u32 v5, vcc_lo, v0, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v6, null, v1, v6, vcc_lo
	global_load_u16 v5, v[5:6], off
	v_add_nc_u32_e32 v6, 1, v4
	v_cmp_le_i32_e32 vcc_lo, s1, v6
	s_or_b32 s7, s5, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s4, s7
	s_cbranch_execz .LBB1_23
; %bb.20:                               ; %.lr.ph.i13.i
	s_lshl_b32 s8, s1, 1
	s_mov_b32 s7, 0
.LBB1_21:                               ; =>This Inner Loop Header: Depth=1
	v_cndmask_b32_e64 v7, s8, 0, s5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v6, v6, -1, v7
	v_cmp_gt_u32_e32 vcc_lo, s1, v6
	v_cmp_gt_i32_e64 s5, 0, v6
	s_wait_alu 0xfffe
	s_or_b32 s7, vcc_lo, s7
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB1_21
; %bb.22:                               ; %Flow177
	s_or_b32 exec_lo, exec_lo, s7
.LBB1_23:                               ; %Flow178
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	v_mul_lo_u32 v6, v6, s0
	v_lshl_or_b32 v8, v4, 1, 1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v8, v8, s6
	v_ashrrev_i32_e32 v7, 31, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b64_e32 v[6:7], 1, v[6:7]
	v_ashrrev_i32_e32 v9, 31, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v6, vcc_lo, v0, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v1, v7, vcc_lo
	global_load_u16 v10, v[6:7], off
	v_lshlrev_b64_e32 v[6:7], 1, v[8:9]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v6, vcc_lo, v0, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v1, v7, vcc_lo
	global_load_u16 v8, v[6:7], off
	v_add_nc_u32_e32 v6, s1, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v6, v6, s6
	s_wait_loadcnt 0x1
	v_xor_b32_e32 v7, v10, v5
	v_and_b32_e32 v5, v10, v5
	v_ashrrev_i16 v9, 1, v7
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v7, 31, v6
	v_add_nc_u16 v9, v5, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[5:6], 1, v[6:7]
	s_wait_loadcnt 0x0
	v_sub_nc_u16 v7, v8, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v5, vcc_lo, v2, v5
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v3, v6, vcc_lo
	global_store_b16 v[5:6], v7, off
.LBB1_24:                               ; %Flow181
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_mov_b32 s0, exec_lo
	v_cmpx_gt_i32_e64 s1, v4
	s_cbranch_execz .LBB1_50
; %bb.25:
	v_cmp_gt_i32_e64 s4, 1, v4
	v_cmp_lt_i32_e32 vcc_lo, s2, v4
	v_add_nc_u32_e32 v6, -1, v4
	s_or_b32 s5, s4, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s3, s5
	s_cbranch_execz .LBB1_29
; %bb.26:                               ; %.lr.ph.i
	s_lshl_b32 s7, s2, 1
	s_mov_b32 s5, 0
.LBB1_27:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v5, s7, 0, s4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v6, v6, -1, v5
	v_cmp_gt_u32_e32 vcc_lo, s2, v6
	v_cmp_gt_i32_e64 s4, 0, v6
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_27
; %bb.28:                               ; %Flow174
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_29:                               ; %Flow175
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_mov_b32_e32 v5, v6
	s_mov_b32 s3, exec_lo
	v_cmpx_le_i32_e64 s1, v6
	s_cbranch_execz .LBB1_33
; %bb.30:                               ; %.lr.ph.i.i106
	v_mov_b32_e32 v5, v6
	s_lshl_b32 s4, s1, 1
	s_mov_b32 s7, 0
	s_mov_b32 s5, 0
.LBB1_31:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v7, s4, 0, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v5, v5, -1, v7
	v_cmp_gt_u32_e32 vcc_lo, s1, v5
	v_cmp_gt_i32_e64 s7, 0, v5
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_31
; %bb.32:                               ; %Flow172
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_33:                               ; %Flow173
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	s_lshl_b32 s3, s6, 1
	s_mov_b32 s4, exec_lo
	s_wait_alu 0xfffe
	v_mul_lo_u32 v7, v5, s3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v8, 31, v7
	v_lshlrev_b64_e32 v[7:8], 1, v[7:8]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v7, vcc_lo, v0, v7
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, v1, v8, vcc_lo
	global_load_u16 v5, v[7:8], off
	v_add_nc_u32_e32 v7, 1, v6
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_le_i32_e64 s1, v7
	s_cbranch_execz .LBB1_37
; %bb.34:                               ; %.lr.ph.i13.i103
	s_lshl_b32 s5, s1, 1
	s_mov_b32 s8, 0
	s_mov_b32 s7, 0
.LBB1_35:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v8, s5, 0, s8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v7, v7, -1, v8
	v_cmp_gt_u32_e32 vcc_lo, s1, v7
	v_cmp_gt_i32_e64 s8, 0, v7
	s_or_b32 s7, vcc_lo, s7
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB1_35
; %bb.36:                               ; %Flow170
	s_or_b32 exec_lo, exec_lo, s7
.LBB1_37:                               ; %Flow171
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	s_or_b32 exec_lo, exec_lo, s4
	v_lshl_or_b32 v8, v6, 1, 1
	v_mul_lo_u32 v6, v7, s3
	s_mov_b32 s4, exec_lo
	v_mul_lo_u32 v8, v8, s6
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v7, 31, v6
	v_ashrrev_i32_e32 v9, 31, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[6:7], 1, v[6:7]
	v_lshlrev_b64_e32 v[8:9], 1, v[8:9]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v6, vcc_lo, v0, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v1, v7, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v0, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, v1, v9, vcc_lo
	s_clause 0x1
	global_load_u16 v7, v[6:7], off
	global_load_u16 v6, v[8:9], off
	v_mov_b32_e32 v8, v4
	v_cmpx_le_u32_e64 s2, v4
	s_cbranch_execz .LBB1_41
; %bb.38:                               ; %.lr.ph.i111
	v_mov_b32_e32 v8, v4
	s_lshl_b32 s7, s2, 1
	s_mov_b32 s5, 0
.LBB1_39:                               ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, -1, v8
	s_wait_alu 0xfffc
	v_cndmask_b32_e64 v9, 0, s7, vcc_lo
	v_xad_u32 v8, v8, -1, v9
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_u32_e32 vcc_lo, s2, v8
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_39
; %bb.40:                               ; %Flow168
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_41:                               ; %Flow169
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	v_mov_b32_e32 v9, v8
	s_mov_b32 s2, exec_lo
	v_cmpx_le_i32_e64 s1, v8
	s_cbranch_execz .LBB1_45
; %bb.42:                               ; %.lr.ph.i.i121
	v_mov_b32_e32 v9, v8
	s_lshl_b32 s4, s1, 1
	s_mov_b32 s7, 0
	s_mov_b32 s5, 0
.LBB1_43:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v10, s4, 0, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v9, v9, -1, v10
	v_cmp_gt_u32_e32 vcc_lo, s1, v9
	v_cmp_gt_i32_e64 s7, 0, v9
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_43
; %bb.44:                               ; %Flow166
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_45:                               ; %Flow167
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	v_mul_lo_u32 v9, v9, s3
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v10, 31, v9
	v_lshlrev_b64_e32 v[9:10], 1, v[9:10]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v9, vcc_lo, v0, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v10, null, v1, v10, vcc_lo
	global_load_u16 v9, v[9:10], off
	v_add_nc_u32_e32 v10, 1, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_le_i32_e64 s1, v10
	s_cbranch_execz .LBB1_49
; %bb.46:                               ; %.lr.ph.i13.i118
	s_lshl_b32 s4, s1, 1
	s_mov_b32 s7, 0
	s_mov_b32 s5, 0
.LBB1_47:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v11, s4, 0, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v10, v10, -1, v11
	v_cmp_gt_u32_e32 vcc_lo, s1, v10
	v_cmp_gt_i32_e64 s7, 0, v10
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_47
; %bb.48:                               ; %Flow164
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_49:                               ; %Flow165
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	v_mul_lo_u32 v10, v10, s3
	v_lshl_or_b32 v8, v8, 1, 1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v12, v8, s6
	v_ashrrev_i32_e32 v11, 31, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b64_e32 v[10:11], 1, v[10:11]
	v_ashrrev_i32_e32 v13, 31, v12
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v10, vcc_lo, v0, v10
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, v1, v11, vcc_lo
	global_load_u16 v8, v[10:11], off
	v_lshlrev_b64_e32 v[10:11], 1, v[12:13]
	v_mul_lo_u32 v12, s3, v4
	v_mul_lo_u32 v4, v4, s6
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_add_co_u32 v10, vcc_lo, v0, v10
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, v1, v11, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v13, 31, v12
	global_load_u16 v14, v[10:11], off
	v_lshlrev_b64_e32 v[10:11], 1, v[12:13]
	v_add_co_u32 v10, vcc_lo, v0, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, v1, v11, vcc_lo
	global_load_u16 v10, v[10:11], off
	s_wait_loadcnt 0x5
	v_xor_b32_e32 v11, v7, v5
	v_and_b32_e32 v5, v7, v5
	v_ashrrev_i16 v7, 1, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u16 v5, v5, v7
	s_wait_loadcnt 0x4
	v_sub_nc_u16 v5, v6, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_bfe_i32 v5, v5, 0, 16
	s_wait_loadcnt 0x2
	v_xor_b32_e32 v12, v8, v9
	v_and_b32_e32 v8, v8, v9
	v_ashrrev_i16 v9, 1, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u16 v7, v8, v9
	s_wait_loadcnt 0x1
	v_sub_nc_u16 v6, v14, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bfe_i32 v6, v6, 0, 16
	v_add3_u32 v6, v5, v6, 2
	v_ashrrev_i32_e32 v5, 31, v4
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v6, 2, v6
	v_lshlrev_b64_e32 v[4:5], 1, v[4:5]
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u16 v6, v10, v6
	v_add_co_u32 v4, vcc_lo, v2, v4
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_ci_u32_e64 v5, null, v3, v5, vcc_lo
	global_store_b16 v[4:5], v6, off
.LBB1_50:                               ; %Flow176
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
.LBB1_51:                               ; %Flow183
	s_mov_b32 s0, 0
.LBB1_52:                               ; %Flow184
	s_wait_alu 0xfffe
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_wait_alu 0xfffe
	s_cbranch_vccnz .LBB1_54
; %bb.53:
	global_load_u16 v0, v[0:1], off
	s_wait_loadcnt 0x0
	global_store_b16 v[2:3], v0, off
.LBB1_54:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z15k_dwt_fwd_splitPKsPsiiii3sprii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 680
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 15
		.amdhsa_next_free_sgpr 16
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 23
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end1:
	.size	_Z15k_dwt_fwd_splitPKsPsiiii3sprii, .Lfunc_end1-_Z15k_dwt_fwd_splitPKsPsiiii3sprii
                                        ; -- End function
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.num_vgpr, 15
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.num_agpr, 0
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.numbered_sgpr, 16
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.num_named_barrier, 0
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.private_seg_size, 0
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.uses_vcc, 1
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.uses_flat_scratch, 0
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.has_dyn_sized_stack, 0
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.has_recursion, 0
	.set _Z15k_dwt_fwd_splitPKsPsiiii3sprii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 2920
; TotalNumSgprs: 18
; NumVgprs: 15
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 15
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z15k_dwt_inv_splitPKsPsiiii3sprii ; -- Begin function _Z15k_dwt_inv_splitPKsPsiiii3sprii
	.globl	_Z15k_dwt_inv_splitPKsPsiiii3sprii
	.p2align	8
	.type	_Z15k_dwt_inv_splitPKsPsiiii3sprii,@function
_Z15k_dwt_inv_splitPKsPsiiii3sprii:     ; @_Z15k_dwt_inv_splitPKsPsiiii3sprii
; %bb.0:
	s_load_b64 s[2:3], s[0:1], 0x1a0
	s_wait_kmcnt 0x0
	s_cmp_ge_i32 ttmp7, s2
	s_cbranch_scc1 .LBB2_56
; %bb.1:
	s_load_b32 s2, s[0:1], 0x1b4
	s_mov_b32 s4, ttmp7
	s_ashr_i32 s5, ttmp7, 31
	s_delay_alu instid0(SALU_CYCLE_1)
	s_lshl_b64 s[8:9], s[4:5], 2
	s_load_b128 s[4:7], s[0:1], 0x10
	s_add_nc_u64 s[8:9], s[0:1], s[8:9]
	s_load_b32 s10, s[8:9], 0x120
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, 0
	s_cmp_eq_u32 s7, 0
	v_sub_nc_u32_e32 v1, 0, v0
	s_cbranch_scc1 .LBB2_14
; %bb.2:
	s_abs_i32 s7, s10
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_2)
	s_cvt_f32_u32 s11, s7
	s_sub_co_i32 s12, 0, s7
	v_rcp_iflag_f32_e32 v2, s11
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_2)
	v_readfirstlane_b32 s11, v2
	v_max_i32_e32 v2, v0, v1
	s_mul_f32 s11, s11, 0x4f7ffffe
	s_wait_alu 0xfffe
	s_cvt_u32_f32 s11, s11
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_2) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_mul_i32 s12, s12, s11
	s_mul_hi_u32 s12, s11, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	s_add_co_i32 s11, s11, s12
	s_wait_alu 0xfffe
	v_mul_hi_u32 v3, v2, s11
	v_mul_lo_u32 v4, v3, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v2, v2, v4
	v_add_nc_u32_e32 v4, 1, v3
	v_subrev_nc_u32_e32 v5, s7, v2
	v_cmp_le_u32_e32 vcc_lo, s7, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_dual_cndmask_b32 v3, v3, v4 :: v_dual_cndmask_b32 v2, v2, v5
	v_xor_b32_e32 v4, s10, v0
	v_add_nc_u32_e32 v5, 1, v3
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_le_u32_e32 vcc_lo, s7, v2
	v_ashrrev_i32_e32 v4, 31, v4
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v2, v3, v5, vcc_lo
	v_xor_b32_e32 v2, v2, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u32_e32 v2, v2, v4
	v_mul_lo_u32 v3, v2, s10
	s_delay_alu instid0(VALU_DEP_1)
	v_sub_nc_u32_e32 v4, v0, v3
	s_load_b32 s7, s[8:9], 0xa0
	s_and_not1_b32 vcc_lo, exec_lo, s2
	s_wait_alu 0xfffe
	s_cbranch_vccnz .LBB2_4
.LBB2_3:
	s_wait_kmcnt 0x0
	s_abs_i32 s2, s7
	v_max_i32_e32 v1, v0, v1
	s_wait_alu 0xfffe
	s_cvt_f32_u32 s11, s2
	s_sub_co_i32 s12, 0, s2
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v2, s11
	v_readfirstlane_b32 s11, v2
	s_mul_f32 s11, s11, 0x4f7ffffe
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_2)
	s_cvt_u32_f32 s11, s11
	s_wait_alu 0xfffe
	s_mul_i32 s12, s12, s11
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_mul_hi_u32 s12, s11, s12
	s_add_co_i32 s11, s11, s12
	s_wait_alu 0xfffe
	v_mul_hi_u32 v2, v1, s11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v3, v2, s2
	v_sub_nc_u32_e32 v1, v1, v3
	v_add_nc_u32_e32 v3, 1, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_subrev_nc_u32_e32 v4, s2, v1
	v_cmp_le_u32_e32 vcc_lo, s2, v1
	s_wait_alu 0xfffd
	v_dual_cndmask_b32 v2, v2, v3 :: v_dual_cndmask_b32 v1, v1, v4
	v_xor_b32_e32 v3, s7, v0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v4, 1, v2
	v_cmp_le_u32_e32 vcc_lo, s2, v1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_ashrrev_i32_e32 v3, 31, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v1, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v1, v1, v3
	v_sub_nc_u32_e32 v4, v1, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v1, v4, s7
	v_sub_nc_u32_e32 v2, v0, v1
.LBB2_4:
	s_wait_kmcnt 0x0
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, s7, v2
	v_cmp_gt_i32_e64 s2, s10, v4
	s_and_b32 s2, vcc_lo, s2
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s7, s2
	s_cbranch_execz .LBB2_56
; %bb.5:
	s_add_nc_u64 s[8:9], s[8:9], 32
	v_mul_lo_u32 v0, v2, s5
	s_load_b32 s2, s[8:9], 0x0
	s_load_b128 s[12:15], s[0:1], 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64_e32 v[2:3], 1, v[0:1]
	s_wait_kmcnt 0x0
	s_mul_i32 s0, s2, s4
	s_wait_alu 0xfffe
	s_ashr_i32 s1, s0, 31
	s_wait_alu 0xfffe
	s_lshl_b64 s[0:1], s[0:1], 1
	s_cmp_gt_i32 s10, 1
	s_wait_alu 0xfffe
	s_add_nc_u64 s[4:5], s[12:13], s[0:1]
	s_add_nc_u64 s[0:1], s[14:15], s[0:1]
	s_wait_alu 0xfffe
	v_add_co_u32 v0, vcc_lo, s4, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s5, v3, vcc_lo
	v_add_co_u32 v2, vcc_lo, s0, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s1, v3, vcc_lo
	s_mov_b32 s0, -1
	s_cbranch_scc0 .LBB2_54
; %bb.6:
	s_add_co_i32 s0, s10, 1
	s_lshr_b32 s2, s10, 31
	s_wait_alu 0xfffe
	s_lshr_b32 s1, s0, 31
	s_add_co_i32 s10, s10, s2
	s_wait_alu 0xfffe
	s_add_co_i32 s0, s0, s1
	s_ashr_i32 s1, s10, 1
	s_wait_alu 0xfffe
	s_ashr_i32 s0, s0, 1
	s_cmp_eq_u32 s3, 0
	s_cbranch_scc1 .LBB2_15
; %bb.7:
	s_mov_b32 s2, exec_lo
	v_cmpx_le_i32_e64 s1, v4
	s_wait_alu 0xfffe
	s_xor_b32 s2, exec_lo, s2
	s_cbranch_execz .LBB2_11
; %bb.8:
	s_mov_b32 s3, exec_lo
	v_cmpx_gt_i32_e64 s0, v4
	s_cbranch_execz .LBB2_10
; %bb.9:
	v_mul_lo_u32 v5, v4, s6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64_e32 v[6:7], 1, v[5:6]
	v_lshlrev_b32_e32 v5, 1, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v6, vcc_lo, v0, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v1, v7, vcc_lo
	global_load_u16 v7, v[6:7], off
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	v_add_co_u32 v5, vcc_lo, v2, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v6, null, v3, v6, vcc_lo
	s_wait_loadcnt 0x0
	global_store_b16 v[5:6], v7, off
.LBB2_10:                               ; %Flow
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
.LBB2_11:                               ; %Flow166
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s2, s2
	s_cbranch_execz .LBB2_13
; %bb.12:
	v_add_nc_u32_e32 v5, s0, v4
	v_mul_lo_u32 v7, v4, s6
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v5, v5, s6
	v_ashrrev_i32_e32 v8, 31, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64_e32 v[8:9], 1, v[7:8]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	v_add_co_u32 v5, vcc_lo, v0, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_co_ci_u32_e64 v6, null, v1, v6, vcc_lo
	v_add_co_u32 v8, vcc_lo, v0, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, v1, v9, vcc_lo
	s_clause 0x1
	global_load_u16 v10, v[5:6], off
	global_load_u16 v9, v[8:9], off
	v_lshlrev_b32_e32 v5, 1, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v7, s6, v5
	v_ashrrev_i32_e32 v6, 31, v5
	v_ashrrev_i32_e32 v8, 31, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	v_lshlrev_b64_e32 v[7:8], 1, v[7:8]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v5, vcc_lo, v2, v5
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v3, v6, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_u32 v7, vcc_lo, v2, v7
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, v3, v8, vcc_lo
	s_wait_loadcnt 0x1
	v_ashrrev_i16 v11, 1, v10
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u16 v9, v9, v11
	v_add_nc_u16 v10, v9, v10
	s_clause 0x1
	global_store_b16 v[5:6], v9, off
	global_store_b16 v[7:8], v10, off
.LBB2_13:                               ; %Flow167
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB2_16
	s_branch .LBB2_53
.LBB2_14:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr4
	s_load_b32 s7, s[8:9], 0xa0
	s_branch .LBB2_3
.LBB2_15:
.LBB2_16:
	s_mov_b32 s2, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_gt_i32_e64 s0, v4
	s_cbranch_execz .LBB2_26
; %bb.17:
	v_cmp_gt_i32_e64 s4, 1, v4
	v_cmp_lt_i32_e32 vcc_lo, s1, v4
	v_add_nc_u32_e32 v5, -1, v4
	s_or_b32 s5, s4, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s3, s5
	s_cbranch_execz .LBB2_21
; %bb.18:                               ; %.lr.ph.i.i
	s_lshl_b32 s7, s1, 1
	s_mov_b32 s5, 0
.LBB2_19:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v6, s7, 0, s4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v5, v5, -1, v6
	v_cmp_gt_u32_e32 vcc_lo, s1, v5
	v_cmp_gt_i32_e64 s4, 0, v5
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB2_19
; %bb.20:                               ; %Flow183
	s_or_b32 exec_lo, exec_lo, s5
.LBB2_21:                               ; %Flow184
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v5, s0, v5
	s_mov_b32 s3, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v5, v5, s6
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	v_add_co_u32 v5, vcc_lo, v0, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v6, null, v1, v6, vcc_lo
	global_load_u16 v5, v[5:6], off
	v_mov_b32_e32 v6, v4
	v_cmpx_le_u32_e64 s1, v4
	s_cbranch_execz .LBB2_25
; %bb.22:                               ; %.lr.ph.i15.i
	v_mov_b32_e32 v6, v4
	s_lshl_b32 s5, s1, 1
	s_mov_b32 s4, 0
.LBB2_23:                               ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, -1, v6
	s_wait_alu 0xfffc
	v_cndmask_b32_e64 v7, 0, s5, vcc_lo
	v_xad_u32 v6, v6, -1, v7
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_u32_e32 vcc_lo, s1, v6
	s_or_b32 s4, vcc_lo, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB2_23
; %bb.24:                               ; %Flow181
	s_or_b32 exec_lo, exec_lo, s4
.LBB2_25:                               ; %Flow182
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v6, s0, v6
	v_mul_lo_u32 v8, v4, s6
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v6, v6, s6
	v_ashrrev_i32_e32 v9, 31, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64_e32 v[9:10], 1, v[8:9]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[6:7], 1, v[6:7]
	v_add_co_u32 v6, vcc_lo, v0, v6
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v1, v7, vcc_lo
	global_load_i16 v11, v[6:7], off
	v_add_co_u32 v6, vcc_lo, v0, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v1, v10, vcc_lo
	global_load_u16 v7, v[6:7], off
	s_wait_loadcnt 0x2
	v_bfe_i32 v6, v5, 0, 16
	v_lshlrev_b32_e32 v5, 1, v8
	s_wait_loadcnt 0x1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add3_u32 v8, v6, v11, 2
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v8, 2, v8
	v_lshlrev_b64_e32 v[5:6], 1, v[5:6]
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_sub_nc_u16 v7, v7, v8
	v_add_co_u32 v5, vcc_lo, v2, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_ci_u32_e64 v6, null, v3, v6, vcc_lo
	global_store_b16 v[5:6], v7, off
.LBB2_26:                               ; %Flow185
	s_or_b32 exec_lo, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s1, v4
	s_cbranch_execz .LBB2_52
; %bb.27:
	v_mov_b32_e32 v6, v4
	s_mov_b32 s3, exec_lo
	v_cmpx_le_u32_e64 s0, v4
	s_cbranch_execz .LBB2_31
; %bb.28:                               ; %.lr.ph.i
	v_mov_b32_e32 v6, v4
	s_lshl_b32 s5, s0, 1
	s_mov_b32 s4, 0
.LBB2_29:                               ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, -1, v6
	s_wait_alu 0xfffc
	v_cndmask_b32_e64 v5, 0, s5, vcc_lo
	v_xad_u32 v6, v6, -1, v5
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_u32_e32 vcc_lo, s0, v6
	s_or_b32 s4, vcc_lo, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB2_29
; %bb.30:                               ; %Flow178
	s_or_b32 exec_lo, exec_lo, s4
.LBB2_31:                               ; %Flow179
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_cmp_lt_i32_e32 vcc_lo, s1, v6
	v_sub_co_u32 v5, s4, v6, 1
	s_or_b32 s5, s4, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s3, s5
	s_cbranch_execz .LBB2_35
; %bb.32:                               ; %.lr.ph.i.i111
	s_lshl_b32 s7, s1, 1
	s_mov_b32 s5, 0
.LBB2_33:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v7, s7, 0, s4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v5, v5, -1, v7
	v_cmp_gt_u32_e32 vcc_lo, s1, v5
	v_cmp_gt_i32_e64 s4, 0, v5
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB2_33
; %bb.34:                               ; %Flow176
	s_or_b32 exec_lo, exec_lo, s5
.LBB2_35:                               ; %Flow177
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v5, s0, v5
	s_mov_b32 s3, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v7, v5, s6
	v_ashrrev_i32_e32 v8, 31, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[7:8], 1, v[7:8]
	v_add_co_u32 v7, vcc_lo, v0, v7
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v8, null, v1, v8, vcc_lo
	global_load_u16 v5, v[7:8], off
	v_mov_b32_e32 v7, v6
	v_cmpx_le_i32_e64 s1, v6
	s_cbranch_execz .LBB2_39
; %bb.36:                               ; %.lr.ph.i15.i108
	v_mov_b32_e32 v7, v6
	s_lshl_b32 s4, s1, 1
	s_mov_b32 s7, 0
	s_mov_b32 s5, 0
.LBB2_37:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v8, s4, 0, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v7, v7, -1, v8
	v_cmp_gt_u32_e32 vcc_lo, s1, v7
	v_cmp_gt_i32_e64 s7, 0, v7
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB2_37
; %bb.38:                               ; %Flow174
	s_or_b32 exec_lo, exec_lo, s5
.LBB2_39:                               ; %Flow175
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v7, s0, v7
	v_mul_lo_u32 v9, v6, s6
	v_cmp_gt_i32_e64 s4, -1, v4
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v7, v7, s6
	v_ashrrev_i32_e32 v10, 31, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v8, 31, v7
	v_lshlrev_b64_e32 v[6:7], 1, v[7:8]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[8:9], 1, v[9:10]
	v_add_co_u32 v6, vcc_lo, v0, v6
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v1, v7, vcc_lo
	v_add_co_u32 v8, vcc_lo, v0, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, v1, v9, vcc_lo
	s_clause 0x1
	global_load_u16 v7, v[6:7], off
	global_load_u16 v6, v[8:9], off
	v_add_nc_u32_e32 v8, 1, v4
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_le_i32_e32 vcc_lo, s0, v8
	s_or_b32 s5, s4, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s3, s5
	s_cbranch_execz .LBB2_43
; %bb.40:                               ; %.lr.ph.i116
	s_lshl_b32 s7, s0, 1
	s_mov_b32 s5, 0
.LBB2_41:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v9, s7, 0, s4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v8, v8, -1, v9
	v_cmp_gt_u32_e32 vcc_lo, s0, v8
	v_cmp_gt_i32_e64 s4, 0, v8
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB2_41
; %bb.42:                               ; %Flow172
	s_or_b32 exec_lo, exec_lo, s5
.LBB2_43:                               ; %Flow173
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_cmp_lt_i32_e32 vcc_lo, s1, v8
	v_sub_co_u32 v9, s4, v8, 1
	s_or_b32 s5, s4, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s3, s5
	s_cbranch_execz .LBB2_47
; %bb.44:                               ; %.lr.ph.i.i126
	s_lshl_b32 s7, s1, 1
	s_mov_b32 s5, 0
.LBB2_45:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v10, s7, 0, s4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v9, v9, -1, v10
	v_cmp_gt_u32_e32 vcc_lo, s1, v9
	v_cmp_gt_i32_e64 s4, 0, v9
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB2_45
; %bb.46:                               ; %Flow170
	s_or_b32 exec_lo, exec_lo, s5
.LBB2_47:                               ; %Flow171
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v9, s0, v9
	s_mov_b32 s3, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v9, v9, s6
	v_ashrrev_i32_e32 v10, 31, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[9:10], 1, v[9:10]
	v_add_co_u32 v9, vcc_lo, v0, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v10, null, v1, v10, vcc_lo
	global_load_u16 v9, v[9:10], off
	v_mov_b32_e32 v10, v8
	v_cmpx_le_i32_e64 s1, v8
	s_cbranch_execz .LBB2_51
; %bb.48:                               ; %.lr.ph.i15.i123
	v_mov_b32_e32 v10, v8
	s_lshl_b32 s4, s1, 1
	s_mov_b32 s7, 0
	s_mov_b32 s5, 0
.LBB2_49:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v11, s4, 0, s7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xad_u32 v10, v10, -1, v11
	v_cmp_gt_u32_e32 vcc_lo, s1, v10
	v_cmp_gt_i32_e64 s7, 0, v10
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB2_49
; %bb.50:                               ; %Flow168
	s_or_b32 exec_lo, exec_lo, s5
.LBB2_51:                               ; %Flow169
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v10, s0, v10
	v_mul_lo_u32 v12, v8, s6
	v_add_nc_u32_e32 v8, s0, v4
	s_wait_loadcnt 0x3
	v_bfe_i32 v5, v5, 0, 16
	s_wait_loadcnt 0x2
	v_bfe_i32 v7, v7, 0, 16
	v_mul_lo_u32 v10, v10, s6
	s_wait_loadcnt 0x0
	v_bfe_i32 v9, v9, 0, 16
	v_lshl_or_b32 v4, v4, 1, 1
	v_ashrrev_i32_e32 v13, 31, v12
	v_add3_u32 v5, v5, v7, 2
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v4, v4, s6
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64_e32 v[12:13], 1, v[12:13]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v5, 2, v5
	v_lshlrev_b64_e32 v[10:11], 1, v[10:11]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_sub_nc_u16 v5, v6, v5
	v_add_co_u32 v10, vcc_lo, v0, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_ci_u32_e64 v11, null, v1, v11, vcc_lo
	global_load_i16 v14, v[10:11], off
	v_add_co_u32 v11, vcc_lo, v0, v12
	v_mul_lo_u32 v10, v8, s6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v12, null, v1, v13, vcc_lo
	global_load_u16 v8, v[11:12], off
	v_ashrrev_i32_e32 v11, 31, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[10:11], 1, v[10:11]
	v_add_co_u32 v10, vcc_lo, v0, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v11, null, v1, v11, vcc_lo
	global_load_u16 v10, v[10:11], off
	s_wait_loadcnt 0x2
	v_add3_u32 v7, v9, v14, 2
	v_lshrrev_b32_e32 v7, 2, v7
	s_wait_loadcnt 0x1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u16 v6, v8, v7
	v_xor_b32_e32 v7, v6, v5
	v_and_b32_e32 v6, v6, v5
	v_ashrrev_i32_e32 v5, 31, v4
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i16 v7, 1, v7
	v_lshlrev_b64_e32 v[4:5], 1, v[4:5]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u16 v6, v6, v7
	v_add_co_u32 v4, vcc_lo, v2, v4
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_2)
	v_add_nc_u16 v6, v10, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, v3, v5, vcc_lo
	global_store_b16 v[4:5], v6, off
.LBB2_52:                               ; %Flow180
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
.LBB2_53:                               ; %Flow187
	s_mov_b32 s0, 0
.LBB2_54:                               ; %Flow188
	s_wait_alu 0xfffe
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_wait_alu 0xfffe
	s_cbranch_vccnz .LBB2_56
; %bb.55:
	global_load_u16 v0, v[0:1], off
	s_wait_loadcnt 0x0
	global_store_b16 v[2:3], v0, off
.LBB2_56:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z15k_dwt_inv_splitPKsPsiiii3sprii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 680
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 15
		.amdhsa_next_free_sgpr 16
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 24
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end2:
	.size	_Z15k_dwt_inv_splitPKsPsiiii3sprii, .Lfunc_end2-_Z15k_dwt_inv_splitPKsPsiiii3sprii
                                        ; -- End function
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.num_vgpr, 15
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.num_agpr, 0
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.numbered_sgpr, 16
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.num_named_barrier, 0
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.private_seg_size, 0
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.uses_vcc, 1
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.uses_flat_scratch, 0
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.has_dyn_sized_stack, 0
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.has_recursion, 0
	.set _Z15k_dwt_inv_splitPKsPsiiii3sprii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 2988
; TotalNumSgprs: 18
; NumVgprs: 15
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 15
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji ; -- Begin function _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
	.globl	_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
	.p2align	8
	.type	_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji,@function
_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji: ; @_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x5c
	s_load_b32 s3, s[0:1], 0x48
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[2:3], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v2
	s_cbranch_execz .LBB3_14
; %bb.1:
	s_load_b64 s[2:3], s[0:1], 0x18
	v_ashrrev_i32_e32 v3, 31, v2
	s_mov_b32 s4, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[0:1], 2, v[2:3]
	s_wait_kmcnt 0x0
	v_add_co_u32 v4, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v5, null, s3, v1, vcc_lo
	s_load_b64 s[2:3], s[0:1], 0x40
	global_load_b32 v8, v[4:5], off
	v_mov_b32_e32 v5, 0
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v8
	s_cbranch_execz .LBB3_13
; %bb.2:
	s_clause 0x1
	s_load_b256 s[8:15], s[0:1], 0x20
	s_load_b64 s[6:7], s[0:1], 0x10
	v_lshlrev_b64_e32 v[2:3], 1, v[2:3]
	s_wait_kmcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v2, vcc_lo, s8, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s9, v3, vcc_lo
	v_add_co_u32 v4, vcc_lo, s12, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s13, v1, vcc_lo
	v_add_co_u32 v6, vcc_lo, s10, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, s11, v1, vcc_lo
	global_load_b32 v4, v[4:5], off
	global_load_u16 v5, v[2:3], off
	v_add_co_u32 v2, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s7, v1, vcc_lo
	global_load_b32 v6, v[6:7], off
	global_load_b32 v7, v[2:3], off
	s_load_b128 s[8:11], s[0:1], 0x0
	s_mov_b32 s1, 0
	s_wait_loadcnt 0x3
	v_add_co_u32 v9, s0, s14, v4
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v10, null, s15, 0, s0
	s_wait_loadcnt 0x2
	s_wait_kmcnt 0x0
	v_mad_co_u64_u32 v[4:5], null, 0x280, v5, s[8:9]
	s_wait_loadcnt 0x1
	v_add_co_u32 v2, vcc_lo, v9, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, 0, v10, vcc_lo
	s_wait_loadcnt 0x0
	v_add_co_u32 v12, s0, s10, v7
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, s11, 0, s0
	v_mov_b32_e32 v7, v3
	v_dual_mov_b32 v11, 0x800000 :: v_dual_mov_b32 v6, v2
	s_branch .LBB3_4
.LBB3_3:                                ; %Flow110
                                        ;   in Loop: Header=BB3_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_cvt_f32_u32_e32 v15, v3
	v_sub_nc_u32_e32 v16, 0, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v15, v15
	v_mul_f32_e32 v15, 0x4f7ffffe, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v15, v15
	v_mul_lo_u32 v16, v16, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v16, v15, v16
	v_add_nc_u32_e32 v15, v15, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v15, v11, v15
	v_mul_lo_u32 v16, v15, v3
	v_add_nc_u32_e32 v17, 1, v15
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u32_e32 v16, v11, v16
	v_sub_nc_u32_e32 v18, v16, v3
	v_cmp_ge_u32_e32 vcc_lo, v16, v3
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v15, v15, v17 :: v_dual_cndmask_b32 v16, v16, v18
	v_add_nc_u32_e32 v17, 1, v15
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ge_u32_e32 vcc_lo, v16, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v15, v15, v17, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v3, v15, v3
	v_lshlrev_b32_e32 v15, 12, v15
	s_wait_alu 0xfffe
	s_or_b32 s1, vcc_lo, s1
	v_sub_nc_u32_e32 v3, v11, v3
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v11, v3, v14, v15
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execz .LBB3_8
.LBB3_4:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_6 Depth 2
	v_add_nc_u32_e32 v8, -1, v8
	s_mov_b32 s5, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v14, vcc_lo, v12, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v13, vcc_lo
	global_load_u8 v3, v[14:15], off
	s_wait_loadcnt 0x0
	v_lshlrev_b32_e32 v16, 1, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v14, vcc_lo, v4, v16
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v5, vcc_lo
	global_load_u16 v3, v[14:15], off
	v_add_co_u32 v14, vcc_lo, v14, v16
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v15, vcc_lo
	global_load_b32 v14, v[14:15], off offset:128
	s_wait_loadcnt 0x1
	v_lshlrev_b32_e32 v15, 19, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ge_u32_e64 v11, v15
	s_cbranch_execz .LBB3_3
; %bb.5:                                ; %.lr.ph.preheader
                                        ;   in Loop: Header=BB3_4 Depth=1
	s_mov_b32 s6, 0
.LBB3_6:                                ; %.lr.ph
                                        ;   Parent Loop BB3_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	global_store_b8 v[6:7], v11, off offset:-1
	v_lshrrev_b32_e32 v11, 8, v11
	v_add_co_u32 v6, s0, v6, -1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v7, null, -1, v7, s0
	s_delay_alu instid0(VALU_DEP_3)
	v_cmp_lt_u32_e32 vcc_lo, v11, v15
	s_wait_alu 0xfffe
	s_or_b32 s6, vcc_lo, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB3_6
; %bb.7:                                ; %Flow109
                                        ;   in Loop: Header=BB3_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s6
	s_branch .LBB3_3
.LBB3_8:
	s_or_b32 exec_lo, exec_lo, s1
	v_add_co_u32 v3, vcc_lo, v6, -4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v4, null, -1, v7, vcc_lo
	v_mov_b32_e32 v5, 0
	s_delay_alu instid0(VALU_DEP_3)
	v_sub_nc_u32_e32 v2, v2, v3
	s_mov_b32 s5, exec_lo
	global_store_b32 v[6:7], v11, off offset:-4
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB3_12
; %bb.9:                                ; %.lr.ph86.preheader
	s_mov_b64 s[0:1], 0
	s_mov_b32 s6, 0
.LBB3_10:                               ; %.lr.ph86
                                        ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v3, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s1, v4, vcc_lo
	global_load_u8 v7, v[5:6], off
	v_add_co_u32 v5, vcc_lo, v9, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s1, v10, vcc_lo
	s_add_nc_u64 s[0:1], s[0:1], 1
	s_wait_alu 0xfffe
	v_cmp_ge_u32_e32 vcc_lo, s0, v2
	s_or_b32 s6, vcc_lo, s6
	s_wait_loadcnt 0x0
	global_store_b8 v[5:6], v7, off
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB3_10
; %bb.11:                               ; %Flow
	s_or_b32 exec_lo, exec_lo, s6
	v_mov_b32_e32 v5, v2
.LBB3_12:                               ; %Flow108
	s_or_b32 exec_lo, exec_lo, s5
.LBB3_13:                               ; %Flow111
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s4
	s_wait_kmcnt 0x0
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v5, off
.LBB3_14:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 336
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 19
		.amdhsa_next_free_sgpr 16
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 9
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end3:
	.size	_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji, .Lfunc_end3-_Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
                                        ; -- End function
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.num_vgpr, 19
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.num_agpr, 0
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.numbered_sgpr, 16
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.num_named_barrier, 0
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.private_seg_size, 0
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.uses_vcc, 1
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.uses_flat_scratch, 0
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.has_dyn_sized_stack, 0
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.has_recursion, 0
	.set _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1072
; TotalNumSgprs: 18
; NumVgprs: 19
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 19
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji ; -- Begin function _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
	.globl	_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
	.p2align	8
	.type	_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji,@function
_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji: ; @_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x5c
	s_load_b32 s3, s[0:1], 0x48
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[2:3], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v2
	s_cbranch_execz .LBB4_14
; %bb.1:
	s_load_b64 s[2:3], s[0:1], 0x18
	v_ashrrev_i32_e32 v3, 31, v2
	s_mov_b32 s4, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[0:1], 2, v[2:3]
	s_wait_kmcnt 0x0
	v_add_co_u32 v4, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v5, null, s3, v1, vcc_lo
	s_load_b64 s[2:3], s[0:1], 0x40
	global_load_b32 v8, v[4:5], off
	v_mov_b32_e32 v5, 0
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v8
	s_cbranch_execz .LBB4_13
; %bb.2:
	s_clause 0x1
	s_load_b256 s[8:15], s[0:1], 0x20
	s_load_b64 s[6:7], s[0:1], 0x10
	v_lshlrev_b64_e32 v[2:3], 1, v[2:3]
	s_wait_kmcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v2, vcc_lo, s8, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s9, v3, vcc_lo
	v_add_co_u32 v4, vcc_lo, s12, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s13, v1, vcc_lo
	v_add_co_u32 v6, vcc_lo, s10, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, s11, v1, vcc_lo
	global_load_b32 v4, v[4:5], off
	global_load_u16 v5, v[2:3], off
	v_add_co_u32 v2, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s7, v1, vcc_lo
	global_load_b32 v6, v[6:7], off
	global_load_b32 v7, v[2:3], off
	s_load_b128 s[8:11], s[0:1], 0x0
	s_mov_b32 s1, 0
	s_wait_loadcnt 0x3
	v_add_co_u32 v9, s0, s14, v4
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v10, null, s15, 0, s0
	s_wait_loadcnt 0x2
	s_wait_kmcnt 0x0
	v_mad_co_u64_u32 v[4:5], null, 0x280, v5, s[8:9]
	s_wait_loadcnt 0x1
	v_add_co_u32 v2, vcc_lo, v9, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, 0, v10, vcc_lo
	s_wait_loadcnt 0x0
	v_add_co_u32 v11, s0, s10, v7
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v12, null, s11, 0, s0
	v_mov_b32_e32 v7, v3
	v_dual_mov_b32 v13, 0x800000 :: v_dual_mov_b32 v6, v2
	s_branch .LBB4_4
.LBB4_3:                                ; %Flow124
                                        ;   in Loop: Header=BB4_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_lshlrev_b32_e32 v15, 2, v15
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v15, vcc_lo, v4, v15
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v16, null, 0, v5, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v8
	global_load_b32 v15, v[15:16], off offset:384
	s_wait_alu 0xfffe
	s_or_b32 s1, vcc_lo, s1
	s_wait_loadcnt 0x0
	v_mad_co_u64_u32 v[15:16], null, v15, v13, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_alignbit_b32 v15, v16, v15, 31
	v_mul_lo_u32 v16, v15, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u32_e32 v13, v13, v16
	v_ashrrev_i32_e32 v16, 31, v13
	v_add_nc_u32_e32 v13, v13, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_and_b32_e32 v3, v16, v3
	v_add_lshl_u32 v15, v16, v15, 12
	v_add3_u32 v13, v13, v3, v15
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execz .LBB4_8
.LBB4_4:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_6 Depth 2
	v_add_nc_u32_e32 v8, -1, v8
	s_mov_b32 s5, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v14, vcc_lo, v11, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v12, vcc_lo
	global_load_u8 v15, v[14:15], off
	s_wait_loadcnt 0x0
	v_lshlrev_b32_e32 v14, 1, v15
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v16, vcc_lo, v4, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, 0, v5, vcc_lo
	global_load_u16 v3, v[16:17], off
	v_add_co_u32 v16, vcc_lo, v16, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, 0, v17, vcc_lo
	global_load_b32 v14, v[16:17], off offset:128
	s_wait_loadcnt 0x1
	v_lshlrev_b32_e32 v16, 19, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ge_u32_e64 v13, v16
	s_cbranch_execz .LBB4_3
; %bb.5:                                ; %.lr.ph.preheader
                                        ;   in Loop: Header=BB4_4 Depth=1
	s_mov_b32 s6, 0
.LBB4_6:                                ; %.lr.ph
                                        ;   Parent Loop BB4_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	global_store_b8 v[6:7], v13, off offset:-1
	v_lshrrev_b32_e32 v13, 8, v13
	v_add_co_u32 v6, s0, v6, -1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v7, null, -1, v7, s0
	s_delay_alu instid0(VALU_DEP_3)
	v_cmp_lt_u32_e32 vcc_lo, v13, v16
	s_wait_alu 0xfffe
	s_or_b32 s6, vcc_lo, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB4_6
; %bb.7:                                ; %Flow123
                                        ;   in Loop: Header=BB4_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s6
	s_branch .LBB4_3
.LBB4_8:
	s_or_b32 exec_lo, exec_lo, s1
	v_add_co_u32 v3, vcc_lo, v6, -4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v4, null, -1, v7, vcc_lo
	v_mov_b32_e32 v5, 0
	s_delay_alu instid0(VALU_DEP_3)
	v_sub_nc_u32_e32 v2, v2, v3
	s_mov_b32 s5, exec_lo
	global_store_b32 v[6:7], v13, off offset:-4
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB4_12
; %bb.9:                                ; %.lr.ph99.preheader
	s_mov_b64 s[0:1], 0
	s_mov_b32 s6, 0
.LBB4_10:                               ; %.lr.ph99
                                        ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v3, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s1, v4, vcc_lo
	global_load_u8 v7, v[5:6], off
	v_add_co_u32 v5, vcc_lo, v9, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s1, v10, vcc_lo
	s_add_nc_u64 s[0:1], s[0:1], 1
	s_wait_alu 0xfffe
	v_cmp_ge_u32_e32 vcc_lo, s0, v2
	s_or_b32 s6, vcc_lo, s6
	s_wait_loadcnt 0x0
	global_store_b8 v[5:6], v7, off
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB4_10
; %bb.11:                               ; %Flow
	s_or_b32 exec_lo, exec_lo, s6
	v_mov_b32_e32 v5, v2
.LBB4_12:                               ; %Flow122
	s_or_b32 exec_lo, exec_lo, s5
.LBB4_13:                               ; %Flow125
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s4
	s_wait_kmcnt 0x0
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v5, off
.LBB4_14:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 336
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 18
		.amdhsa_next_free_sgpr 16
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 8
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end4:
	.size	_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji, .Lfunc_end4-_Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
                                        ; -- End function
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.num_vgpr, 18
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.num_agpr, 0
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.numbered_sgpr, 16
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.num_named_barrier, 0
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.private_seg_size, 0
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.uses_vcc, 1
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.uses_flat_scratch, 0
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.has_dyn_sized_stack, 0
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.has_recursion, 0
	.set _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1016
; TotalNumSgprs: 18
; NumVgprs: 18
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 18
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii ; -- Begin function _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii
	.globl	_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii
	.p2align	8
	.type	_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii,@function
_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii: ; @_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x5c
	s_load_b32 s3, s[0:1], 0x48
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[3:4], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v3
	s_cbranch_execz .LBB5_16
; %bb.1:
	s_load_b64 s[2:3], s[0:1], 0x30
	v_ashrrev_i32_e32 v4, 31, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[0:1], 2, v[3:4]
	s_wait_kmcnt 0x0
	v_add_co_u32 v5, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v6, null, s3, v1, vcc_lo
	global_load_b32 v8, v[5:6], off
	s_wait_loadcnt 0x0
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB5_16
; %bb.2:
	s_load_b64 s[2:3], s[0:1], 0x10
	s_wait_kmcnt 0x0
	v_add_co_u32 v5, vcc_lo, s2, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s3, v1, vcc_lo
	s_mov_b32 s3, -1
	s_mov_b32 s2, exec_lo
	global_load_b32 v2, v[5:6], off
	v_mov_b32_e32 v5, 1
	s_wait_loadcnt 0x0
	v_cmpx_lt_u32_e32 3, v2
	s_cbranch_execz .LBB5_14
; %bb.3:
	s_clause 0x1
	s_load_b128 s[4:7], s[0:1], 0x0
	s_load_b128 s[8:11], s[0:1], 0x18
	v_lshlrev_b64_e32 v[3:4], 1, v[3:4]
	s_wait_kmcnt 0x0
	v_add_co_u32 v5, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s7, v1, vcc_lo
	s_load_b64 s[6:7], s[0:1], 0x28
	v_add_co_u32 v3, vcc_lo, s8, v3
	global_load_b32 v6, v[5:6], off
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v4, null, s9, v4, vcc_lo
	s_load_b64 s[8:9], s[0:1], 0x38
	global_load_u16 v5, v[3:4], off
	s_wait_kmcnt 0x0
	v_add_co_u32 v3, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v4, null, s7, v1, vcc_lo
                                        ; implicit-def: $sgpr6
	global_load_b32 v11, v[3:4], off
	s_wait_loadcnt 0x2
	global_load_b32 v13, v6, s[4:5]
	v_add_co_u32 v9, s3, s4, v6
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v10, null, s5, 0, s3
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v6, 4
	s_wait_loadcnt 0x2
	v_mad_co_u64_u32 v[4:5], null, 0x1180, v5, s[8:9]
	v_mov_b32_e32 v7, 0
	s_mov_b32 s5, 0
                                        ; implicit-def: $sgpr4
	s_wait_loadcnt 0x1
	v_add_co_u32 v11, s3, s10, v11
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v12, null, s11, 0, s3
	s_mov_b32 s3, 0
	s_branch .LBB5_5
.LBB5_4:                                ; %Flow90
                                        ;   in Loop: Header=BB5_5 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s7, exec_lo, s7
	s_wait_alu 0xfffe
	s_or_b32 s3, s7, s3
	s_and_not1_b32 s4, s4, exec_lo
	s_and_b32 s7, s6, exec_lo
	s_wait_alu 0xfffe
	s_or_b32 s4, s4, s7
	s_and_not1_b32 exec_lo, exec_lo, s3
	s_cbranch_execz .LBB5_13
.LBB5_5:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_8 Depth 2
	s_wait_loadcnt 0x0
	v_and_b32_e32 v18, 0xfff, v13
	v_lshrrev_b32_e32 v13, 12, v13
	s_mov_b32 s8, -1
	s_mov_b32 s7, exec_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_u32 v14, vcc_lo, v4, v18
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v5, vcc_lo
	global_load_u8 v19, v[14:15], off offset:384
	s_wait_loadcnt 0x0
	v_and_b32_e32 v14, 0xff, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v16, 1, v14
	v_add_co_u32 v14, vcc_lo, v4, v16
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v5, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v16, vcc_lo, v14, v16
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, 0, v15, vcc_lo
	s_clause 0x1
	global_load_b32 v16, v[16:17], off
	global_load_u16 v14, v[14:15], off offset:256
	s_wait_loadcnt 0x1
	v_sub_nc_u32_e32 v15, v18, v16
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1)
	v_mad_u32_u24 v13, v13, v14, v15
	s_wait_alu 0xfffe
	v_add_co_u32 v14, vcc_lo, v11, s5
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v12, vcc_lo
	global_store_b8 v[14:15], v19, off
	v_cmpx_gt_u32_e32 0x800000, v13
	s_cbranch_execz .LBB5_11
; %bb.6:                                ; %.lr.ph.preheader
                                        ;   in Loop: Header=BB5_5 Depth=1
	s_mov_b32 s8, 0
                                        ; implicit-def: $sgpr9
                                        ; implicit-def: $sgpr11
                                        ; implicit-def: $sgpr10
	s_branch .LBB5_8
.LBB5_7:                                ; %Flow
                                        ;   in Loop: Header=BB5_8 Depth=2
	s_or_b32 exec_lo, exec_lo, s12
	s_wait_alu 0xfffe
	s_xor_b32 s12, s10, -1
	s_and_b32 s13, exec_lo, s11
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s8, s13, s8
	s_and_not1_b32 s9, s9, exec_lo
	s_and_b32 s12, s12, exec_lo
	s_wait_alu 0xfffe
	s_or_b32 s9, s9, s12
	s_and_not1_b32 exec_lo, exec_lo, s8
	s_cbranch_execz .LBB5_10
.LBB5_8:                                ; %.lr.ph
                                        ;   Parent Loop BB5_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_or_b32 s10, s10, exec_lo
	s_or_b32 s11, s11, exec_lo
	s_mov_b32 s12, exec_lo
	v_cmpx_lt_u64_e64 v[6:7], v[2:3]
	s_cbranch_execz .LBB5_7
; %bb.9:                                ;   in Loop: Header=BB5_8 Depth=2
	v_add_co_u32 v14, vcc_lo, v9, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, v10, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	global_load_u8 v14, v[14:15], off
	v_cmp_lt_u32_e32 vcc_lo, 0x7fff, v13
	s_wait_alu 0xfffe
	s_and_not1_b32 s11, s11, exec_lo
	s_and_not1_b32 s10, s10, exec_lo
	s_and_b32 s13, vcc_lo, exec_lo
	s_wait_alu 0xfffe
	s_or_b32 s11, s11, s13
	s_wait_loadcnt 0x0
	v_perm_b32 v14, v14, v13, 0x2010004
	s_delay_alu instid0(VALU_DEP_1)
	v_mov_b32_e32 v13, v14
	s_branch .LBB5_7
.LBB5_10:                               ; %loop.exit.guard87
                                        ;   in Loop: Header=BB5_5 Depth=1
	s_or_b32 exec_lo, exec_lo, s8
	s_wait_alu 0xfffe
	s_or_not1_b32 s8, s9, exec_lo
.LBB5_11:                               ; %Flow89
                                        ;   in Loop: Header=BB5_5 Depth=1
	s_or_b32 exec_lo, exec_lo, s7
	s_mov_b32 s7, -1
	s_or_b32 s6, s6, exec_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB5_4
; %bb.12:                               ; %.critedge
                                        ;   in Loop: Header=BB5_5 Depth=1
	s_add_co_i32 s5, s5, 1
	s_and_not1_b32 s6, s6, exec_lo
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e32 vcc_lo, s5, v8
	s_or_not1_b32 s7, vcc_lo, exec_lo
	s_branch .LBB5_4
.LBB5_13:                               ; %loop.exit.guard
	s_or_b32 exec_lo, exec_lo, s3
	v_mov_b32_e32 v5, 2
	s_wait_alu 0xfffe
	s_or_not1_b32 s3, s4, exec_lo
.LBB5_14:                               ; %Flow91
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 exec_lo, exec_lo, s3
	s_cbranch_execz .LBB5_16
; %bb.15:                               ; %.loopexit.sink.split
	s_load_b64 s[0:1], s[0:1], 0x40
	s_wait_kmcnt 0x0
	v_add_co_u32 v0, vcc_lo, s0, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s1, v1, vcc_lo
	global_store_b32 v[0:1], v5, off
.LBB5_16:                               ; %.loopexit
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 336
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 20
		.amdhsa_next_free_sgpr 14
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 9
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end5:
	.size	_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii, .Lfunc_end5-_Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii
                                        ; -- End function
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.num_vgpr, 20
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.num_agpr, 0
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.numbered_sgpr, 14
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.num_named_barrier, 0
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.private_seg_size, 0
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.uses_vcc, 1
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.uses_flat_scratch, 0
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.has_dyn_sized_stack, 0
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.has_recursion, 0
	.set _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1052
; TotalNumSgprs: 16
; NumVgprs: 20
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 16
; NumVGPRsForWavesPerEU: 20
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z5k_symPK5sdescPKjPhS3_Pjii ; -- Begin function _Z5k_symPK5sdescPKjPhS3_Pjii
	.globl	_Z5k_symPK5sdescPKjPhS3_Pjii
	.p2align	8
	.type	_Z5k_symPK5sdescPKjPhS3_Pjii,@function
_Z5k_symPK5sdescPKjPhS3_Pjii:           ; @_Z5k_symPK5sdescPKjPhS3_Pjii
; %bb.0:
	s_clause 0x1
	s_load_b32 s4, s[0:1], 0x3c
	s_load_b64 s[2:3], s[0:1], 0x28
	s_wait_kmcnt 0x0
	s_and_b32 s4, s4, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_co_u64_u32 v[8:9], null, ttmp9, s4, v[0:1]
	v_cmp_gt_i32_e32 vcc_lo, s2, v8
	s_and_saveexec_b32 s2, vcc_lo
	s_cbranch_execz .LBB6_56
; %bb.1:
	s_load_b64 s[4:5], s[0:1], 0x0
	v_ashrrev_i32_e32 v9, 31, v8
	s_cmp_lg_u32 s3, 0
	s_cselect_b32 s14, -1, 0
	s_cmp_eq_u32 s3, 0
	s_wait_kmcnt 0x0
	v_mad_co_i64_i32 v[4:5], null, v8, 48, s[4:5]
	v_lshlrev_b64_e32 v[8:9], 2, v[8:9]
	s_clause 0x2
	global_load_b64 v[10:11], v[4:5], off offset:16
	global_load_b128 v[0:3], v[4:5], off
	global_load_b128 v[4:7], v[4:5], off offset:32
	s_cbranch_scc1 .LBB6_3
; %bb.2:
	s_load_b128 s[4:7], s[0:1], 0x10
	s_wait_kmcnt 0x0
	v_add_co_u32 v12, vcc_lo, s6, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v13, null, s7, v9, vcc_lo
	global_load_b32 v12, v[12:13], off
	s_wait_loadcnt 0x0
	v_add_co_u32 v12, s2, s4, v12
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, s5, 0, s2
	s_branch .LBB6_4
.LBB6_3:
	v_mov_b32_e32 v12, 0
	v_mov_b32_e32 v13, 0
.LBB6_4:
	s_load_b64 s[8:9], s[0:1], 0x20
	v_mov_b32_e32 v19, 0
	s_mov_b32 s15, exec_lo
	s_wait_loadcnt 0x2
	v_cmpx_lt_i32_e32 0, v10
	s_cbranch_execz .LBB6_55
; %bb.5:                                ; %.preheader.lr.ph
	s_wait_loadcnt 0x0
	v_mul_lo_u32 v14, v6, v1
	s_load_b64 s[10:11], s[0:1], 0x8
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b32_e32 v7, 4, v7
	v_mul_lo_u32 v18, v3, v2
	v_cmp_lt_i32_e64 s0, 0, v3
	v_cmp_lt_i32_e64 s1, 0, v2
	v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
	v_ashrrev_i32_e32 v15, 31, v14
	v_cmp_eq_u32_e64 s2, 0, v11
	v_cmp_ne_u32_e64 s3, 0, v11
	v_cmp_eq_u32_e64 s4, 3, v11
	v_cmp_ne_u32_e64 s5, 1, v11
	v_lshlrev_b64_e32 v[14:15], 1, v[14:15]
	v_cmp_eq_u32_e64 s6, 2, v11
	v_ashrrev_i32_e32 v11, 31, v7
	v_mov_b32_e32 v19, 0
	v_mov_b32_e32 v17, 0
	s_mov_b32 s13, 0
	v_add_co_u32 v4, vcc_lo, v4, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, v5, v15, vcc_lo
	s_wait_kmcnt 0x0
	s_cmp_lg_u64 s[10:11], 0
	v_add_co_u32 v20, vcc_lo, v4, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v21, null, v5, v1, vcc_lo
	s_cselect_b32 s16, -1, 0
	s_mov_b32 s17, 0
	s_branch .LBB6_7
.LBB6_6:                                ; %Flow201
                                        ;   in Loop: Header=BB6_7 Depth=1
	s_or_b32 exec_lo, exec_lo, s18
	v_cmp_gt_i32_e32 vcc_lo, 2, v10
	v_mov_b32_e32 v10, v22
	s_or_b32 s17, vcc_lo, s17
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s17
	s_cbranch_execz .LBB6_54
.LBB6_7:                                ; %.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_9 Depth 2
                                        ;       Child Loop BB6_16 Depth 3
                                        ;         Child Loop BB6_24 Depth 4
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v22, -1, v10
	s_and_saveexec_b32 s18, s0
	s_cbranch_execz .LBB6_6
; %bb.8:                                ; %.lr.ph157
                                        ;   in Loop: Header=BB6_7 Depth=1
	v_ashrrev_i32_e32 v1, 31, v10
	v_add_co_u32 v0, vcc_lo, v10, v7
	v_lshlrev_b32_e64 v23, v22, 1
	v_mov_b32_e32 v24, 0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, v1, v11, vcc_lo
	s_mov_b32 s19, 0
	s_mov_b32 s20, 0
	v_lshlrev_b64_e32 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v0, vcc_lo, s10, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s11, v1, vcc_lo
.LBB6_9:                                ;   Parent Loop BB6_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB6_16 Depth 3
                                        ;         Child Loop BB6_24 Depth 4
	s_and_saveexec_b32 s21, s1
	s_cbranch_execz .LBB6_51
; %bb.10:                               ; %.lr.ph149.preheader
                                        ;   in Loop: Header=BB6_9 Depth=2
	s_wait_alu 0xfffe
	v_mul_lo_u32 v4, s20, v6
	v_mov_b32_e32 v25, v24
	s_mov_b32 s22, 0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	s_mov_b32 s12, s22
	v_ashrrev_i32_e32 v5, 31, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[4:5], 1, v[4:5]
	v_add_co_u32 v4, vcc_lo, v20, v4
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v5, null, v21, v5, vcc_lo
	s_branch .LBB6_16
.LBB6_11:                               ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s26
	v_add_nc_u32_e32 v19, 1, v19
.LBB6_12:                               ; %Flow190
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s7
.LBB6_13:                               ; %Flow191
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s25
.LBB6_14:                               ; %Flow193
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s24
.LBB6_15:                               ;   in Loop: Header=BB6_16 Depth=3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s23
	s_wait_alu 0xfffe
	s_add_co_i32 s12, s12, 1
	v_add_nc_u32_e32 v25, 1, v25
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e32 vcc_lo, s12, v2
	s_or_b32 s22, vcc_lo, s22
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s22
	s_cbranch_execz .LBB6_50
.LBB6_16:                               ; %.lr.ph149
                                        ;   Parent Loop BB6_7 Depth=1
                                        ;     Parent Loop BB6_9 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB6_24 Depth 4
	v_and_b32_e32 v14, 31, v25
	s_mov_b32 s23, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 0, v14
	s_cbranch_execz .LBB6_32
; %bb.17:                               ;   in Loop: Header=BB6_16 Depth=3
	s_and_not1_b32 vcc_lo, exec_lo, s16
	s_wait_alu 0xfffe
	s_cbranch_vccnz .LBB6_20
; %bb.18:                               ;   in Loop: Header=BB6_16 Depth=3
	global_load_b32 v14, v[0:1], off offset:-4
	v_ashrrev_i32_e32 v15, 5, v25
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1)
	v_bfe_u32 v17, v14, v15, 1
	s_cbranch_execz .LBB6_21
; %bb.19:                               ; %.loopexit
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_and_saveexec_b32 s7, s2
	s_cbranch_execnz .LBB6_28
	s_branch .LBB6_31
.LBB6_20:                               ;   in Loop: Header=BB6_16 Depth=3
                                        ; implicit-def: $vgpr17
.LBB6_21:                               ;   in Loop: Header=BB6_16 Depth=3
	v_sub_nc_u32_e32 v14, v18, v25
	v_mov_b32_e32 v17, 0
	s_mov_b32 s24, exec_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_cmpx_lt_i32_e32 0, v14
	s_cbranch_execz .LBB6_27
; %bb.22:                               ; %.lr.ph.preheader
                                        ;   in Loop: Header=BB6_16 Depth=3
	v_min_i32_e32 v26, 32, v14
	v_dual_mov_b32 v27, 0 :: v_dual_mov_b32 v16, s12
	v_dual_mov_b32 v15, v5 :: v_dual_mov_b32 v14, v4
	s_mov_b32 s26, 1
	s_mov_b32 s25, 0
	s_branch .LBB6_24
.LBB6_23:                               ;   in Loop: Header=BB6_24 Depth=4
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s27
	v_cmp_ge_i32_e32 vcc_lo, s26, v26
	s_xor_b32 s7, s7, -1
	s_add_co_i32 s26, s26, 1
	v_mov_b32_e32 v27, v17
	s_wait_alu 0xfffe
	s_or_b32 s7, s7, vcc_lo
	s_wait_alu 0xfffe
	s_and_b32 s7, exec_lo, s7
	s_wait_alu 0xfffe
	s_or_b32 s25, s7, s25
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s25
	s_cbranch_execz .LBB6_26
.LBB6_24:                               ; %.lr.ph
                                        ;   Parent Loop BB6_7 Depth=1
                                        ;     Parent Loop BB6_9 Depth=2
                                        ;       Parent Loop BB6_16 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	v_ashrrev_i32_e32 v17, 31, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[28:29], 1, v[16:17]
	v_add_co_u32 v28, vcc_lo, v14, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v29, null, v15, v29, vcc_lo
	flat_load_u16 v17, v[28:29]
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v28, 0, v17
	v_max_i16 v17, v17, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v17, 0xffff, v17
	v_lshrrev_b32_e32 v28, v10, v17
	v_and_b32_e32 v17, v23, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v28
	v_cmp_eq_u32_e64 s7, 0, v17
	v_mov_b32_e32 v17, 1
	s_or_b32 s7, vcc_lo, s7
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s27, s7
	s_cbranch_execz .LBB6_23
; %bb.25:                               ;   in Loop: Header=BB6_24 Depth=4
	v_add_nc_u32_e32 v30, 1, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e32 vcc_lo, v30, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v16, 0, v6, vcc_lo
	v_ashrrev_i32_e32 v17, 31, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b64_e32 v[28:29], 1, v[16:17]
	v_mov_b32_e32 v17, v27
	v_cndmask_b32_e64 v16, v30, 0, vcc_lo
	v_add_co_u32 v14, vcc_lo, v14, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_4)
	v_add_co_ci_u32_e64 v15, null, v15, v29, vcc_lo
	s_branch .LBB6_23
.LBB6_26:                               ; %Flow195
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_or_b32 exec_lo, exec_lo, s25
.LBB6_27:                               ; %Flow196
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s24
	s_and_saveexec_b32 s7, s2
	s_cbranch_execz .LBB6_31
.LBB6_28:                               ;   in Loop: Header=BB6_16 Depth=3
	v_cmp_ne_u32_e32 vcc_lo, 0, v17
	s_and_b32 s25, s14, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s24, s25
	s_cbranch_execz .LBB6_30
; %bb.29:                               ;   in Loop: Header=BB6_16 Depth=3
	v_lshrrev_b32_e32 v14, 3, v19
	v_and_b32_e32 v26, 7, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_add_co_u32 v14, vcc_lo, v12, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v13, vcc_lo
	v_lshlrev_b32_e64 v26, v26, 1
	global_load_u8 v16, v[14:15], off
	s_wait_loadcnt 0x0
	v_or_b32_e32 v16, v16, v26
	global_store_b8 v[14:15], v16, off
.LBB6_30:                               ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s24
	v_add_nc_u32_e32 v19, 1, v19
.LBB6_31:                               ; %Flow194
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s7
.LBB6_32:                               ; %Flow198
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s23
	s_and_saveexec_b32 s23, s3
	s_cbranch_execz .LBB6_15
; %bb.33:                               ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_lshl_b64 s[24:25], s[12:13], 1
	s_mov_b32 s7, exec_lo
	s_wait_alu 0xfffe
	v_add_co_u32 v14, vcc_lo, v4, s24
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, s25, v5, vcc_lo
	flat_load_u16 v14, v[14:15]
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v15, 0, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_max_i16 v15, v14, v15
	v_and_b32_e32 v15, 0xffff, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v16, v10, v15
	v_cmpx_ne_u32_e32 0, v16
	s_xor_b32 s7, exec_lo, s7
	s_cbranch_execz .LBB6_39
; %bb.34:                               ;   in Loop: Header=BB6_16 Depth=3
	s_and_saveexec_b32 s24, s4
	s_cbranch_execz .LBB6_38
; %bb.35:                               ;   in Loop: Header=BB6_16 Depth=3
	v_and_b32_e32 v14, v23, v15
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u32_e32 vcc_lo, 0, v14
	s_and_b32 s26, s14, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s25, s26
	s_cbranch_execz .LBB6_37
; %bb.36:                               ;   in Loop: Header=BB6_16 Depth=3
	v_lshrrev_b32_e32 v14, 3, v19
	v_and_b32_e32 v26, 7, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_add_co_u32 v14, vcc_lo, v12, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v13, vcc_lo
	v_lshlrev_b32_e64 v26, v26, 1
	global_load_u8 v16, v[14:15], off
	s_wait_loadcnt 0x0
	v_or_b32_e32 v16, v16, v26
	global_store_b8 v[14:15], v16, off
.LBB6_37:                               ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s25
	v_add_nc_u32_e32 v19, 1, v19
.LBB6_38:                               ; %Flow
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s24
                                        ; implicit-def: $vgpr15
                                        ; implicit-def: $vgpr14
.LBB6_39:                               ; %Flow192
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s24, s7
	s_cbranch_execz .LBB6_14
; %bb.40:                               ;   in Loop: Header=BB6_16 Depth=3
	s_mov_b32 s25, exec_lo
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB6_13
; %bb.41:                               ;   in Loop: Header=BB6_16 Depth=3
	v_and_b32_e32 v15, v23, v15
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u32_e32 vcc_lo, 0, v15
	s_and_saveexec_b32 s7, s5
	s_wait_alu 0xfffe
	s_xor_b32 s26, exec_lo, s7
	s_cbranch_execz .LBB6_47
; %bb.42:                               ;   in Loop: Header=BB6_16 Depth=3
	s_and_b32 s7, s6, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s27, s7
	s_cbranch_execz .LBB6_46
; %bb.43:                               ;   in Loop: Header=BB6_16 Depth=3
	v_cmp_gt_i16_e64 s7, 0, v14
	s_and_b32 s7, s14, s7
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s28, s7
	s_cbranch_execz .LBB6_45
; %bb.44:                               ;   in Loop: Header=BB6_16 Depth=3
	v_lshrrev_b32_e32 v14, 3, v19
	v_and_b32_e32 v26, 7, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_add_co_u32 v14, s7, v12, v14
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v15, null, 0, v13, s7
	v_lshlrev_b32_e64 v26, v26, 1
	global_load_u8 v16, v[14:15], off
	s_wait_loadcnt 0x0
	v_or_b32_e32 v16, v16, v26
	global_store_b8 v[14:15], v16, off
.LBB6_45:                               ;   in Loop: Header=BB6_16 Depth=3
	s_or_b32 exec_lo, exec_lo, s28
	v_add_nc_u32_e32 v19, 1, v19
.LBB6_46:                               ; %Flow188
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s27
.LBB6_47:                               ; %Flow189
                                        ;   in Loop: Header=BB6_16 Depth=3
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s7, s26
	s_cbranch_execz .LBB6_12
; %bb.48:                               ;   in Loop: Header=BB6_16 Depth=3
	s_and_b32 s27, s14, vcc_lo
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s26, s27
	s_cbranch_execz .LBB6_11
; %bb.49:                               ;   in Loop: Header=BB6_16 Depth=3
	v_lshrrev_b32_e32 v14, 3, v19
	v_and_b32_e32 v26, 7, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_add_co_u32 v14, vcc_lo, v12, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v13, vcc_lo
	v_lshlrev_b32_e64 v26, v26, 1
	global_load_u8 v16, v[14:15], off
	s_wait_loadcnt 0x0
	v_or_b32_e32 v16, v16, v26
	global_store_b8 v[14:15], v16, off
	s_branch .LBB6_11
.LBB6_50:                               ; %._crit_edge.loopexit
                                        ;   in Loop: Header=BB6_9 Depth=2
	s_or_b32 exec_lo, exec_lo, s22
	v_add_nc_u32_e32 v24, v2, v24
.LBB6_51:                               ; %Flow199
                                        ;   in Loop: Header=BB6_9 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s21
; %bb.52:                               ; %._crit_edge
                                        ;   in Loop: Header=BB6_9 Depth=2
	s_add_co_i32 s20, s20, 1
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e32 vcc_lo, s20, v3
	s_or_b32 s19, vcc_lo, s19
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s19
	s_cbranch_execnz .LBB6_9
; %bb.53:                               ; %Flow200
                                        ;   in Loop: Header=BB6_7 Depth=1
	s_or_b32 exec_lo, exec_lo, s19
	s_branch .LBB6_6
.LBB6_54:                               ; %Flow203
	s_or_b32 exec_lo, exec_lo, s17
.LBB6_55:                               ; %Flow204
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s15
	s_wait_loadcnt 0x1
	s_wait_kmcnt 0x0
	v_add_co_u32 v0, vcc_lo, s8, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s9, v9, vcc_lo
	global_store_b32 v[0:1], v19, off
.LBB6_56:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z5k_symPK5sdescPKjPhS3_Pjii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 304
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 31
		.amdhsa_next_free_sgpr 29
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 15
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end6:
	.size	_Z5k_symPK5sdescPKjPhS3_Pjii, .Lfunc_end6-_Z5k_symPK5sdescPKjPhS3_Pjii
                                        ; -- End function
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.num_vgpr, 31
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.num_agpr, 0
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.numbered_sgpr, 29
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.num_named_barrier, 0
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.private_seg_size, 0
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.uses_vcc, 1
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.uses_flat_scratch, 0
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.has_dyn_sized_stack, 0
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.has_recursion, 0
	.set _Z5k_symPK5sdescPKjPhS3_Pjii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1860
; TotalNumSgprs: 31
; NumVgprs: 31
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 3
; NumSGPRsForWavesPerEU: 31
; NumVGPRsForWavesPerEU: 31
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z9k_offsetsPKjPji      ; -- Begin function _Z9k_offsetsPKjPji
	.globl	_Z9k_offsetsPKjPji
	.p2align	8
	.type	_Z9k_offsetsPKjPji,@function
_Z9k_offsetsPKjPji:                     ; @_Z9k_offsetsPKjPji
; %bb.0:
	v_or_b32_e32 v0, ttmp9, v0
	s_mov_b32 s7, 0
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 0, v0
	s_cbranch_execz .LBB7_5
; %bb.1:                                ; %.preheader
	s_load_b96 s[4:6], s[0:1], 0x8
	s_wait_kmcnt 0x0
	s_cmp_lt_i32 s6, 1
	s_cbranch_scc1 .LBB7_4
; %bb.2:                                ; %.lr.ph.preheader
	s_load_b64 s[0:1], s[0:1], 0x0
	v_mov_b32_e32 v0, 0
	s_mov_b64 s[2:3], s[4:5]
	s_mov_b32 s8, s6
.LBB7_3:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	s_wait_kmcnt 0x0
	s_load_b32 s9, s[0:1], 0x0
	v_mov_b32_e32 v1, s7
	s_add_co_i32 s8, s8, -1
	s_add_nc_u64 s[0:1], s[0:1], 4
	global_store_b32 v0, v1, s[2:3]
	s_add_nc_u64 s[2:3], s[2:3], 4
	s_wait_kmcnt 0x0
	s_add_co_i32 s9, s9, 7
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_lshr_b32 s9, s9, 3
	s_add_co_i32 s7, s9, s7
	s_cmp_eq_u32 s8, 0
	s_cbranch_scc0 .LBB7_3
.LBB7_4:                                ; %Flow21
	s_ashr_i32 s1, s6, 31
	s_mov_b32 s0, s6
	s_wait_alu 0xfffe
	v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s7
	s_lshl_b64 s[0:1], s[0:1], 2
	s_wait_alu 0xfffe
	s_add_nc_u64 s[0:1], s[4:5], s[0:1]
	global_store_b32 v0, v1, s[0:1]
.LBB7_5:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z9k_offsetsPKjPji
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 20
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 2
		.amdhsa_next_free_sgpr 10
		.amdhsa_reserve_vcc 0
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 2
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end7:
	.size	_Z9k_offsetsPKjPji, .Lfunc_end7-_Z9k_offsetsPKjPji
                                        ; -- End function
	.set _Z9k_offsetsPKjPji.num_vgpr, 2
	.set _Z9k_offsetsPKjPji.num_agpr, 0
	.set _Z9k_offsetsPKjPji.numbered_sgpr, 10
	.set _Z9k_offsetsPKjPji.num_named_barrier, 0
	.set _Z9k_offsetsPKjPji.private_seg_size, 0
	.set _Z9k_offsetsPKjPji.uses_vcc, 0
	.set _Z9k_offsetsPKjPji.uses_flat_scratch, 0
	.set _Z9k_offsetsPKjPji.has_dyn_sized_stack, 0
	.set _Z9k_offsetsPKjPji.has_recursion, 0
	.set _Z9k_offsetsPKjPji.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 180
; TotalNumSgprs: 10
; NumVgprs: 2
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 0
; NumSGPRsForWavesPerEU: 10
; NumVGPRsForWavesPerEU: 2
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z6k_packPKhPKjS2_PhS2_Pji ; -- Begin function _Z6k_packPKhPKjS2_PhS2_Pji
	.globl	_Z6k_packPKhPKjS2_PhS2_Pji
	.p2align	8
	.type	_Z6k_packPKhPKjS2_PhS2_Pji,@function
_Z6k_packPKhPKjS2_PhS2_Pji:             ; @_Z6k_packPKhPKjS2_PhS2_Pji
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x44
	s_load_b32 s3, s[0:1], 0x30
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB8_16
; %bb.1:
	s_clause 0x1
	s_load_b64 s[2:3], s[0:1], 0x10
	s_load_b64 s[4:5], s[0:1], 0x28
	v_ashrrev_i32_e32 v1, 31, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[0:1], 2, v[0:1]
	s_wait_kmcnt 0x0
	v_add_co_u32 v2, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v3, null, s3, v1, vcc_lo
	v_add_co_u32 v4, vcc_lo, s4, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s5, v1, vcc_lo
	global_load_b32 v2, v[2:3], off
	s_wait_loadcnt 0x0
	v_add_nc_u32_e32 v6, 5, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v3, 0xaaaaaaab, v6
	v_cmp_lt_u32_e32 vcc_lo, 5, v6
	v_lshrrev_b32_e32 v3, 2, v3
	global_store_b32 v[4:5], v3, off
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB8_16
; %bb.2:                                ; %.preheader.preheader
	s_clause 0x1
	s_load_b128 s[4:7], s[0:1], 0x0
	s_load_b128 s[0:3], s[0:1], 0x18
	s_wait_kmcnt 0x0
	v_add_co_u32 v4, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s7, v1, vcc_lo
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_load_b32 v4, v[4:5], off
	global_load_b32 v0, v[0:1], off
	s_wait_loadcnt 0x1
	v_add_co_u32 v4, s2, s4, v4
	s_wait_loadcnt 0x0
	v_add_co_u32 v0, s0, s0, v0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v5, null, s5, 0, s2
	v_add_co_ci_u32_e64 v1, null, s1, 0, s0
	s_mov_b32 s1, 0
	s_mov_b32 s2, 0
	s_branch .LBB8_4
.LBB8_3:                                ;   in Loop: Header=BB8_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s0
	v_add_nc_u32_e32 v3, -1, v3
	global_store_b8 v[0:1], v6, off
	v_add_co_u32 v0, s0, v0, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v1, null, 0, v1, s0
	v_cmp_eq_u32_e32 vcc_lo, 0, v3
	s_add_co_i32 s2, s2, 6
	s_or_b32 s1, vcc_lo, s1
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execz .LBB8_16
.LBB8_4:                                ; %.preheader
                                        ; =>This Inner Loop Header: Depth=1
	v_mov_b32_e32 v6, 0
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_lt_u32_e64 s2, v2
	s_cbranch_execz .LBB8_6
; %bb.5:                                ;   in Loop: Header=BB8_4 Depth=1
	s_lshr_b32 s3, s2, 3
	s_wait_alu 0xfffe
	v_add_co_u32 v6, vcc_lo, v4, s3
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, 0, v5, vcc_lo
	s_and_b32 s3, s2, 6
	global_load_u8 v6, v[6:7], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_bfe_u32 v6, v6, s3, 1
.LBB8_6:                                ;   in Loop: Header=BB8_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s0
	s_add_co_i32 s3, s2, 1
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_lt_u32_e64 s3, v2
	s_cbranch_execz .LBB8_8
; %bb.7:                                ;   in Loop: Header=BB8_4 Depth=1
	s_lshr_b32 s4, s2, 3
	s_and_b32 s3, s3, 7
	s_wait_alu 0xfffe
	v_add_co_u32 v7, vcc_lo, v4, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, 0, v5, vcc_lo
	global_load_u8 v7, v[7:8], off
	s_wait_loadcnt 0x0
	v_lshrrev_b32_e32 v7, s3, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bfe_i32 v7, v7, 0, 1
	v_and_or_b32 v6, v7, 2, v6
.LBB8_8:                                ;   in Loop: Header=BB8_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s0
	s_add_co_i32 s3, s2, 2
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_lt_u32_e64 s3, v2
	s_cbranch_execz .LBB8_10
; %bb.9:                                ;   in Loop: Header=BB8_4 Depth=1
	s_lshr_b32 s4, s3, 3
	s_and_b32 s3, s3, 6
	s_wait_alu 0xfffe
	v_add_co_u32 v7, vcc_lo, v4, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, 0, v5, vcc_lo
	global_load_u8 v7, v[7:8], off
	s_wait_loadcnt 0x0
	v_lshrrev_b32_e32 v7, s3, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bfe_i32 v7, v7, 0, 1
	v_and_or_b32 v6, v7, 4, v6
.LBB8_10:                               ;   in Loop: Header=BB8_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s0
	s_add_co_i32 s3, s2, 3
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_lt_u32_e64 s3, v2
	s_cbranch_execz .LBB8_12
; %bb.11:                               ;   in Loop: Header=BB8_4 Depth=1
	s_lshr_b32 s4, s3, 3
	s_and_b32 s3, s3, 7
	s_wait_alu 0xfffe
	v_add_co_u32 v7, vcc_lo, v4, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, 0, v5, vcc_lo
	global_load_u8 v7, v[7:8], off
	s_wait_loadcnt 0x0
	v_lshrrev_b32_e32 v7, s3, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bfe_i32 v7, v7, 0, 1
	v_and_or_b32 v6, v7, 8, v6
.LBB8_12:                               ;   in Loop: Header=BB8_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s0
	s_add_co_i32 s3, s2, 4
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_lt_u32_e64 s3, v2
	s_cbranch_execz .LBB8_14
; %bb.13:                               ;   in Loop: Header=BB8_4 Depth=1
	s_lshr_b32 s4, s3, 3
	s_and_b32 s3, s3, 6
	s_wait_alu 0xfffe
	v_add_co_u32 v7, vcc_lo, v4, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, 0, v5, vcc_lo
	global_load_u8 v7, v[7:8], off
	s_wait_loadcnt 0x0
	v_lshrrev_b32_e32 v7, s3, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bfe_i32 v7, v7, 0, 1
	v_and_or_b32 v6, v7, 16, v6
.LBB8_14:                               ;   in Loop: Header=BB8_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s0
	s_add_co_i32 s3, s2, 5
	s_mov_b32 s0, exec_lo
	s_wait_alu 0xfffe
	v_cmpx_lt_u32_e64 s3, v2
	s_cbranch_execz .LBB8_3
; %bb.15:                               ;   in Loop: Header=BB8_4 Depth=1
	s_lshr_b32 s4, s3, 3
	s_and_b32 s3, s3, 7
	s_wait_alu 0xfffe
	v_add_co_u32 v7, vcc_lo, v4, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v8, null, 0, v5, vcc_lo
	global_load_u8 v7, v[7:8], off
	s_wait_loadcnt 0x0
	v_lshrrev_b32_e32 v7, s3, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bfe_i32 v7, v7, 0, 1
	v_and_or_b32 v6, v7, 32, v6
	s_branch .LBB8_3
.LBB8_16:                               ; %.loopexit
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z6k_packPKhPKjS2_PhS2_Pji
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 312
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 9
		.amdhsa_next_free_sgpr 8
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 8
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end8:
	.size	_Z6k_packPKhPKjS2_PhS2_Pji, .Lfunc_end8-_Z6k_packPKhPKjS2_PhS2_Pji
                                        ; -- End function
	.set _Z6k_packPKhPKjS2_PhS2_Pji.num_vgpr, 9
	.set _Z6k_packPKhPKjS2_PhS2_Pji.num_agpr, 0
	.set _Z6k_packPKhPKjS2_PhS2_Pji.numbered_sgpr, 8
	.set _Z6k_packPKhPKjS2_PhS2_Pji.num_named_barrier, 0
	.set _Z6k_packPKhPKjS2_PhS2_Pji.private_seg_size, 0
	.set _Z6k_packPKhPKjS2_PhS2_Pji.uses_vcc, 1
	.set _Z6k_packPKhPKjS2_PhS2_Pji.uses_flat_scratch, 0
	.set _Z6k_packPKhPKjS2_PhS2_Pji.has_dyn_sized_stack, 0
	.set _Z6k_packPKhPKjS2_PhS2_Pji.has_recursion, 0
	.set _Z6k_packPKhPKjS2_PhS2_Pji.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1000
; TotalNumSgprs: 10
; NumVgprs: 9
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 10
; NumVGPRsForWavesPerEU: 9
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z6k_histPKhPKjS2_PKtPii ; -- Begin function _Z6k_histPKhPKjS2_PKtPii
	.globl	_Z6k_histPKhPKjS2_PKtPii
	.p2align	8
	.type	_Z6k_histPKhPKjS2_PKtPii,@function
_Z6k_histPKhPKjS2_PKtPii:               ; @_Z6k_histPKhPKjS2_PKtPii
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x3c
	s_load_b32 s3, s[0:1], 0x28
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB9_132
; %bb.1:
	s_clause 0x1
	s_load_b128 s[4:7], s[0:1], 0x10
	s_load_b64 s[2:3], s[0:1], 0x20
	v_ashrrev_i32_e32 v1, 31, v0
	s_mov_b32 s8, 0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	s_mov_b32 s9, s8
	s_mov_b32 s10, s8
	v_lshlrev_b64_e32 v[2:3], 2, v[0:1]
	s_mov_b32 s11, s8
	s_wait_kmcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v4, vcc_lo, s4, v2
	v_add_co_ci_u32_e64 v5, null, s5, v3, vcc_lo
	s_mov_b32 s4, exec_lo
	global_load_b32 v4, v[4:5], off
	v_dual_mov_b32 v5, s8 :: v_dual_mov_b32 v6, s9
	v_dual_mov_b32 v7, s10 :: v_dual_mov_b32 v8, s11
	s_clause 0xf
	scratch_store_b128 off, v[5:8], off
	scratch_store_b128 off, v[5:8], off offset:16
	scratch_store_b128 off, v[5:8], off offset:32
	scratch_store_b128 off, v[5:8], off offset:48
	scratch_store_b128 off, v[5:8], off offset:64
	scratch_store_b128 off, v[5:8], off offset:80
	scratch_store_b128 off, v[5:8], off offset:96
	scratch_store_b128 off, v[5:8], off offset:112
	scratch_store_b128 off, v[5:8], off offset:128
	scratch_store_b128 off, v[5:8], off offset:144
	scratch_store_b128 off, v[5:8], off offset:160
	scratch_store_b128 off, v[5:8], off offset:176
	scratch_store_b128 off, v[5:8], off offset:192
	scratch_store_b128 off, v[5:8], off offset:208
	scratch_store_b128 off, v[5:8], off offset:224
	scratch_store_b128 off, v[5:8], off offset:240
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v4
	s_cbranch_execz .LBB9_4
; %bb.2:                                ; %.lr.ph.preheader
	s_load_b128 s[12:15], s[0:1], 0x0
	s_wait_kmcnt 0x0
	v_add_co_u32 v2, vcc_lo, s14, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s15, v3, vcc_lo
	global_load_b32 v2, v[2:3], off
	s_wait_loadcnt 0x0
	v_add_co_u32 v2, s0, s12, v2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, s13, 0, s0
.LBB9_3:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	global_load_u8 v5, v[2:3], off
	v_add_nc_u32_e32 v4, -1, v4
	v_add_co_u32 v2, vcc_lo, v2, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_cmp_eq_u32_e64 s0, 0, v4
	s_or_b32 s8, s0, s8
	s_wait_loadcnt 0x0
	v_lshlrev_b32_e32 v5, 2, v5
	scratch_load_b32 v6, v5, off
	s_wait_loadcnt 0x0
	v_add_nc_u32_e32 v6, 1, v6
	scratch_store_b32 v5, v6, off
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB9_3
.LBB9_4:                                ; %Flow166
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v0, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s7, v1, vcc_lo
	global_load_u16 v0, v[0:1], off
	scratch_load_b32 v2, off, off
	s_wait_loadcnt 0x1
	v_lshlrev_b32_e32 v0, 8, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v0, s0, s2, v0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v1, null, s3, 0, s0
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_6
; %bb.5:
	global_atomic_add_u32 v[0:1], v2, off scope:SCOPE_DEV
.LBB9_6:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:4
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_8
; %bb.7:
	global_atomic_add_u32 v[0:1], v2, off offset:4 scope:SCOPE_DEV
.LBB9_8:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:8
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_10
; %bb.9:
	global_atomic_add_u32 v[0:1], v2, off offset:8 scope:SCOPE_DEV
.LBB9_10:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:12
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_12
; %bb.11:
	global_atomic_add_u32 v[0:1], v2, off offset:12 scope:SCOPE_DEV
.LBB9_12:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:16
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_14
; %bb.13:
	global_atomic_add_u32 v[0:1], v2, off offset:16 scope:SCOPE_DEV
.LBB9_14:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:20
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_16
; %bb.15:
	global_atomic_add_u32 v[0:1], v2, off offset:20 scope:SCOPE_DEV
.LBB9_16:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:24
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_18
; %bb.17:
	global_atomic_add_u32 v[0:1], v2, off offset:24 scope:SCOPE_DEV
.LBB9_18:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:28
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_20
; %bb.19:
	global_atomic_add_u32 v[0:1], v2, off offset:28 scope:SCOPE_DEV
.LBB9_20:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:32
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_22
; %bb.21:
	global_atomic_add_u32 v[0:1], v2, off offset:32 scope:SCOPE_DEV
.LBB9_22:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:36
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_24
; %bb.23:
	global_atomic_add_u32 v[0:1], v2, off offset:36 scope:SCOPE_DEV
.LBB9_24:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:40
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_26
; %bb.25:
	global_atomic_add_u32 v[0:1], v2, off offset:40 scope:SCOPE_DEV
.LBB9_26:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:44
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_28
; %bb.27:
	global_atomic_add_u32 v[0:1], v2, off offset:44 scope:SCOPE_DEV
.LBB9_28:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:48
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_30
; %bb.29:
	global_atomic_add_u32 v[0:1], v2, off offset:48 scope:SCOPE_DEV
.LBB9_30:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:52
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_32
; %bb.31:
	global_atomic_add_u32 v[0:1], v2, off offset:52 scope:SCOPE_DEV
.LBB9_32:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:56
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_34
; %bb.33:
	global_atomic_add_u32 v[0:1], v2, off offset:56 scope:SCOPE_DEV
.LBB9_34:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:60
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_36
; %bb.35:
	global_atomic_add_u32 v[0:1], v2, off offset:60 scope:SCOPE_DEV
.LBB9_36:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:64
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_38
; %bb.37:
	global_atomic_add_u32 v[0:1], v2, off offset:64 scope:SCOPE_DEV
.LBB9_38:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:68
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_40
; %bb.39:
	global_atomic_add_u32 v[0:1], v2, off offset:68 scope:SCOPE_DEV
.LBB9_40:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:72
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_42
; %bb.41:
	global_atomic_add_u32 v[0:1], v2, off offset:72 scope:SCOPE_DEV
.LBB9_42:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:76
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_44
; %bb.43:
	global_atomic_add_u32 v[0:1], v2, off offset:76 scope:SCOPE_DEV
.LBB9_44:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:80
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_46
; %bb.45:
	global_atomic_add_u32 v[0:1], v2, off offset:80 scope:SCOPE_DEV
.LBB9_46:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:84
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_48
; %bb.47:
	global_atomic_add_u32 v[0:1], v2, off offset:84 scope:SCOPE_DEV
.LBB9_48:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:88
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_50
; %bb.49:
	global_atomic_add_u32 v[0:1], v2, off offset:88 scope:SCOPE_DEV
.LBB9_50:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:92
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_52
; %bb.51:
	global_atomic_add_u32 v[0:1], v2, off offset:92 scope:SCOPE_DEV
.LBB9_52:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:96
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_54
; %bb.53:
	global_atomic_add_u32 v[0:1], v2, off offset:96 scope:SCOPE_DEV
.LBB9_54:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:100
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_56
; %bb.55:
	global_atomic_add_u32 v[0:1], v2, off offset:100 scope:SCOPE_DEV
.LBB9_56:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:104
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_58
; %bb.57:
	global_atomic_add_u32 v[0:1], v2, off offset:104 scope:SCOPE_DEV
.LBB9_58:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:108
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_60
; %bb.59:
	global_atomic_add_u32 v[0:1], v2, off offset:108 scope:SCOPE_DEV
.LBB9_60:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:112
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_62
; %bb.61:
	global_atomic_add_u32 v[0:1], v2, off offset:112 scope:SCOPE_DEV
.LBB9_62:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:116
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_64
; %bb.63:
	global_atomic_add_u32 v[0:1], v2, off offset:116 scope:SCOPE_DEV
.LBB9_64:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:120
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_66
; %bb.65:
	global_atomic_add_u32 v[0:1], v2, off offset:120 scope:SCOPE_DEV
.LBB9_66:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:124
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_68
; %bb.67:
	global_atomic_add_u32 v[0:1], v2, off offset:124 scope:SCOPE_DEV
.LBB9_68:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:128
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_70
; %bb.69:
	global_atomic_add_u32 v[0:1], v2, off offset:128 scope:SCOPE_DEV
.LBB9_70:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:132
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_72
; %bb.71:
	global_atomic_add_u32 v[0:1], v2, off offset:132 scope:SCOPE_DEV
.LBB9_72:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:136
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_74
; %bb.73:
	global_atomic_add_u32 v[0:1], v2, off offset:136 scope:SCOPE_DEV
.LBB9_74:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:140
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_76
; %bb.75:
	global_atomic_add_u32 v[0:1], v2, off offset:140 scope:SCOPE_DEV
.LBB9_76:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:144
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_78
; %bb.77:
	global_atomic_add_u32 v[0:1], v2, off offset:144 scope:SCOPE_DEV
.LBB9_78:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:148
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_80
; %bb.79:
	global_atomic_add_u32 v[0:1], v2, off offset:148 scope:SCOPE_DEV
.LBB9_80:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:152
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_82
; %bb.81:
	global_atomic_add_u32 v[0:1], v2, off offset:152 scope:SCOPE_DEV
.LBB9_82:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:156
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_84
; %bb.83:
	global_atomic_add_u32 v[0:1], v2, off offset:156 scope:SCOPE_DEV
.LBB9_84:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:160
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_86
; %bb.85:
	global_atomic_add_u32 v[0:1], v2, off offset:160 scope:SCOPE_DEV
.LBB9_86:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:164
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_88
; %bb.87:
	global_atomic_add_u32 v[0:1], v2, off offset:164 scope:SCOPE_DEV
.LBB9_88:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:168
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_90
; %bb.89:
	global_atomic_add_u32 v[0:1], v2, off offset:168 scope:SCOPE_DEV
.LBB9_90:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:172
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_92
; %bb.91:
	global_atomic_add_u32 v[0:1], v2, off offset:172 scope:SCOPE_DEV
.LBB9_92:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:176
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_94
; %bb.93:
	global_atomic_add_u32 v[0:1], v2, off offset:176 scope:SCOPE_DEV
.LBB9_94:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:180
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_96
; %bb.95:
	global_atomic_add_u32 v[0:1], v2, off offset:180 scope:SCOPE_DEV
.LBB9_96:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:184
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_98
; %bb.97:
	global_atomic_add_u32 v[0:1], v2, off offset:184 scope:SCOPE_DEV
.LBB9_98:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:188
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_100
; %bb.99:
	global_atomic_add_u32 v[0:1], v2, off offset:188 scope:SCOPE_DEV
.LBB9_100:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:192
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_102
; %bb.101:
	global_atomic_add_u32 v[0:1], v2, off offset:192 scope:SCOPE_DEV
.LBB9_102:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:196
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_104
; %bb.103:
	global_atomic_add_u32 v[0:1], v2, off offset:196 scope:SCOPE_DEV
.LBB9_104:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:200
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_106
; %bb.105:
	global_atomic_add_u32 v[0:1], v2, off offset:200 scope:SCOPE_DEV
.LBB9_106:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:204
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_108
; %bb.107:
	global_atomic_add_u32 v[0:1], v2, off offset:204 scope:SCOPE_DEV
.LBB9_108:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:208
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_110
; %bb.109:
	global_atomic_add_u32 v[0:1], v2, off offset:208 scope:SCOPE_DEV
.LBB9_110:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:212
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_112
; %bb.111:
	global_atomic_add_u32 v[0:1], v2, off offset:212 scope:SCOPE_DEV
.LBB9_112:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:216
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_114
; %bb.113:
	global_atomic_add_u32 v[0:1], v2, off offset:216 scope:SCOPE_DEV
.LBB9_114:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:220
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_116
; %bb.115:
	global_atomic_add_u32 v[0:1], v2, off offset:220 scope:SCOPE_DEV
.LBB9_116:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:224
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_118
; %bb.117:
	global_atomic_add_u32 v[0:1], v2, off offset:224 scope:SCOPE_DEV
.LBB9_118:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:228
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_120
; %bb.119:
	global_atomic_add_u32 v[0:1], v2, off offset:228 scope:SCOPE_DEV
.LBB9_120:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:232
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_122
; %bb.121:
	global_atomic_add_u32 v[0:1], v2, off offset:232 scope:SCOPE_DEV
.LBB9_122:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:236
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_124
; %bb.123:
	global_atomic_add_u32 v[0:1], v2, off offset:236 scope:SCOPE_DEV
.LBB9_124:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:240
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_126
; %bb.125:
	global_atomic_add_u32 v[0:1], v2, off offset:240 scope:SCOPE_DEV
.LBB9_126:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:244
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_128
; %bb.127:
	global_atomic_add_u32 v[0:1], v2, off offset:244 scope:SCOPE_DEV
.LBB9_128:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:248
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB9_130
; %bb.129:
	global_atomic_add_u32 v[0:1], v2, off offset:248 scope:SCOPE_DEV
.LBB9_130:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	scratch_load_b32 v2, off, off offset:252
	s_wait_loadcnt 0x0
	v_cmp_ne_u32_e32 vcc_lo, 0, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB9_132
; %bb.131:
	global_atomic_add_u32 v[0:1], v2, off offset:252 scope:SCOPE_DEV
.LBB9_132:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z6k_histPKhPKjS2_PKtPii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 272
		.amdhsa_kernarg_size 304
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 9
		.amdhsa_next_free_sgpr 16
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 29
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end9:
	.size	_Z6k_histPKhPKjS2_PKtPii, .Lfunc_end9-_Z6k_histPKhPKjS2_PKtPii
                                        ; -- End function
	.set _Z6k_histPKhPKjS2_PKtPii.num_vgpr, 9
	.set _Z6k_histPKhPKjS2_PKtPii.num_agpr, 0
	.set _Z6k_histPKhPKjS2_PKtPii.numbered_sgpr, 16
	.set _Z6k_histPKhPKjS2_PKtPii.num_named_barrier, 0
	.set _Z6k_histPKhPKjS2_PKtPii.private_seg_size, 272
	.set _Z6k_histPKhPKjS2_PKtPii.uses_vcc, 1
	.set _Z6k_histPKhPKjS2_PKtPii.uses_flat_scratch, 1
	.set _Z6k_histPKhPKjS2_PKtPii.has_dyn_sized_stack, 0
	.set _Z6k_histPKhPKjS2_PKtPii.has_recursion, 0
	.set _Z6k_histPKhPKjS2_PKtPii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3692
; TotalNumSgprs: 18
; NumVgprs: 9
; ScratchSize: 272
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 9
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 1
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z6k_poolPKiPiii        ; -- Begin function _Z6k_poolPKiPiii
	.globl	_Z6k_poolPKiPiii
	.p2align	8
	.type	_Z6k_poolPKiPiii,@function
_Z6k_poolPKiPiii:                       ; @_Z6k_poolPKiPiii
; %bb.0:
	s_clause 0x1
	s_load_b32 s4, s[0:1], 0x24
	s_load_b64 s[2:3], s[0:1], 0x10
	s_wait_kmcnt 0x0
	s_and_b32 s4, s4, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s4, v[0:1]
	s_mov_b32 s4, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB10_6
; %bb.1:                                ; %.preheader
	s_load_b64 s[8:9], s[0:1], 0x8
	v_ashrrev_i32_e32 v1, 31, v0
	s_mov_b32 s4, 0
	s_wait_alu 0xfffe
	s_mov_b32 s7, s4
	s_mov_b32 s5, s4
	v_lshlrev_b64_e32 v[3:4], 8, v[0:1]
	s_mov_b32 s6, s4
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_dual_mov_b32 v8, s7 :: v_dual_mov_b32 v7, s6
	s_wait_alu 0xfffe
	v_dual_mov_b32 v6, s5 :: v_dual_mov_b32 v5, s4
	s_wait_kmcnt 0x0
	v_add_co_u32 v1, vcc_lo, s8, v3
	v_add_co_ci_u32_e64 v2, null, s9, v4, vcc_lo
	v_cmp_gt_i32_e32 vcc_lo, s2, v0
	s_clause 0xf
	global_store_b128 v[1:2], v[5:8], off
	global_store_b128 v[1:2], v[5:8], off offset:16
	global_store_b128 v[1:2], v[5:8], off offset:32
	global_store_b128 v[1:2], v[5:8], off offset:48
	global_store_b128 v[1:2], v[5:8], off offset:64
	global_store_b128 v[1:2], v[5:8], off offset:80
	global_store_b128 v[1:2], v[5:8], off offset:96
	global_store_b128 v[1:2], v[5:8], off offset:112
	global_store_b128 v[1:2], v[5:8], off offset:128
	global_store_b128 v[1:2], v[5:8], off offset:144
	global_store_b128 v[1:2], v[5:8], off offset:160
	global_store_b128 v[1:2], v[5:8], off offset:176
	global_store_b128 v[1:2], v[5:8], off offset:192
	global_store_b128 v[1:2], v[5:8], off offset:208
	global_store_b128 v[1:2], v[5:8], off offset:224
	global_store_b128 v[1:2], v[5:8], off offset:240
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB10_6
; %bb.2:                                ; %.lr.ph.preheader
	s_load_b64 s[0:1], s[0:1], 0x0
	s_wait_kmcnt 0x0
	v_add_co_u32 v3, vcc_lo, s0, v3
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v4, null, s1, v4, vcc_lo
	s_ashr_i32 s1, s3, 31
	s_mov_b32 s0, s3
	s_wait_alu 0xfffe
	s_lshl_b64 s[6:7], s[0:1], 8
.LBB10_3:                               ; %.lr.ph
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB10_4 Depth 2
	s_mov_b64 s[0:1], 0
.LBB10_4:                               ;   Parent Loop BB10_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_wait_alu 0xfffe
	v_add_co_u32 v37, vcc_lo, v1, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v38, null, s1, v2, vcc_lo
	v_add_co_u32 v29, vcc_lo, v3, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v30, null, s1, v4, vcc_lo
	global_load_b128 v[5:8], v[37:38], off
	s_clause 0x1
	global_load_b128 v[9:12], v[29:30], off
	global_load_b128 v[13:16], v[29:30], off offset:16
	s_clause 0x1
	global_load_b128 v[17:20], v[37:38], off offset:16
	global_load_b128 v[21:24], v[37:38], off offset:32
	s_clause 0x1
	global_load_b128 v[25:28], v[29:30], off offset:32
	global_load_b128 v[29:32], v[29:30], off offset:48
	global_load_b128 v[33:36], v[37:38], off offset:48
	s_add_nc_u64 s[0:1], s[0:1], 64
	s_wait_alu 0xfffe
	s_cmp_eq_u32 s0, 0x100
	s_wait_loadcnt 0x6
	v_add_nc_u32_e32 v5, v5, v9
	v_add_nc_u32_e32 v6, v6, v10
	v_add_nc_u32_e32 v7, v7, v11
	v_add_nc_u32_e32 v8, v8, v12
	s_wait_loadcnt 0x4
	v_add_nc_u32_e32 v9, v17, v13
	v_add_nc_u32_e32 v10, v18, v14
	v_add_nc_u32_e32 v11, v19, v15
	v_add_nc_u32_e32 v12, v20, v16
	s_wait_loadcnt 0x2
	v_add_nc_u32_e32 v13, v21, v25
	v_add_nc_u32_e32 v14, v22, v26
	v_add_nc_u32_e32 v15, v23, v27
	v_add_nc_u32_e32 v16, v24, v28
	s_wait_loadcnt 0x0
	v_add_nc_u32_e32 v17, v33, v29
	v_add_nc_u32_e32 v18, v34, v30
	v_add_nc_u32_e32 v19, v35, v31
	v_add_nc_u32_e32 v20, v36, v32
	s_clause 0x3
	global_store_b128 v[37:38], v[5:8], off
	global_store_b128 v[37:38], v[9:12], off offset:16
	global_store_b128 v[37:38], v[13:16], off offset:32
	global_store_b128 v[37:38], v[17:20], off offset:48
	s_cbranch_scc0 .LBB10_4
; %bb.5:                                ;   in Loop: Header=BB10_3 Depth=1
	v_add_nc_u32_e32 v0, s3, v0
	v_add_co_u32 v3, s0, v3, s6
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v4, null, s7, v4, s0
	s_delay_alu instid0(VALU_DEP_3)
	v_cmp_le_i32_e32 vcc_lo, s2, v0
	s_or_b32 s4, vcc_lo, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB10_3
.LBB10_6:                               ; %.loopexit
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z6k_poolPKiPiii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 280
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 39
		.amdhsa_next_free_sgpr 10
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 6
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end10:
	.size	_Z6k_poolPKiPiii, .Lfunc_end10-_Z6k_poolPKiPiii
                                        ; -- End function
	.set _Z6k_poolPKiPiii.num_vgpr, 39
	.set _Z6k_poolPKiPiii.num_agpr, 0
	.set _Z6k_poolPKiPiii.numbered_sgpr, 10
	.set _Z6k_poolPKiPiii.num_named_barrier, 0
	.set _Z6k_poolPKiPiii.private_seg_size, 0
	.set _Z6k_poolPKiPiii.uses_vcc, 1
	.set _Z6k_poolPKiPiii.uses_flat_scratch, 0
	.set _Z6k_poolPKiPiii.has_dyn_sized_stack, 0
	.set _Z6k_poolPKiPiii.has_recursion, 0
	.set _Z6k_poolPKiPiii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 756
; TotalNumSgprs: 12
; NumVgprs: 39
; ScratchSize: 0
; MemoryBound: 1
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 12
; NumVGPRsForWavesPerEU: 39
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z6k_normPKiS0_Ptiii    ; -- Begin function _Z6k_normPKiS0_Ptiii
	.globl	_Z6k_normPKiS0_Ptiii
	.p2align	8
	.type	_Z6k_normPKiS0_Ptiii,@function
_Z6k_normPKiS0_Ptiii:                   ; @_Z6k_normPKiS0_Ptiii
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x34
	s_load_b96 s[8:10], s[0:1], 0x18
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[2:3], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s8, v2
	s_cbranch_execz .LBB11_406
; %bb.1:
	s_clause 0x1
	s_load_b128 s[4:7], s[0:1], 0x0
	s_load_b64 s[2:3], s[0:1], 0x10
	v_ashrrev_i32_e32 v3, 31, v2
	v_mov_b32_e32 v6, 0
	v_mov_b32_e32 v7, 0
	s_mov_b64 s[0:1], 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[4:5], 8, v[2:3]
	v_lshlrev_b64_e32 v[0:1], 6, v[2:3]
	s_wait_kmcnt 0x0
	v_add_co_u32 v4, vcc_lo, s4, v4
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v5, null, s5, v5, vcc_lo
.LBB11_2:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v20, vcc_lo, v4, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v21, null, s1, v5, vcc_lo
	s_add_nc_u64 s[0:1], s[0:1], 64
	s_clause 0x3
	global_load_b128 v[8:11], v[20:21], off
	global_load_b128 v[12:15], v[20:21], off offset:16
	global_load_b128 v[16:19], v[20:21], off offset:32
	global_load_b128 v[20:23], v[20:21], off offset:48
	s_wait_alu 0xfffe
	s_cmp_eq_u32 s0, 0x100
	s_wait_loadcnt 0x3
	v_ashrrev_i32_e32 v24, 31, v8
	v_add_co_u32 v6, vcc_lo, v6, v8
	v_ashrrev_i32_e32 v25, 31, v9
	v_ashrrev_i32_e32 v8, 31, v10
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v7, v24, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v9
	v_ashrrev_i32_e32 v9, 31, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v25, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v11
	s_wait_loadcnt 0x2
	v_ashrrev_i32_e32 v8, 31, v12
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v12
	v_ashrrev_i32_e32 v9, 31, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v13
	v_ashrrev_i32_e32 v8, 31, v14
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v14
	v_ashrrev_i32_e32 v9, 31, v15
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v15
	s_wait_loadcnt 0x1
	v_ashrrev_i32_e32 v8, 31, v16
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v16
	v_ashrrev_i32_e32 v9, 31, v17
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v17
	v_ashrrev_i32_e32 v8, 31, v18
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v18
	v_ashrrev_i32_e32 v9, 31, v19
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v19
	s_wait_loadcnt 0x0
	v_ashrrev_i32_e32 v8, 31, v20
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v20
	v_ashrrev_i32_e32 v9, 31, v21
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v21
	v_ashrrev_i32_e32 v8, 31, v22
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v22
	v_ashrrev_i32_e32 v9, 31, v23
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v7, null, v7, v8, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v23
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_cbranch_scc0 .LBB11_2
; %bb.3:
	s_ashr_i32 s1, s10, 31
	s_mov_b32 s0, s10
	s_wait_alu 0xfffe
	v_cmp_gt_u64_e32 vcc_lo, s[0:1], v[6:7]
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB11_5
; %bb.4:
	s_abs_i32 s1, s9
	s_wait_alu 0xfffe
	s_cvt_f32_u32 s4, s1
	s_sub_co_i32 s5, 0, s1
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v4, s4
	v_readfirstlane_b32 s4, v4
	v_sub_nc_u32_e32 v4, 0, v2
	s_mul_f32 s4, s4, 0x4f7ffffe
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_max_i32_e32 v2, v2, v4
	s_wait_alu 0xfffe
	s_cvt_u32_f32 s4, s4
	s_wait_alu 0xfffe
	s_delay_alu instid0(SALU_CYCLE_2)
	s_mul_i32 s5, s5, s4
	s_wait_alu 0xfffe
	s_mul_hi_u32 s5, s4, s5
	s_wait_alu 0xfffe
	s_add_co_i32 s4, s4, s5
	s_wait_alu 0xfffe
	v_mul_hi_u32 v4, v2, s4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v4, v4, s1
	v_sub_nc_u32_e32 v2, v2, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_subrev_nc_u32_e32 v4, s1, v2
	v_cmp_le_u32_e32 vcc_lo, s1, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v2, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_subrev_nc_u32_e32 v4, s1, v2
	v_cmp_le_u32_e32 vcc_lo, s1, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v2, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v2, v2, v3
	v_sub_nc_u32_e32 v2, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64_e32 v[2:3], 8, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v4, vcc_lo, s6, v2
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s7, v3, vcc_lo
.LBB11_5:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_mov_b32_e32 v2, 0
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v6, 0
	s_mov_b64 s[4:5], 0
.LBB11_6:                               ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_add_co_u32 v11, vcc_lo, v4, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v12, null, s5, v5, vcc_lo
	s_add_nc_u64 s[4:5], s[4:5], 32
	s_clause 0x1
	global_load_b128 v[7:10], v[11:12], off
	global_load_b128 v[11:14], v[11:12], off offset:16
	s_wait_alu 0xfffe
	s_cmp_eq_u32 s4, 0x100
	s_wait_loadcnt 0x1
	v_cmp_ne_u32_e64 s0, 0, v9
	v_ashrrev_i32_e32 v15, 31, v7
	v_ashrrev_i32_e32 v17, 31, v8
	v_ashrrev_i32_e32 v18, 31, v9
	v_cmp_ne_u32_e32 vcc_lo, 0, v7
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v19, 0, 1, s0
	s_wait_loadcnt 0x0
	v_cmp_ne_u32_e64 s0, 0, v11
	v_ashrrev_i32_e32 v20, 31, v10
	v_ashrrev_i32_e32 v21, 31, v11
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v16, 0, 1, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v22, 0, 1, s0
	v_cmp_ne_u32_e64 s0, 0, v13
	v_ashrrev_i32_e32 v23, 31, v12
	v_ashrrev_i32_e32 v24, 31, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v6, v16, vcc_lo
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v25, 0, 1, s0
	v_add_co_u32 v2, s0, v2, v7
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v15, s0
	v_cmp_ne_u32_e32 vcc_lo, 0, v10
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v2, s0, v2, v8
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v17, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v6, v19, vcc_lo
	v_add_co_u32 v2, s0, v2, v9
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v18, s0
	v_cmp_ne_u32_e32 vcc_lo, 0, v12
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v2, s0, v2, v10
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v20, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v6, v22, vcc_lo
	v_add_co_u32 v2, s0, v2, v11
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v21, s0
	v_cmp_ne_u32_e32 vcc_lo, 0, v14
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v2, s0, v2, v12
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v23, s0
	v_ashrrev_i32_e32 v26, 31, v14
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v2, s0, v2, v13
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, v3, v24, s0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v6, v25, vcc_lo
	v_add_co_u32 v2, vcc_lo, v2, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, v3, v26, vcc_lo
	s_cbranch_scc0 .LBB11_6
; %bb.7:
	v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
	s_mov_b32 s4, 0
	s_wait_alu 0xfffe
	s_mov_b32 s7, s4
	s_mov_b32 s5, s4
	s_mov_b32 s6, s4
	v_add_co_u32 v0, s0, s2, v0
	s_wait_alu 0xfffe
	v_dual_mov_b32 v10, s7 :: v_dual_mov_b32 v9, s6
	v_dual_mov_b32 v8, s5 :: v_dual_mov_b32 v7, s4
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v1, null, s3, v1, s0
	s_clause 0xf
	scratch_store_b128 off, v[7:10], off
	scratch_store_b128 off, v[7:10], off offset:16
	scratch_store_b128 off, v[7:10], off offset:32
	scratch_store_b128 off, v[7:10], off offset:48
	scratch_store_b128 off, v[7:10], off offset:64
	scratch_store_b128 off, v[7:10], off offset:80
	scratch_store_b128 off, v[7:10], off offset:96
	scratch_store_b128 off, v[7:10], off offset:112
	scratch_store_b128 off, v[7:10], off offset:128
	scratch_store_b128 off, v[7:10], off offset:144
	scratch_store_b128 off, v[7:10], off offset:160
	scratch_store_b128 off, v[7:10], off offset:176
	scratch_store_b128 off, v[7:10], off offset:192
	scratch_store_b128 off, v[7:10], off offset:208
	scratch_store_b128 off, v[7:10], off offset:224
	scratch_store_b128 off, v[7:10], off offset:240
	s_mov_b32 s0, exec_lo
	v_cmpx_ne_u64_e32 0, v[2:3]
	s_wait_alu 0xfffe
	s_xor_b32 s1, exec_lo, s0
	s_cbranch_execz .LBB11_404
; %bb.8:
	global_load_b32 v7, v[4:5], off
	v_sub_co_u32 v64, s0, 0x1000, v6
	v_mov_b32_e32 v8, 0
	s_wait_alu 0xf1ff
	v_sub_co_ci_u32_e64 v65, null, 0, 0, s0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v7
	s_cbranch_execz .LBB11_14
; %bb.9:
	v_ashrrev_i32_e32 v6, 31, v7
	v_mul_lo_u32 v9, v65, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v10, v64, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v7, 0
	v_add3_u32 v7, v7, v10, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_11
; %bb.10:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_11:                              ; %Flow492
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_13
; %bb.12:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_13:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off
.LBB11_14:                              ; %Flow493
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:4
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_20
; %bb.15:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_17
; %bb.16:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_17:                              ; %Flow490
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_19
; %bb.18:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_19:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:4
.LBB11_20:                              ; %Flow491
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:8
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_26
; %bb.21:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_23
; %bb.22:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_23:                              ; %Flow488
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_25
; %bb.24:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_25:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:8
.LBB11_26:                              ; %Flow489
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:12
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_32
; %bb.27:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_29
; %bb.28:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_29:                              ; %Flow486
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_31
; %bb.30:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_31:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:12
.LBB11_32:                              ; %Flow487
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:16
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_38
; %bb.33:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_35
; %bb.34:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_35:                              ; %Flow484
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_37
; %bb.36:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_37:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:16
.LBB11_38:                              ; %Flow485
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:20
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_44
; %bb.39:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_41
; %bb.40:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_41:                              ; %Flow482
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_43
; %bb.42:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_43:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:20
.LBB11_44:                              ; %Flow483
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:24
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_50
; %bb.45:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_47
; %bb.46:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_47:                              ; %Flow480
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_49
; %bb.48:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_49:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:24
.LBB11_50:                              ; %Flow481
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:28
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_56
; %bb.51:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_53
; %bb.52:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_53:                              ; %Flow478
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_55
; %bb.54:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_55:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:28
.LBB11_56:                              ; %Flow479
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:32
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_62
; %bb.57:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_59
; %bb.58:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_59:                              ; %Flow476
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_61
; %bb.60:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_61:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:32
.LBB11_62:                              ; %Flow477
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:36
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_68
; %bb.63:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_65
; %bb.64:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_65:                              ; %Flow474
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_67
; %bb.66:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_67:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:36
.LBB11_68:                              ; %Flow475
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:40
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_74
; %bb.69:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_71
; %bb.70:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_71:                              ; %Flow472
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_73
; %bb.72:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_73:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:40
.LBB11_74:                              ; %Flow473
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:44
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_80
; %bb.75:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_77
; %bb.76:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_77:                              ; %Flow470
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_79
; %bb.78:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_79:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:44
.LBB11_80:                              ; %Flow471
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:48
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_86
; %bb.81:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_83
; %bb.82:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_83:                              ; %Flow468
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_85
; %bb.84:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_85:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:48
.LBB11_86:                              ; %Flow469
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:52
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_92
; %bb.87:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_89
; %bb.88:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_89:                              ; %Flow466
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_91
; %bb.90:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_91:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:52
.LBB11_92:                              ; %Flow467
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:56
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_98
; %bb.93:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_95
; %bb.94:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_95:                              ; %Flow464
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_97
; %bb.96:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_97:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:56
.LBB11_98:                              ; %Flow465
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v6, v[4:5], off offset:60
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB11_104
; %bb.99:
	v_ashrrev_i32_e32 v8, 31, v6
	v_mul_lo_u32 v9, v65, v6
	v_mad_co_u64_u32 v[6:7], null, v64, v6, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v8
	v_add3_u32 v7, v7, v8, v9
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_101
; %bb.100:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_101:                             ; %Flow462
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_103
; %bb.102:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_103:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:60
.LBB11_104:                             ; %Flow463
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v8, v[4:5], off offset:64
	v_mov_b32_e32 v6, 0
	v_mov_b32_e32 v7, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v8
	s_cbranch_execz .LBB11_110
; %bb.105:
	v_ashrrev_i32_e32 v9, 31, v8
	v_mul_lo_u32 v10, v65, v8
	v_mad_co_u64_u32 v[6:7], null, v64, v8, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v8, v64, v9
	v_add3_u32 v7, v7, v8, v10
	v_mov_b32_e32 v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v9, v7, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[8:9]
                                        ; implicit-def: $vgpr8_vgpr9
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_107
; %bb.106:
	v_cvt_f32_u32_e32 v8, v2
	v_cvt_f32_u32_e32 v9, v3
	v_sub_co_u32 v15, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v16, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v8, v9, 0x4f800000, v8
	v_rcp_f32_e32 v8, v8
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v8, 0x5f7ffffc, v8
	v_mul_f32_e32 v9, 0x2f800000, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v9, v9
	v_fmamk_f32 v8, v9, 0xcf800000, v8
	v_cvt_u32_f32_e32 v17, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v18, v8
	v_mul_lo_u32 v10, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v11, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_add3_u32 v13, v9, v10, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v19, v18, v8
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v8, vcc_lo, v19, v9
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, v17, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v10, v16, v18
	v_mad_co_u64_u32 v[8:9], null, v15, v18, 0
	v_mul_lo_u32 v11, v15, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v15, v18, v8
	v_add3_u32 v13, v9, v11, v10
	v_mad_co_u64_u32 v[11:12], null, v17, v8, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[9:10], null, v18, v13, 0
	v_mad_co_u64_u32 v[13:14], null, v17, v13, 0
	v_add_co_u32 v8, vcc_lo, v15, v9
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v10, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v12, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v14, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v10, vcc_lo, v18, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v12, null, v17, v9, vcc_lo
	v_mul_hi_u32 v14, v6, v10
	v_mad_co_u64_u32 v[10:11], null, v7, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[8:9], null, v6, v12, 0
	v_mad_co_u64_u32 v[12:13], null, v7, v12, 0
	v_add_co_u32 v8, vcc_lo, v14, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_add_co_u32 v8, vcc_lo, v8, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v8, vcc_lo, v9, v11, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v9, vcc_lo, 0, v13, vcc_lo
	v_add_co_u32 v10, vcc_lo, v8, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo
	v_mul_lo_u32 v12, v3, v10
	v_mad_co_u64_u32 v[8:9], null, v2, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v13, v2, v11
	v_sub_co_u32 v6, vcc_lo, v6, v8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v9, v9, v13, v12
	v_sub_nc_u32_e32 v12, v7, v9
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v8, null, v12, v3, vcc_lo
	v_add_co_u32 v12, s0, v10, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v13, null, 0, v11, s0
	v_sub_co_u32 v13, s0, v6, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v8, null, 0, v8, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v13, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v8, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v13, v9, vcc_lo
	v_add_co_u32 v9, vcc_lo, v10, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v7, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v6, v14, v6, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v7, v9, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v6
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v10, v7, vcc_lo
                                        ; implicit-def: $vgpr6_vgpr7
.LBB11_107:                             ; %Flow460
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_109
; %bb.108:
	v_cvt_f32_u32_e32 v7, v2
	v_sub_nc_u32_e32 v8, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v7, v7
	v_mul_f32_e32 v7, 0x4f7ffffe, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v7, v7
	v_mul_lo_u32 v8, v8, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v8, v7, v8
	v_add_nc_u32_e32 v7, v7, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v7, v6, v7
	v_mul_lo_u32 v8, v7, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v6, v6, v8
	v_add_nc_u32_e32 v8, 1, v7
	v_sub_nc_u32_e32 v9, v6, v2
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v6, v6, v9 :: v_dual_cndmask_b32 v7, v7, v8
	v_cmp_ge_u32_e32 vcc_lo, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v8, 1, v7
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v7, v8, vcc_lo
.LBB11_109:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v7, 0 :: v_dual_add_nc_u32 v6, 1, v8
	scratch_store_b32 off, v6, off offset:64
.LBB11_110:                             ; %Flow461
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v10, v[4:5], off offset:68
	v_mov_b32_e32 v8, 0
	v_mov_b32_e32 v9, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v10
	s_cbranch_execz .LBB11_116
; %bb.111:
	v_ashrrev_i32_e32 v11, 31, v10
	v_mul_lo_u32 v12, v65, v10
	v_mad_co_u64_u32 v[8:9], null, v64, v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v10, v64, v11
	v_add3_u32 v9, v9, v10, v12
	v_mov_b32_e32 v10, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v11, v9, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[10:11]
                                        ; implicit-def: $vgpr10_vgpr11
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_113
; %bb.112:
	v_cvt_f32_u32_e32 v10, v2
	v_cvt_f32_u32_e32 v11, v3
	v_sub_co_u32 v17, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v18, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v10, v11, 0x4f800000, v10
	v_rcp_f32_e32 v10, v10
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v10, 0x5f7ffffc, v10
	v_mul_f32_e32 v11, 0x2f800000, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v11, v11
	v_fmamk_f32 v10, v11, 0xcf800000, v10
	v_cvt_u32_f32_e32 v19, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v20, v10
	v_mul_lo_u32 v12, v17, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v13, v18, v20
	v_mad_co_u64_u32 v[10:11], null, v17, v20, 0
	v_add3_u32 v15, v11, v12, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v21, v20, v10
	v_mad_co_u64_u32 v[13:14], null, v19, v10, 0
	v_mad_co_u64_u32 v[11:12], null, v20, v15, 0
	v_mad_co_u64_u32 v[15:16], null, v19, v15, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v10, vcc_lo, v21, v11
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v12, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v10, vcc_lo, v10, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v10, vcc_lo, v11, v14, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v11, vcc_lo, 0, v16, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v10, vcc_lo, v10, v15
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v20, vcc_lo, v20, v10
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v19, null, v19, v11, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v12, v18, v20
	v_mad_co_u64_u32 v[10:11], null, v17, v20, 0
	v_mul_lo_u32 v13, v17, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v17, v20, v10
	v_add3_u32 v15, v11, v13, v12
	v_mad_co_u64_u32 v[13:14], null, v19, v10, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[11:12], null, v20, v15, 0
	v_mad_co_u64_u32 v[15:16], null, v19, v15, 0
	v_add_co_u32 v10, vcc_lo, v17, v11
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v12, vcc_lo
	v_add_co_u32 v10, vcc_lo, v10, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v10, vcc_lo, v11, v14, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v11, vcc_lo, 0, v16, vcc_lo
	v_add_co_u32 v10, vcc_lo, v10, v15
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_add_co_u32 v12, vcc_lo, v20, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v14, null, v19, v11, vcc_lo
	v_mul_hi_u32 v16, v8, v12
	v_mad_co_u64_u32 v[12:13], null, v9, v12, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[10:11], null, v8, v14, 0
	v_mad_co_u64_u32 v[14:15], null, v9, v14, 0
	v_add_co_u32 v10, vcc_lo, v16, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v11, null, 0, v11, vcc_lo
	v_add_co_u32 v10, vcc_lo, v10, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v10, vcc_lo, v11, v13, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v11, vcc_lo, 0, v15, vcc_lo
	v_add_co_u32 v12, vcc_lo, v10, v14
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v13, null, 0, v11, vcc_lo
	v_mul_lo_u32 v14, v3, v12
	v_mad_co_u64_u32 v[10:11], null, v2, v12, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v15, v2, v13
	v_sub_co_u32 v8, vcc_lo, v8, v10
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v11, v11, v15, v14
	v_sub_nc_u32_e32 v14, v9, v11
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v9, null, v9, v11, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v10, null, v14, v3, vcc_lo
	v_add_co_u32 v14, s0, v12, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v15, null, 0, v13, s0
	v_sub_co_u32 v15, s0, v8, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v10, null, 0, v10, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v15, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v11, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v10, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v15, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v8, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v8, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v9, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v16, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v10, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v10, v15, v11, vcc_lo
	v_add_co_u32 v11, vcc_lo, v12, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v13, null, 0, v13, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v9, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v8, v16, v8, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v10
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v9, v11, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v8
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v10, v12, v9, vcc_lo
                                        ; implicit-def: $vgpr8_vgpr9
.LBB11_113:                             ; %Flow458
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_115
; %bb.114:
	v_cvt_f32_u32_e32 v9, v2
	v_sub_nc_u32_e32 v10, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v9, v9
	v_mul_f32_e32 v9, 0x4f7ffffe, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v9, v9
	v_mul_lo_u32 v10, v10, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v10, v9, v10
	v_add_nc_u32_e32 v9, v9, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v9, v8, v9
	v_mul_lo_u32 v10, v9, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v8, v8, v10
	v_add_nc_u32_e32 v10, 1, v9
	v_sub_nc_u32_e32 v11, v8, v2
	v_cmp_ge_u32_e32 vcc_lo, v8, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v8, v8, v11 :: v_dual_cndmask_b32 v9, v9, v10
	v_cmp_ge_u32_e32 vcc_lo, v8, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v10, 1, v9
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v10, v9, v10, vcc_lo
.LBB11_115:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v9, 0 :: v_dual_add_nc_u32 v8, 1, v10
	scratch_store_b32 off, v8, off offset:68
.LBB11_116:                             ; %Flow459
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v12, v[4:5], off offset:72
	v_mov_b32_e32 v10, 0
	v_mov_b32_e32 v11, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB11_122
; %bb.117:
	v_ashrrev_i32_e32 v13, 31, v12
	v_mul_lo_u32 v14, v65, v12
	v_mad_co_u64_u32 v[10:11], null, v64, v12, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v12, v64, v13
	v_add3_u32 v11, v11, v12, v14
	v_mov_b32_e32 v12, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v13, v11, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[12:13]
                                        ; implicit-def: $vgpr12_vgpr13
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_119
; %bb.118:
	v_cvt_f32_u32_e32 v12, v2
	v_cvt_f32_u32_e32 v13, v3
	v_sub_co_u32 v19, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v20, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v12, v13, 0x4f800000, v12
	v_rcp_f32_e32 v12, v12
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v12, 0x5f7ffffc, v12
	v_mul_f32_e32 v13, 0x2f800000, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v13, v13
	v_fmamk_f32 v12, v13, 0xcf800000, v12
	v_cvt_u32_f32_e32 v21, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v22, v12
	v_mul_lo_u32 v14, v19, v21
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v15, v20, v22
	v_mad_co_u64_u32 v[12:13], null, v19, v22, 0
	v_add3_u32 v17, v13, v14, v15
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v23, v22, v12
	v_mad_co_u64_u32 v[15:16], null, v21, v12, 0
	v_mad_co_u64_u32 v[13:14], null, v22, v17, 0
	v_mad_co_u64_u32 v[17:18], null, v21, v17, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v12, vcc_lo, v23, v13
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v13, null, 0, v14, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v12, vcc_lo, v12, v15
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v12, vcc_lo, v13, v16, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v13, vcc_lo, 0, v18, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v12, vcc_lo, v12, v17
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v13, null, 0, v13, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v22, vcc_lo, v22, v12
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v21, null, v21, v13, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v14, v20, v22
	v_mad_co_u64_u32 v[12:13], null, v19, v22, 0
	v_mul_lo_u32 v15, v19, v21
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v19, v22, v12
	v_add3_u32 v17, v13, v15, v14
	v_mad_co_u64_u32 v[15:16], null, v21, v12, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[13:14], null, v22, v17, 0
	v_mad_co_u64_u32 v[17:18], null, v21, v17, 0
	v_add_co_u32 v12, vcc_lo, v19, v13
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v13, null, 0, v14, vcc_lo
	v_add_co_u32 v12, vcc_lo, v12, v15
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v12, vcc_lo, v13, v16, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v13, vcc_lo, 0, v18, vcc_lo
	v_add_co_u32 v12, vcc_lo, v12, v17
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v13, null, 0, v13, vcc_lo
	v_add_co_u32 v14, vcc_lo, v22, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v16, null, v21, v13, vcc_lo
	v_mul_hi_u32 v18, v10, v14
	v_mad_co_u64_u32 v[14:15], null, v11, v14, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[12:13], null, v10, v16, 0
	v_mad_co_u64_u32 v[16:17], null, v11, v16, 0
	v_add_co_u32 v12, vcc_lo, v18, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v13, null, 0, v13, vcc_lo
	v_add_co_u32 v12, vcc_lo, v12, v14
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v12, vcc_lo, v13, v15, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v13, vcc_lo, 0, v17, vcc_lo
	v_add_co_u32 v14, vcc_lo, v12, v16
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v15, null, 0, v13, vcc_lo
	v_mul_lo_u32 v16, v3, v14
	v_mad_co_u64_u32 v[12:13], null, v2, v14, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v17, v2, v15
	v_sub_co_u32 v10, vcc_lo, v10, v12
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v13, v13, v17, v16
	v_sub_nc_u32_e32 v16, v11, v13
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v11, null, v11, v13, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v12, null, v16, v3, vcc_lo
	v_add_co_u32 v16, s0, v14, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v17, null, 0, v15, s0
	v_sub_co_u32 v17, s0, v10, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v12, null, 0, v12, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v17, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v12, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v17, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v10, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v11, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v18, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v12, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v12, v17, v13, vcc_lo
	v_add_co_u32 v13, vcc_lo, v14, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v15, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v11, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v10, v18, v10, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v12
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v11, v13, v16, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v10
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v12, v14, v11, vcc_lo
                                        ; implicit-def: $vgpr10_vgpr11
.LBB11_119:                             ; %Flow456
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_121
; %bb.120:
	v_cvt_f32_u32_e32 v11, v2
	v_sub_nc_u32_e32 v12, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v11, v11
	v_mul_f32_e32 v11, 0x4f7ffffe, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v11, v11
	v_mul_lo_u32 v12, v12, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v12, v11, v12
	v_add_nc_u32_e32 v11, v11, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v11, v10, v11
	v_mul_lo_u32 v12, v11, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v10, v10, v12
	v_add_nc_u32_e32 v12, 1, v11
	v_sub_nc_u32_e32 v13, v10, v2
	v_cmp_ge_u32_e32 vcc_lo, v10, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v10, v10, v13 :: v_dual_cndmask_b32 v11, v11, v12
	v_cmp_ge_u32_e32 vcc_lo, v10, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, 1, v11
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v12, v11, v12, vcc_lo
.LBB11_121:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v11, 0 :: v_dual_add_nc_u32 v10, 1, v12
	scratch_store_b32 off, v10, off offset:72
.LBB11_122:                             ; %Flow457
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v14, v[4:5], off offset:76
	v_mov_b32_e32 v12, 0
	v_mov_b32_e32 v13, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v14
	s_cbranch_execz .LBB11_128
; %bb.123:
	v_ashrrev_i32_e32 v15, 31, v14
	v_mul_lo_u32 v16, v65, v14
	v_mad_co_u64_u32 v[12:13], null, v64, v14, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v14, v64, v15
	v_add3_u32 v13, v13, v14, v16
	v_mov_b32_e32 v14, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v15, v13, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[14:15]
                                        ; implicit-def: $vgpr14_vgpr15
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_125
; %bb.124:
	v_cvt_f32_u32_e32 v14, v2
	v_cvt_f32_u32_e32 v15, v3
	v_sub_co_u32 v21, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v22, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v14, v15, 0x4f800000, v14
	v_rcp_f32_e32 v14, v14
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v14, 0x5f7ffffc, v14
	v_mul_f32_e32 v15, 0x2f800000, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v15, v15
	v_fmamk_f32 v14, v15, 0xcf800000, v14
	v_cvt_u32_f32_e32 v23, v15
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v24, v14
	v_mul_lo_u32 v16, v21, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v17, v22, v24
	v_mad_co_u64_u32 v[14:15], null, v21, v24, 0
	v_add3_u32 v19, v15, v16, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v25, v24, v14
	v_mad_co_u64_u32 v[17:18], null, v23, v14, 0
	v_mad_co_u64_u32 v[15:16], null, v24, v19, 0
	v_mad_co_u64_u32 v[19:20], null, v23, v19, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v14, vcc_lo, v25, v15
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v16, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v14, vcc_lo, v14, v17
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v14, vcc_lo, v15, v18, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v15, vcc_lo, 0, v20, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v14, vcc_lo, v14, v19
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v15, null, 0, v15, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v24, vcc_lo, v24, v14
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v23, null, v23, v15, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v16, v22, v24
	v_mad_co_u64_u32 v[14:15], null, v21, v24, 0
	v_mul_lo_u32 v17, v21, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v21, v24, v14
	v_add3_u32 v19, v15, v17, v16
	v_mad_co_u64_u32 v[17:18], null, v23, v14, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[15:16], null, v24, v19, 0
	v_mad_co_u64_u32 v[19:20], null, v23, v19, 0
	v_add_co_u32 v14, vcc_lo, v21, v15
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v15, null, 0, v16, vcc_lo
	v_add_co_u32 v14, vcc_lo, v14, v17
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v14, vcc_lo, v15, v18, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v15, vcc_lo, 0, v20, vcc_lo
	v_add_co_u32 v14, vcc_lo, v14, v19
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v15, null, 0, v15, vcc_lo
	v_add_co_u32 v16, vcc_lo, v24, v14
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v18, null, v23, v15, vcc_lo
	v_mul_hi_u32 v20, v12, v16
	v_mad_co_u64_u32 v[16:17], null, v13, v16, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[14:15], null, v12, v18, 0
	v_mad_co_u64_u32 v[18:19], null, v13, v18, 0
	v_add_co_u32 v14, vcc_lo, v20, v14
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v15, null, 0, v15, vcc_lo
	v_add_co_u32 v14, vcc_lo, v14, v16
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v14, vcc_lo, v15, v17, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v15, vcc_lo, 0, v19, vcc_lo
	v_add_co_u32 v16, vcc_lo, v14, v18
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v17, null, 0, v15, vcc_lo
	v_mul_lo_u32 v18, v3, v16
	v_mad_co_u64_u32 v[14:15], null, v2, v16, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v19, v2, v17
	v_sub_co_u32 v12, vcc_lo, v12, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v15, v15, v19, v18
	v_sub_nc_u32_e32 v18, v13, v15
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v13, null, v13, v15, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v14, null, v18, v3, vcc_lo
	v_add_co_u32 v18, s0, v16, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v19, null, 0, v17, s0
	v_sub_co_u32 v19, s0, v12, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v14, null, 0, v14, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v19, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v15, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v14, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v19, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v12, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v12, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v13, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v20, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v14, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v14, v19, v15, vcc_lo
	v_add_co_u32 v15, vcc_lo, v16, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, 0, v17, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v13, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v12, v20, v12, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v14
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v13, v15, v18, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v12
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v14, v16, v13, vcc_lo
                                        ; implicit-def: $vgpr12_vgpr13
.LBB11_125:                             ; %Flow454
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_127
; %bb.126:
	v_cvt_f32_u32_e32 v13, v2
	v_sub_nc_u32_e32 v14, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v13, v13
	v_mul_f32_e32 v13, 0x4f7ffffe, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v13, v13
	v_mul_lo_u32 v14, v14, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v14, v13, v14
	v_add_nc_u32_e32 v13, v13, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v13, v12, v13
	v_mul_lo_u32 v14, v13, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v12, v12, v14
	v_add_nc_u32_e32 v14, 1, v13
	v_sub_nc_u32_e32 v15, v12, v2
	v_cmp_ge_u32_e32 vcc_lo, v12, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v12, v12, v15 :: v_dual_cndmask_b32 v13, v13, v14
	v_cmp_ge_u32_e32 vcc_lo, v12, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v14, 1, v13
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v14, v13, v14, vcc_lo
.LBB11_127:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v13, 0 :: v_dual_add_nc_u32 v12, 1, v14
	scratch_store_b32 off, v12, off offset:76
.LBB11_128:                             ; %Flow455
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v16, v[4:5], off offset:80
	v_mov_b32_e32 v14, 0
	v_mov_b32_e32 v15, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v16
	s_cbranch_execz .LBB11_134
; %bb.129:
	v_ashrrev_i32_e32 v17, 31, v16
	v_mul_lo_u32 v18, v65, v16
	v_mad_co_u64_u32 v[14:15], null, v64, v16, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v16, v64, v17
	v_add3_u32 v15, v15, v16, v18
	v_mov_b32_e32 v16, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v17, v15, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[16:17]
                                        ; implicit-def: $vgpr16_vgpr17
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_131
; %bb.130:
	v_cvt_f32_u32_e32 v16, v2
	v_cvt_f32_u32_e32 v17, v3
	v_sub_co_u32 v23, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v24, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v16, v17, 0x4f800000, v16
	v_rcp_f32_e32 v16, v16
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v16, 0x5f7ffffc, v16
	v_mul_f32_e32 v17, 0x2f800000, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v17, v17
	v_fmamk_f32 v16, v17, 0xcf800000, v16
	v_cvt_u32_f32_e32 v25, v17
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v26, v16
	v_mul_lo_u32 v18, v23, v25
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v19, v24, v26
	v_mad_co_u64_u32 v[16:17], null, v23, v26, 0
	v_add3_u32 v21, v17, v18, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v27, v26, v16
	v_mad_co_u64_u32 v[19:20], null, v25, v16, 0
	v_mad_co_u64_u32 v[17:18], null, v26, v21, 0
	v_mad_co_u64_u32 v[21:22], null, v25, v21, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v16, vcc_lo, v27, v17
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, 0, v18, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v16, vcc_lo, v16, v19
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v16, vcc_lo, v17, v20, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v17, vcc_lo, 0, v22, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v16, vcc_lo, v16, v21
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v17, null, 0, v17, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v26, vcc_lo, v26, v16
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v25, null, v25, v17, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v18, v24, v26
	v_mad_co_u64_u32 v[16:17], null, v23, v26, 0
	v_mul_lo_u32 v19, v23, v25
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v23, v26, v16
	v_add3_u32 v21, v17, v19, v18
	v_mad_co_u64_u32 v[19:20], null, v25, v16, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[17:18], null, v26, v21, 0
	v_mad_co_u64_u32 v[21:22], null, v25, v21, 0
	v_add_co_u32 v16, vcc_lo, v23, v17
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v17, null, 0, v18, vcc_lo
	v_add_co_u32 v16, vcc_lo, v16, v19
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v16, vcc_lo, v17, v20, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v17, vcc_lo, 0, v22, vcc_lo
	v_add_co_u32 v16, vcc_lo, v16, v21
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v17, null, 0, v17, vcc_lo
	v_add_co_u32 v18, vcc_lo, v26, v16
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v20, null, v25, v17, vcc_lo
	v_mul_hi_u32 v22, v14, v18
	v_mad_co_u64_u32 v[18:19], null, v15, v18, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[16:17], null, v14, v20, 0
	v_mad_co_u64_u32 v[20:21], null, v15, v20, 0
	v_add_co_u32 v16, vcc_lo, v22, v16
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v17, null, 0, v17, vcc_lo
	v_add_co_u32 v16, vcc_lo, v16, v18
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v16, vcc_lo, v17, v19, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v17, vcc_lo, 0, v21, vcc_lo
	v_add_co_u32 v18, vcc_lo, v16, v20
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v19, null, 0, v17, vcc_lo
	v_mul_lo_u32 v20, v3, v18
	v_mad_co_u64_u32 v[16:17], null, v2, v18, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v21, v2, v19
	v_sub_co_u32 v14, vcc_lo, v14, v16
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v17, v17, v21, v20
	v_sub_nc_u32_e32 v20, v15, v17
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v15, null, v15, v17, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v16, null, v20, v3, vcc_lo
	v_add_co_u32 v20, s0, v18, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v21, null, 0, v19, s0
	v_sub_co_u32 v21, s0, v14, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v16, null, 0, v16, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v21, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v17, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v16, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v21, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v14, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v14, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v15, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v22, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v16, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v16, v21, v17, vcc_lo
	v_add_co_u32 v17, vcc_lo, v18, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v19, null, 0, v19, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v15, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v14, v22, v14, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v16
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v15, v17, v20, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v14
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v16, v18, v15, vcc_lo
                                        ; implicit-def: $vgpr14_vgpr15
.LBB11_131:                             ; %Flow452
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_133
; %bb.132:
	v_cvt_f32_u32_e32 v15, v2
	v_sub_nc_u32_e32 v16, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v15, v15
	v_mul_f32_e32 v15, 0x4f7ffffe, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v15, v15
	v_mul_lo_u32 v16, v16, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v16, v15, v16
	v_add_nc_u32_e32 v15, v15, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v15, v14, v15
	v_mul_lo_u32 v16, v15, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v14, v14, v16
	v_add_nc_u32_e32 v16, 1, v15
	v_sub_nc_u32_e32 v17, v14, v2
	v_cmp_ge_u32_e32 vcc_lo, v14, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v14, v14, v17 :: v_dual_cndmask_b32 v15, v15, v16
	v_cmp_ge_u32_e32 vcc_lo, v14, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v16, 1, v15
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v16, v15, v16, vcc_lo
.LBB11_133:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v15, 0 :: v_dual_add_nc_u32 v14, 1, v16
	scratch_store_b32 off, v14, off offset:80
.LBB11_134:                             ; %Flow453
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v18, v[4:5], off offset:84
	v_mov_b32_e32 v16, 0
	v_mov_b32_e32 v17, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v18
	s_cbranch_execz .LBB11_140
; %bb.135:
	v_ashrrev_i32_e32 v19, 31, v18
	v_mul_lo_u32 v20, v65, v18
	v_mad_co_u64_u32 v[16:17], null, v64, v18, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v18, v64, v19
	v_add3_u32 v17, v17, v18, v20
	v_mov_b32_e32 v18, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v19, v17, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[18:19]
                                        ; implicit-def: $vgpr18_vgpr19
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_137
; %bb.136:
	v_cvt_f32_u32_e32 v18, v2
	v_cvt_f32_u32_e32 v19, v3
	v_sub_co_u32 v25, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v26, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v18, v19, 0x4f800000, v18
	v_rcp_f32_e32 v18, v18
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v18, 0x5f7ffffc, v18
	v_mul_f32_e32 v19, 0x2f800000, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v19, v19
	v_fmamk_f32 v18, v19, 0xcf800000, v18
	v_cvt_u32_f32_e32 v27, v19
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v28, v18
	v_mul_lo_u32 v20, v25, v27
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v21, v26, v28
	v_mad_co_u64_u32 v[18:19], null, v25, v28, 0
	v_add3_u32 v23, v19, v20, v21
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v29, v28, v18
	v_mad_co_u64_u32 v[21:22], null, v27, v18, 0
	v_mad_co_u64_u32 v[19:20], null, v28, v23, 0
	v_mad_co_u64_u32 v[23:24], null, v27, v23, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v18, vcc_lo, v29, v19
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v19, null, 0, v20, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v21
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v18, vcc_lo, v19, v22, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v19, vcc_lo, 0, v24, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, vcc_lo, v18, v23
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v19, null, 0, v19, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v28, vcc_lo, v28, v18
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v27, null, v27, v19, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v20, v26, v28
	v_mad_co_u64_u32 v[18:19], null, v25, v28, 0
	v_mul_lo_u32 v21, v25, v27
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v25, v28, v18
	v_add3_u32 v23, v19, v21, v20
	v_mad_co_u64_u32 v[21:22], null, v27, v18, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[19:20], null, v28, v23, 0
	v_mad_co_u64_u32 v[23:24], null, v27, v23, 0
	v_add_co_u32 v18, vcc_lo, v25, v19
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v19, null, 0, v20, vcc_lo
	v_add_co_u32 v18, vcc_lo, v18, v21
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v18, vcc_lo, v19, v22, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v19, vcc_lo, 0, v24, vcc_lo
	v_add_co_u32 v18, vcc_lo, v18, v23
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v19, null, 0, v19, vcc_lo
	v_add_co_u32 v20, vcc_lo, v28, v18
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v22, null, v27, v19, vcc_lo
	v_mul_hi_u32 v24, v16, v20
	v_mad_co_u64_u32 v[20:21], null, v17, v20, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[18:19], null, v16, v22, 0
	v_mad_co_u64_u32 v[22:23], null, v17, v22, 0
	v_add_co_u32 v18, vcc_lo, v24, v18
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v19, null, 0, v19, vcc_lo
	v_add_co_u32 v18, vcc_lo, v18, v20
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v18, vcc_lo, v19, v21, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v19, vcc_lo, 0, v23, vcc_lo
	v_add_co_u32 v20, vcc_lo, v18, v22
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v21, null, 0, v19, vcc_lo
	v_mul_lo_u32 v22, v3, v20
	v_mad_co_u64_u32 v[18:19], null, v2, v20, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v23, v2, v21
	v_sub_co_u32 v16, vcc_lo, v16, v18
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v19, v19, v23, v22
	v_sub_nc_u32_e32 v22, v17, v19
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v17, null, v17, v19, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v18, null, v22, v3, vcc_lo
	v_add_co_u32 v22, s0, v20, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v23, null, 0, v21, s0
	v_sub_co_u32 v23, s0, v16, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v18, null, 0, v18, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v23, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v19, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v18, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v16, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v16, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v17, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v18, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v18, v23, v19, vcc_lo
	v_add_co_u32 v19, vcc_lo, v20, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v21, null, 0, v21, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v17, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v16, v24, v16, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v18
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v17, v19, v22, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v16
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v18, v20, v17, vcc_lo
                                        ; implicit-def: $vgpr16_vgpr17
.LBB11_137:                             ; %Flow450
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_139
; %bb.138:
	v_cvt_f32_u32_e32 v17, v2
	v_sub_nc_u32_e32 v18, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v17, v17
	v_mul_f32_e32 v17, 0x4f7ffffe, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v17, v17
	v_mul_lo_u32 v18, v18, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v18, v17, v18
	v_add_nc_u32_e32 v17, v17, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v17, v16, v17
	v_mul_lo_u32 v18, v17, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v16, v16, v18
	v_add_nc_u32_e32 v18, 1, v17
	v_sub_nc_u32_e32 v19, v16, v2
	v_cmp_ge_u32_e32 vcc_lo, v16, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v16, v16, v19 :: v_dual_cndmask_b32 v17, v17, v18
	v_cmp_ge_u32_e32 vcc_lo, v16, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v18, 1, v17
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v18, v17, v18, vcc_lo
.LBB11_139:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v17, 0 :: v_dual_add_nc_u32 v16, 1, v18
	scratch_store_b32 off, v16, off offset:84
.LBB11_140:                             ; %Flow451
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v20, v[4:5], off offset:88
	v_mov_b32_e32 v18, 0
	v_mov_b32_e32 v19, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v20
	s_cbranch_execz .LBB11_146
; %bb.141:
	v_ashrrev_i32_e32 v21, 31, v20
	v_mul_lo_u32 v22, v65, v20
	v_mad_co_u64_u32 v[18:19], null, v64, v20, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v20, v64, v21
	v_add3_u32 v19, v19, v20, v22
	v_mov_b32_e32 v20, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v21, v19, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[20:21]
                                        ; implicit-def: $vgpr20_vgpr21
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_143
; %bb.142:
	v_cvt_f32_u32_e32 v20, v2
	v_cvt_f32_u32_e32 v21, v3
	v_sub_co_u32 v27, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v28, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v20, v21, 0x4f800000, v20
	v_rcp_f32_e32 v20, v20
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v20, 0x5f7ffffc, v20
	v_mul_f32_e32 v21, 0x2f800000, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v21, v21
	v_fmamk_f32 v20, v21, 0xcf800000, v20
	v_cvt_u32_f32_e32 v29, v21
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v30, v20
	v_mul_lo_u32 v22, v27, v29
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v23, v28, v30
	v_mad_co_u64_u32 v[20:21], null, v27, v30, 0
	v_add3_u32 v25, v21, v22, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v31, v30, v20
	v_mad_co_u64_u32 v[23:24], null, v29, v20, 0
	v_mad_co_u64_u32 v[21:22], null, v30, v25, 0
	v_mad_co_u64_u32 v[25:26], null, v29, v25, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v20, vcc_lo, v31, v21
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v21, null, 0, v22, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v20, vcc_lo, v20, v23
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v20, vcc_lo, v21, v24, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v21, vcc_lo, 0, v26, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v20, vcc_lo, v20, v25
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v21, null, 0, v21, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v30, vcc_lo, v30, v20
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v29, null, v29, v21, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v22, v28, v30
	v_mad_co_u64_u32 v[20:21], null, v27, v30, 0
	v_mul_lo_u32 v23, v27, v29
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v27, v30, v20
	v_add3_u32 v25, v21, v23, v22
	v_mad_co_u64_u32 v[23:24], null, v29, v20, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[21:22], null, v30, v25, 0
	v_mad_co_u64_u32 v[25:26], null, v29, v25, 0
	v_add_co_u32 v20, vcc_lo, v27, v21
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v21, null, 0, v22, vcc_lo
	v_add_co_u32 v20, vcc_lo, v20, v23
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v20, vcc_lo, v21, v24, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v21, vcc_lo, 0, v26, vcc_lo
	v_add_co_u32 v20, vcc_lo, v20, v25
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v21, null, 0, v21, vcc_lo
	v_add_co_u32 v22, vcc_lo, v30, v20
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v24, null, v29, v21, vcc_lo
	v_mul_hi_u32 v26, v18, v22
	v_mad_co_u64_u32 v[22:23], null, v19, v22, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[20:21], null, v18, v24, 0
	v_mad_co_u64_u32 v[24:25], null, v19, v24, 0
	v_add_co_u32 v20, vcc_lo, v26, v20
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v21, null, 0, v21, vcc_lo
	v_add_co_u32 v20, vcc_lo, v20, v22
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v20, vcc_lo, v21, v23, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v21, vcc_lo, 0, v25, vcc_lo
	v_add_co_u32 v22, vcc_lo, v20, v24
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v23, null, 0, v21, vcc_lo
	v_mul_lo_u32 v24, v3, v22
	v_mad_co_u64_u32 v[20:21], null, v2, v22, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v25, v2, v23
	v_sub_co_u32 v18, vcc_lo, v18, v20
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v21, v21, v25, v24
	v_sub_nc_u32_e32 v24, v19, v21
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v19, null, v19, v21, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v20, null, v24, v3, vcc_lo
	v_add_co_u32 v24, s0, v22, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v25, null, 0, v23, s0
	v_sub_co_u32 v25, s0, v18, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v20, null, 0, v20, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v25, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v21, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v20, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v18, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v18, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v19, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v20, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v20, v25, v21, vcc_lo
	v_add_co_u32 v21, vcc_lo, v22, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v23, null, 0, v23, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v19, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v18, v26, v18, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v20
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v19, v21, v24, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v18
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v20, v22, v19, vcc_lo
                                        ; implicit-def: $vgpr18_vgpr19
.LBB11_143:                             ; %Flow448
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_145
; %bb.144:
	v_cvt_f32_u32_e32 v19, v2
	v_sub_nc_u32_e32 v20, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v19, v19
	v_mul_f32_e32 v19, 0x4f7ffffe, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v19, v19
	v_mul_lo_u32 v20, v20, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v20, v19, v20
	v_add_nc_u32_e32 v19, v19, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v19, v18, v19
	v_mul_lo_u32 v20, v19, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v18, v18, v20
	v_add_nc_u32_e32 v20, 1, v19
	v_sub_nc_u32_e32 v21, v18, v2
	v_cmp_ge_u32_e32 vcc_lo, v18, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v18, v18, v21 :: v_dual_cndmask_b32 v19, v19, v20
	v_cmp_ge_u32_e32 vcc_lo, v18, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v20, 1, v19
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v20, v19, v20, vcc_lo
.LBB11_145:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v19, 0 :: v_dual_add_nc_u32 v18, 1, v20
	scratch_store_b32 off, v18, off offset:88
.LBB11_146:                             ; %Flow449
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v22, v[4:5], off offset:92
	v_mov_b32_e32 v20, 0
	v_mov_b32_e32 v21, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v22
	s_cbranch_execz .LBB11_152
; %bb.147:
	v_ashrrev_i32_e32 v23, 31, v22
	v_mul_lo_u32 v24, v65, v22
	v_mad_co_u64_u32 v[20:21], null, v64, v22, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v22, v64, v23
	v_add3_u32 v21, v21, v22, v24
	v_mov_b32_e32 v22, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v23, v21, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[22:23]
                                        ; implicit-def: $vgpr22_vgpr23
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_149
; %bb.148:
	v_cvt_f32_u32_e32 v22, v2
	v_cvt_f32_u32_e32 v23, v3
	v_sub_co_u32 v29, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v30, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v22, v23, 0x4f800000, v22
	v_rcp_f32_e32 v22, v22
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v22, 0x5f7ffffc, v22
	v_mul_f32_e32 v23, 0x2f800000, v22
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v23, v23
	v_fmamk_f32 v22, v23, 0xcf800000, v22
	v_cvt_u32_f32_e32 v31, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v32, v22
	v_mul_lo_u32 v24, v29, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v25, v30, v32
	v_mad_co_u64_u32 v[22:23], null, v29, v32, 0
	v_add3_u32 v27, v23, v24, v25
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v33, v32, v22
	v_mad_co_u64_u32 v[25:26], null, v31, v22, 0
	v_mad_co_u64_u32 v[23:24], null, v32, v27, 0
	v_mad_co_u64_u32 v[27:28], null, v31, v27, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v22, vcc_lo, v33, v23
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v23, null, 0, v24, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v22, vcc_lo, v22, v25
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v22, vcc_lo, v23, v26, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v23, vcc_lo, 0, v28, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v22, vcc_lo, v22, v27
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v23, null, 0, v23, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v32, vcc_lo, v32, v22
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v31, null, v31, v23, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v24, v30, v32
	v_mad_co_u64_u32 v[22:23], null, v29, v32, 0
	v_mul_lo_u32 v25, v29, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v29, v32, v22
	v_add3_u32 v27, v23, v25, v24
	v_mad_co_u64_u32 v[25:26], null, v31, v22, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[23:24], null, v32, v27, 0
	v_mad_co_u64_u32 v[27:28], null, v31, v27, 0
	v_add_co_u32 v22, vcc_lo, v29, v23
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v23, null, 0, v24, vcc_lo
	v_add_co_u32 v22, vcc_lo, v22, v25
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v22, vcc_lo, v23, v26, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v23, vcc_lo, 0, v28, vcc_lo
	v_add_co_u32 v22, vcc_lo, v22, v27
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v23, null, 0, v23, vcc_lo
	v_add_co_u32 v24, vcc_lo, v32, v22
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v26, null, v31, v23, vcc_lo
	v_mul_hi_u32 v28, v20, v24
	v_mad_co_u64_u32 v[24:25], null, v21, v24, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[22:23], null, v20, v26, 0
	v_mad_co_u64_u32 v[26:27], null, v21, v26, 0
	v_add_co_u32 v22, vcc_lo, v28, v22
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v23, null, 0, v23, vcc_lo
	v_add_co_u32 v22, vcc_lo, v22, v24
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v22, vcc_lo, v23, v25, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v23, vcc_lo, 0, v27, vcc_lo
	v_add_co_u32 v24, vcc_lo, v22, v26
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v25, null, 0, v23, vcc_lo
	v_mul_lo_u32 v26, v3, v24
	v_mad_co_u64_u32 v[22:23], null, v2, v24, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v27, v2, v25
	v_sub_co_u32 v20, vcc_lo, v20, v22
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v23, v23, v27, v26
	v_sub_nc_u32_e32 v26, v21, v23
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v21, null, v21, v23, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v22, null, v26, v3, vcc_lo
	v_add_co_u32 v26, s0, v24, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v27, null, 0, v25, s0
	v_sub_co_u32 v27, s0, v20, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v22, null, 0, v22, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v27, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v22, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v20, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v20, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v21, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v28, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v22, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v22, v27, v23, vcc_lo
	v_add_co_u32 v23, vcc_lo, v24, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v25, null, 0, v25, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v21, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v20, v28, v20, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v22
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v21, v23, v26, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v20
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v22, v24, v21, vcc_lo
                                        ; implicit-def: $vgpr20_vgpr21
.LBB11_149:                             ; %Flow446
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_151
; %bb.150:
	v_cvt_f32_u32_e32 v21, v2
	v_sub_nc_u32_e32 v22, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v21, v21
	v_mul_f32_e32 v21, 0x4f7ffffe, v21
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v21, v21
	v_mul_lo_u32 v22, v22, v21
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v22, v21, v22
	v_add_nc_u32_e32 v21, v21, v22
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v21, v20, v21
	v_mul_lo_u32 v22, v21, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v20, v20, v22
	v_add_nc_u32_e32 v22, 1, v21
	v_sub_nc_u32_e32 v23, v20, v2
	v_cmp_ge_u32_e32 vcc_lo, v20, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v20, v20, v23 :: v_dual_cndmask_b32 v21, v21, v22
	v_cmp_ge_u32_e32 vcc_lo, v20, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v22, 1, v21
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v22, v21, v22, vcc_lo
.LBB11_151:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v21, 0 :: v_dual_add_nc_u32 v20, 1, v22
	scratch_store_b32 off, v20, off offset:92
.LBB11_152:                             ; %Flow447
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v24, v[4:5], off offset:96
	v_mov_b32_e32 v22, 0
	v_mov_b32_e32 v23, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v24
	s_cbranch_execz .LBB11_158
; %bb.153:
	v_ashrrev_i32_e32 v25, 31, v24
	v_mul_lo_u32 v26, v65, v24
	v_mad_co_u64_u32 v[22:23], null, v64, v24, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v24, v64, v25
	v_add3_u32 v23, v23, v24, v26
	v_mov_b32_e32 v24, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v25, v23, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[24:25]
                                        ; implicit-def: $vgpr24_vgpr25
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_155
; %bb.154:
	v_cvt_f32_u32_e32 v24, v2
	v_cvt_f32_u32_e32 v25, v3
	v_sub_co_u32 v31, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v32, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v24, v25, 0x4f800000, v24
	v_rcp_f32_e32 v24, v24
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v24, 0x5f7ffffc, v24
	v_mul_f32_e32 v25, 0x2f800000, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v25, v25
	v_fmamk_f32 v24, v25, 0xcf800000, v24
	v_cvt_u32_f32_e32 v33, v25
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v34, v24
	v_mul_lo_u32 v26, v31, v33
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v27, v32, v34
	v_mad_co_u64_u32 v[24:25], null, v31, v34, 0
	v_add3_u32 v29, v25, v26, v27
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v35, v34, v24
	v_mad_co_u64_u32 v[27:28], null, v33, v24, 0
	v_mad_co_u64_u32 v[25:26], null, v34, v29, 0
	v_mad_co_u64_u32 v[29:30], null, v33, v29, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v24, vcc_lo, v35, v25
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v25, null, 0, v26, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v24, vcc_lo, v24, v27
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v24, vcc_lo, v25, v28, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v25, vcc_lo, 0, v30, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v24, vcc_lo, v24, v29
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v25, null, 0, v25, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v34, vcc_lo, v34, v24
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v33, null, v33, v25, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v26, v32, v34
	v_mad_co_u64_u32 v[24:25], null, v31, v34, 0
	v_mul_lo_u32 v27, v31, v33
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v31, v34, v24
	v_add3_u32 v29, v25, v27, v26
	v_mad_co_u64_u32 v[27:28], null, v33, v24, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[25:26], null, v34, v29, 0
	v_mad_co_u64_u32 v[29:30], null, v33, v29, 0
	v_add_co_u32 v24, vcc_lo, v31, v25
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v25, null, 0, v26, vcc_lo
	v_add_co_u32 v24, vcc_lo, v24, v27
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v24, vcc_lo, v25, v28, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v25, vcc_lo, 0, v30, vcc_lo
	v_add_co_u32 v24, vcc_lo, v24, v29
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v25, null, 0, v25, vcc_lo
	v_add_co_u32 v26, vcc_lo, v34, v24
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v28, null, v33, v25, vcc_lo
	v_mul_hi_u32 v30, v22, v26
	v_mad_co_u64_u32 v[26:27], null, v23, v26, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[24:25], null, v22, v28, 0
	v_mad_co_u64_u32 v[28:29], null, v23, v28, 0
	v_add_co_u32 v24, vcc_lo, v30, v24
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v25, null, 0, v25, vcc_lo
	v_add_co_u32 v24, vcc_lo, v24, v26
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v24, vcc_lo, v25, v27, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v25, vcc_lo, 0, v29, vcc_lo
	v_add_co_u32 v26, vcc_lo, v24, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v27, null, 0, v25, vcc_lo
	v_mul_lo_u32 v28, v3, v26
	v_mad_co_u64_u32 v[24:25], null, v2, v26, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v29, v2, v27
	v_sub_co_u32 v22, vcc_lo, v22, v24
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v25, v25, v29, v28
	v_sub_nc_u32_e32 v28, v23, v25
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v23, null, v23, v25, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v24, null, v28, v3, vcc_lo
	v_add_co_u32 v28, s0, v26, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v29, null, 0, v27, s0
	v_sub_co_u32 v29, s0, v22, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v24, null, 0, v24, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v29, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v24, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v29, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v22, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v22, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v23, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v30, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v24, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v24, v29, v25, vcc_lo
	v_add_co_u32 v25, vcc_lo, v26, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v27, null, 0, v27, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v23, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v22, v30, v22, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v24
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v23, v25, v28, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v22
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v24, v26, v23, vcc_lo
                                        ; implicit-def: $vgpr22_vgpr23
.LBB11_155:                             ; %Flow444
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_157
; %bb.156:
	v_cvt_f32_u32_e32 v23, v2
	v_sub_nc_u32_e32 v24, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v23, v23
	v_mul_f32_e32 v23, 0x4f7ffffe, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v23, v23
	v_mul_lo_u32 v24, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v24, v23, v24
	v_add_nc_u32_e32 v23, v23, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v23, v22, v23
	v_mul_lo_u32 v24, v23, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v22, v22, v24
	v_add_nc_u32_e32 v24, 1, v23
	v_sub_nc_u32_e32 v25, v22, v2
	v_cmp_ge_u32_e32 vcc_lo, v22, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v22, v22, v25 :: v_dual_cndmask_b32 v23, v23, v24
	v_cmp_ge_u32_e32 vcc_lo, v22, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v24, 1, v23
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v24, v23, v24, vcc_lo
.LBB11_157:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v23, 0 :: v_dual_add_nc_u32 v22, 1, v24
	scratch_store_b32 off, v22, off offset:96
.LBB11_158:                             ; %Flow445
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v26, v[4:5], off offset:100
	v_mov_b32_e32 v24, 0
	v_mov_b32_e32 v25, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v26
	s_cbranch_execz .LBB11_164
; %bb.159:
	v_ashrrev_i32_e32 v27, 31, v26
	v_mul_lo_u32 v28, v65, v26
	v_mad_co_u64_u32 v[24:25], null, v64, v26, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v26, v64, v27
	v_add3_u32 v25, v25, v26, v28
	v_mov_b32_e32 v26, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v27, v25, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[26:27]
                                        ; implicit-def: $vgpr26_vgpr27
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_161
; %bb.160:
	v_cvt_f32_u32_e32 v26, v2
	v_cvt_f32_u32_e32 v27, v3
	v_sub_co_u32 v33, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v34, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v26, v27, 0x4f800000, v26
	v_rcp_f32_e32 v26, v26
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v26, 0x5f7ffffc, v26
	v_mul_f32_e32 v27, 0x2f800000, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v27, v27
	v_fmamk_f32 v26, v27, 0xcf800000, v26
	v_cvt_u32_f32_e32 v35, v27
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v36, v26
	v_mul_lo_u32 v28, v33, v35
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v29, v34, v36
	v_mad_co_u64_u32 v[26:27], null, v33, v36, 0
	v_add3_u32 v31, v27, v28, v29
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v37, v36, v26
	v_mad_co_u64_u32 v[29:30], null, v35, v26, 0
	v_mad_co_u64_u32 v[27:28], null, v36, v31, 0
	v_mad_co_u64_u32 v[31:32], null, v35, v31, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v26, vcc_lo, v37, v27
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v27, null, 0, v28, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v26, vcc_lo, v26, v29
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v26, vcc_lo, v27, v30, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v27, vcc_lo, 0, v32, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v26, vcc_lo, v26, v31
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v27, null, 0, v27, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v36, vcc_lo, v36, v26
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v35, null, v35, v27, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v28, v34, v36
	v_mad_co_u64_u32 v[26:27], null, v33, v36, 0
	v_mul_lo_u32 v29, v33, v35
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v33, v36, v26
	v_add3_u32 v31, v27, v29, v28
	v_mad_co_u64_u32 v[29:30], null, v35, v26, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[27:28], null, v36, v31, 0
	v_mad_co_u64_u32 v[31:32], null, v35, v31, 0
	v_add_co_u32 v26, vcc_lo, v33, v27
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v27, null, 0, v28, vcc_lo
	v_add_co_u32 v26, vcc_lo, v26, v29
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v26, vcc_lo, v27, v30, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v27, vcc_lo, 0, v32, vcc_lo
	v_add_co_u32 v26, vcc_lo, v26, v31
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v27, null, 0, v27, vcc_lo
	v_add_co_u32 v28, vcc_lo, v36, v26
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v30, null, v35, v27, vcc_lo
	v_mul_hi_u32 v32, v24, v28
	v_mad_co_u64_u32 v[28:29], null, v25, v28, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[26:27], null, v24, v30, 0
	v_mad_co_u64_u32 v[30:31], null, v25, v30, 0
	v_add_co_u32 v26, vcc_lo, v32, v26
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v27, null, 0, v27, vcc_lo
	v_add_co_u32 v26, vcc_lo, v26, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v26, vcc_lo, v27, v29, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v27, vcc_lo, 0, v31, vcc_lo
	v_add_co_u32 v28, vcc_lo, v26, v30
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v29, null, 0, v27, vcc_lo
	v_mul_lo_u32 v30, v3, v28
	v_mad_co_u64_u32 v[26:27], null, v2, v28, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v31, v2, v29
	v_sub_co_u32 v24, vcc_lo, v24, v26
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v27, v27, v31, v30
	v_sub_nc_u32_e32 v30, v25, v27
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v25, null, v25, v27, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v26, null, v30, v3, vcc_lo
	v_add_co_u32 v30, s0, v28, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v31, null, 0, v29, s0
	v_sub_co_u32 v31, s0, v24, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v26, null, 0, v26, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v31, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v26, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v31, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v24, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v25, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v32, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v26, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v26, v31, v27, vcc_lo
	v_add_co_u32 v27, vcc_lo, v28, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v29, null, 0, v29, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v25, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v24, v32, v24, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v26
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v25, v27, v30, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v24
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v26, v28, v25, vcc_lo
                                        ; implicit-def: $vgpr24_vgpr25
.LBB11_161:                             ; %Flow442
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_163
; %bb.162:
	v_cvt_f32_u32_e32 v25, v2
	v_sub_nc_u32_e32 v26, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v25, v25
	v_mul_f32_e32 v25, 0x4f7ffffe, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v25, v25
	v_mul_lo_u32 v26, v26, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v26, v25, v26
	v_add_nc_u32_e32 v25, v25, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v25, v24, v25
	v_mul_lo_u32 v26, v25, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v24, v24, v26
	v_add_nc_u32_e32 v26, 1, v25
	v_sub_nc_u32_e32 v27, v24, v2
	v_cmp_ge_u32_e32 vcc_lo, v24, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v24, v24, v27 :: v_dual_cndmask_b32 v25, v25, v26
	v_cmp_ge_u32_e32 vcc_lo, v24, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v26, 1, v25
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v26, v25, v26, vcc_lo
.LBB11_163:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v25, 0 :: v_dual_add_nc_u32 v24, 1, v26
	scratch_store_b32 off, v24, off offset:100
.LBB11_164:                             ; %Flow443
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v28, v[4:5], off offset:104
	v_mov_b32_e32 v26, 0
	v_mov_b32_e32 v27, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v28
	s_cbranch_execz .LBB11_170
; %bb.165:
	v_ashrrev_i32_e32 v29, 31, v28
	v_mul_lo_u32 v30, v65, v28
	v_mad_co_u64_u32 v[26:27], null, v64, v28, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v28, v64, v29
	v_add3_u32 v27, v27, v28, v30
	v_mov_b32_e32 v28, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v29, v27, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[28:29]
                                        ; implicit-def: $vgpr28_vgpr29
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_167
; %bb.166:
	v_cvt_f32_u32_e32 v28, v2
	v_cvt_f32_u32_e32 v29, v3
	v_sub_co_u32 v35, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v36, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v28, v29, 0x4f800000, v28
	v_rcp_f32_e32 v28, v28
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v28, 0x5f7ffffc, v28
	v_mul_f32_e32 v29, 0x2f800000, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v29, v29
	v_fmamk_f32 v28, v29, 0xcf800000, v28
	v_cvt_u32_f32_e32 v37, v29
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v38, v28
	v_mul_lo_u32 v30, v35, v37
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, v36, v38
	v_mad_co_u64_u32 v[28:29], null, v35, v38, 0
	v_add3_u32 v33, v29, v30, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v39, v38, v28
	v_mad_co_u64_u32 v[31:32], null, v37, v28, 0
	v_mad_co_u64_u32 v[29:30], null, v38, v33, 0
	v_mad_co_u64_u32 v[33:34], null, v37, v33, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v28, vcc_lo, v39, v29
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v29, null, 0, v30, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v28, vcc_lo, v28, v31
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v28, vcc_lo, v29, v32, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v29, vcc_lo, 0, v34, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v28, vcc_lo, v28, v33
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v29, null, 0, v29, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v38, vcc_lo, v38, v28
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v37, null, v37, v29, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v30, v36, v38
	v_mad_co_u64_u32 v[28:29], null, v35, v38, 0
	v_mul_lo_u32 v31, v35, v37
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v35, v38, v28
	v_add3_u32 v33, v29, v31, v30
	v_mad_co_u64_u32 v[31:32], null, v37, v28, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[29:30], null, v38, v33, 0
	v_mad_co_u64_u32 v[33:34], null, v37, v33, 0
	v_add_co_u32 v28, vcc_lo, v35, v29
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v29, null, 0, v30, vcc_lo
	v_add_co_u32 v28, vcc_lo, v28, v31
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v28, vcc_lo, v29, v32, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v29, vcc_lo, 0, v34, vcc_lo
	v_add_co_u32 v28, vcc_lo, v28, v33
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v29, null, 0, v29, vcc_lo
	v_add_co_u32 v30, vcc_lo, v38, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v32, null, v37, v29, vcc_lo
	v_mul_hi_u32 v34, v26, v30
	v_mad_co_u64_u32 v[30:31], null, v27, v30, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[28:29], null, v26, v32, 0
	v_mad_co_u64_u32 v[32:33], null, v27, v32, 0
	v_add_co_u32 v28, vcc_lo, v34, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v29, null, 0, v29, vcc_lo
	v_add_co_u32 v28, vcc_lo, v28, v30
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v28, vcc_lo, v29, v31, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v29, vcc_lo, 0, v33, vcc_lo
	v_add_co_u32 v30, vcc_lo, v28, v32
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v31, null, 0, v29, vcc_lo
	v_mul_lo_u32 v32, v3, v30
	v_mad_co_u64_u32 v[28:29], null, v2, v30, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v33, v2, v31
	v_sub_co_u32 v26, vcc_lo, v26, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v29, v29, v33, v32
	v_sub_nc_u32_e32 v32, v27, v29
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v27, null, v27, v29, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v28, null, v32, v3, vcc_lo
	v_add_co_u32 v32, s0, v30, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v33, null, 0, v31, s0
	v_sub_co_u32 v33, s0, v26, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v28, null, 0, v28, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v33, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v29, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v28, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v33, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v26, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v27, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v34, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v28, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v28, v33, v29, vcc_lo
	v_add_co_u32 v29, vcc_lo, v30, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v31, null, 0, v31, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v27, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v26, v34, v26, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v28
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v27, v29, v32, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v26
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v28, v30, v27, vcc_lo
                                        ; implicit-def: $vgpr26_vgpr27
.LBB11_167:                             ; %Flow440
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_169
; %bb.168:
	v_cvt_f32_u32_e32 v27, v2
	v_sub_nc_u32_e32 v28, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v27, v27
	v_mul_f32_e32 v27, 0x4f7ffffe, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v27, v27
	v_mul_lo_u32 v28, v28, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v28, v27, v28
	v_add_nc_u32_e32 v27, v27, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v27, v26, v27
	v_mul_lo_u32 v28, v27, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v26, v26, v28
	v_add_nc_u32_e32 v28, 1, v27
	v_sub_nc_u32_e32 v29, v26, v2
	v_cmp_ge_u32_e32 vcc_lo, v26, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v26, v26, v29 :: v_dual_cndmask_b32 v27, v27, v28
	v_cmp_ge_u32_e32 vcc_lo, v26, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v28, 1, v27
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v28, v27, v28, vcc_lo
.LBB11_169:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v27, 0 :: v_dual_add_nc_u32 v26, 1, v28
	scratch_store_b32 off, v26, off offset:104
.LBB11_170:                             ; %Flow441
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v30, v[4:5], off offset:108
	v_mov_b32_e32 v28, 0
	v_mov_b32_e32 v29, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v30
	s_cbranch_execz .LBB11_176
; %bb.171:
	v_ashrrev_i32_e32 v31, 31, v30
	v_mul_lo_u32 v32, v65, v30
	v_mad_co_u64_u32 v[28:29], null, v64, v30, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v30, v64, v31
	v_add3_u32 v29, v29, v30, v32
	v_mov_b32_e32 v30, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v31, v29, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[30:31]
                                        ; implicit-def: $vgpr30_vgpr31
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_173
; %bb.172:
	v_cvt_f32_u32_e32 v30, v2
	v_cvt_f32_u32_e32 v31, v3
	v_sub_co_u32 v37, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v38, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v30, v31, 0x4f800000, v30
	v_rcp_f32_e32 v30, v30
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v30, 0x5f7ffffc, v30
	v_mul_f32_e32 v31, 0x2f800000, v30
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v31, v31
	v_fmamk_f32 v30, v31, 0xcf800000, v30
	v_cvt_u32_f32_e32 v39, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v40, v30
	v_mul_lo_u32 v32, v37, v39
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v33, v38, v40
	v_mad_co_u64_u32 v[30:31], null, v37, v40, 0
	v_add3_u32 v35, v31, v32, v33
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v41, v40, v30
	v_mad_co_u64_u32 v[33:34], null, v39, v30, 0
	v_mad_co_u64_u32 v[31:32], null, v40, v35, 0
	v_mad_co_u64_u32 v[35:36], null, v39, v35, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v30, vcc_lo, v41, v31
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v31, null, 0, v32, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v30, vcc_lo, v30, v33
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v30, vcc_lo, v31, v34, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v31, vcc_lo, 0, v36, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v30, vcc_lo, v30, v35
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v31, null, 0, v31, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v40, vcc_lo, v40, v30
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v39, null, v39, v31, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v32, v38, v40
	v_mad_co_u64_u32 v[30:31], null, v37, v40, 0
	v_mul_lo_u32 v33, v37, v39
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v37, v40, v30
	v_add3_u32 v35, v31, v33, v32
	v_mad_co_u64_u32 v[33:34], null, v39, v30, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[31:32], null, v40, v35, 0
	v_mad_co_u64_u32 v[35:36], null, v39, v35, 0
	v_add_co_u32 v30, vcc_lo, v37, v31
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v31, null, 0, v32, vcc_lo
	v_add_co_u32 v30, vcc_lo, v30, v33
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v30, vcc_lo, v31, v34, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v31, vcc_lo, 0, v36, vcc_lo
	v_add_co_u32 v30, vcc_lo, v30, v35
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v31, null, 0, v31, vcc_lo
	v_add_co_u32 v32, vcc_lo, v40, v30
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v34, null, v39, v31, vcc_lo
	v_mul_hi_u32 v36, v28, v32
	v_mad_co_u64_u32 v[32:33], null, v29, v32, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[30:31], null, v28, v34, 0
	v_mad_co_u64_u32 v[34:35], null, v29, v34, 0
	v_add_co_u32 v30, vcc_lo, v36, v30
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v31, null, 0, v31, vcc_lo
	v_add_co_u32 v30, vcc_lo, v30, v32
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v30, vcc_lo, v31, v33, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v31, vcc_lo, 0, v35, vcc_lo
	v_add_co_u32 v32, vcc_lo, v30, v34
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v33, null, 0, v31, vcc_lo
	v_mul_lo_u32 v34, v3, v32
	v_mad_co_u64_u32 v[30:31], null, v2, v32, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v35, v2, v33
	v_sub_co_u32 v28, vcc_lo, v28, v30
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v31, v31, v35, v34
	v_sub_nc_u32_e32 v34, v29, v31
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v29, null, v29, v31, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v30, null, v34, v3, vcc_lo
	v_add_co_u32 v34, s0, v32, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v35, null, 0, v33, s0
	v_sub_co_u32 v35, s0, v28, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v30, null, 0, v30, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v35, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v31, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v30, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v35, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v28, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v28, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v29, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v36, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v30, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v30, v35, v31, vcc_lo
	v_add_co_u32 v31, vcc_lo, v32, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v33, null, 0, v33, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v29, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v28, v36, v28, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v30
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v29, v31, v34, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v28
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v30, v32, v29, vcc_lo
                                        ; implicit-def: $vgpr28_vgpr29
.LBB11_173:                             ; %Flow438
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_175
; %bb.174:
	v_cvt_f32_u32_e32 v29, v2
	v_sub_nc_u32_e32 v30, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v29, v29
	v_mul_f32_e32 v29, 0x4f7ffffe, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v29, v29
	v_mul_lo_u32 v30, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v30, v29, v30
	v_add_nc_u32_e32 v29, v29, v30
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v29, v28, v29
	v_mul_lo_u32 v30, v29, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v28, v28, v30
	v_add_nc_u32_e32 v30, 1, v29
	v_sub_nc_u32_e32 v31, v28, v2
	v_cmp_ge_u32_e32 vcc_lo, v28, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v28, v28, v31 :: v_dual_cndmask_b32 v29, v29, v30
	v_cmp_ge_u32_e32 vcc_lo, v28, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v30, 1, v29
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v30, v29, v30, vcc_lo
.LBB11_175:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v29, 0 :: v_dual_add_nc_u32 v28, 1, v30
	scratch_store_b32 off, v28, off offset:108
.LBB11_176:                             ; %Flow439
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v32, v[4:5], off offset:112
	v_mov_b32_e32 v30, 0
	v_mov_b32_e32 v31, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v32
	s_cbranch_execz .LBB11_182
; %bb.177:
	v_ashrrev_i32_e32 v33, 31, v32
	v_mul_lo_u32 v34, v65, v32
	v_mad_co_u64_u32 v[30:31], null, v64, v32, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v32, v64, v33
	v_add3_u32 v31, v31, v32, v34
	v_mov_b32_e32 v32, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v33, v31, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[32:33]
                                        ; implicit-def: $vgpr32_vgpr33
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_179
; %bb.178:
	v_cvt_f32_u32_e32 v32, v2
	v_cvt_f32_u32_e32 v33, v3
	v_sub_co_u32 v39, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v40, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v32, v33, 0x4f800000, v32
	v_rcp_f32_e32 v32, v32
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v32, 0x5f7ffffc, v32
	v_mul_f32_e32 v33, 0x2f800000, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v33, v33
	v_fmamk_f32 v32, v33, 0xcf800000, v32
	v_cvt_u32_f32_e32 v41, v33
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v42, v32
	v_mul_lo_u32 v34, v39, v41
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v35, v40, v42
	v_mad_co_u64_u32 v[32:33], null, v39, v42, 0
	v_add3_u32 v37, v33, v34, v35
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v43, v42, v32
	v_mad_co_u64_u32 v[35:36], null, v41, v32, 0
	v_mad_co_u64_u32 v[33:34], null, v42, v37, 0
	v_mad_co_u64_u32 v[37:38], null, v41, v37, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v32, vcc_lo, v43, v33
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v33, null, 0, v34, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v32, vcc_lo, v32, v35
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v32, vcc_lo, v33, v36, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v33, vcc_lo, 0, v38, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v32, vcc_lo, v32, v37
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v33, null, 0, v33, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v42, vcc_lo, v42, v32
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v41, null, v41, v33, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v34, v40, v42
	v_mad_co_u64_u32 v[32:33], null, v39, v42, 0
	v_mul_lo_u32 v35, v39, v41
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v39, v42, v32
	v_add3_u32 v37, v33, v35, v34
	v_mad_co_u64_u32 v[35:36], null, v41, v32, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[33:34], null, v42, v37, 0
	v_mad_co_u64_u32 v[37:38], null, v41, v37, 0
	v_add_co_u32 v32, vcc_lo, v39, v33
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v33, null, 0, v34, vcc_lo
	v_add_co_u32 v32, vcc_lo, v32, v35
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v32, vcc_lo, v33, v36, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v33, vcc_lo, 0, v38, vcc_lo
	v_add_co_u32 v32, vcc_lo, v32, v37
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v33, null, 0, v33, vcc_lo
	v_add_co_u32 v34, vcc_lo, v42, v32
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v36, null, v41, v33, vcc_lo
	v_mul_hi_u32 v38, v30, v34
	v_mad_co_u64_u32 v[34:35], null, v31, v34, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[32:33], null, v30, v36, 0
	v_mad_co_u64_u32 v[36:37], null, v31, v36, 0
	v_add_co_u32 v32, vcc_lo, v38, v32
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v33, null, 0, v33, vcc_lo
	v_add_co_u32 v32, vcc_lo, v32, v34
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v32, vcc_lo, v33, v35, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v33, vcc_lo, 0, v37, vcc_lo
	v_add_co_u32 v34, vcc_lo, v32, v36
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v35, null, 0, v33, vcc_lo
	v_mul_lo_u32 v36, v3, v34
	v_mad_co_u64_u32 v[32:33], null, v2, v34, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v37, v2, v35
	v_sub_co_u32 v30, vcc_lo, v30, v32
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v33, v33, v37, v36
	v_sub_nc_u32_e32 v36, v31, v33
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v31, null, v31, v33, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v32, null, v36, v3, vcc_lo
	v_add_co_u32 v36, s0, v34, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v37, null, 0, v35, s0
	v_sub_co_u32 v37, s0, v30, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v32, null, 0, v32, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v37, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v33, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v32, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v37, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v30, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v30, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v31, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v38, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v32, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v32, v37, v33, vcc_lo
	v_add_co_u32 v33, vcc_lo, v34, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v35, null, 0, v35, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v31, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v30, v38, v30, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v32
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v31, v33, v36, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v30
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v32, v34, v31, vcc_lo
                                        ; implicit-def: $vgpr30_vgpr31
.LBB11_179:                             ; %Flow436
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_181
; %bb.180:
	v_cvt_f32_u32_e32 v31, v2
	v_sub_nc_u32_e32 v32, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v31, v31
	v_mul_f32_e32 v31, 0x4f7ffffe, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v31, v31
	v_mul_lo_u32 v32, v32, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v32, v31, v32
	v_add_nc_u32_e32 v31, v31, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v31, v30, v31
	v_mul_lo_u32 v32, v31, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v30, v30, v32
	v_add_nc_u32_e32 v32, 1, v31
	v_sub_nc_u32_e32 v33, v30, v2
	v_cmp_ge_u32_e32 vcc_lo, v30, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v30, v30, v33 :: v_dual_cndmask_b32 v31, v31, v32
	v_cmp_ge_u32_e32 vcc_lo, v30, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v32, 1, v31
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v32, v31, v32, vcc_lo
.LBB11_181:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v31, 0 :: v_dual_add_nc_u32 v30, 1, v32
	scratch_store_b32 off, v30, off offset:112
.LBB11_182:                             ; %Flow437
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v34, v[4:5], off offset:116
	v_mov_b32_e32 v32, 0
	v_mov_b32_e32 v33, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v34
	s_cbranch_execz .LBB11_188
; %bb.183:
	v_ashrrev_i32_e32 v35, 31, v34
	v_mul_lo_u32 v36, v65, v34
	v_mad_co_u64_u32 v[32:33], null, v64, v34, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v34, v64, v35
	v_add3_u32 v33, v33, v34, v36
	v_mov_b32_e32 v34, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v35, v33, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[34:35]
                                        ; implicit-def: $vgpr34_vgpr35
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_185
; %bb.184:
	v_cvt_f32_u32_e32 v34, v2
	v_cvt_f32_u32_e32 v35, v3
	v_sub_co_u32 v41, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v42, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v34, v35, 0x4f800000, v34
	v_rcp_f32_e32 v34, v34
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v34, 0x5f7ffffc, v34
	v_mul_f32_e32 v35, 0x2f800000, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v35, v35
	v_fmamk_f32 v34, v35, 0xcf800000, v34
	v_cvt_u32_f32_e32 v43, v35
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v44, v34
	v_mul_lo_u32 v36, v41, v43
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v37, v42, v44
	v_mad_co_u64_u32 v[34:35], null, v41, v44, 0
	v_add3_u32 v39, v35, v36, v37
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v45, v44, v34
	v_mad_co_u64_u32 v[37:38], null, v43, v34, 0
	v_mad_co_u64_u32 v[35:36], null, v44, v39, 0
	v_mad_co_u64_u32 v[39:40], null, v43, v39, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v34, vcc_lo, v45, v35
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v35, null, 0, v36, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v34, vcc_lo, v34, v37
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v34, vcc_lo, v35, v38, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v35, vcc_lo, 0, v40, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v34, vcc_lo, v34, v39
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v35, null, 0, v35, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v44, vcc_lo, v44, v34
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v43, null, v43, v35, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v36, v42, v44
	v_mad_co_u64_u32 v[34:35], null, v41, v44, 0
	v_mul_lo_u32 v37, v41, v43
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v41, v44, v34
	v_add3_u32 v39, v35, v37, v36
	v_mad_co_u64_u32 v[37:38], null, v43, v34, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[35:36], null, v44, v39, 0
	v_mad_co_u64_u32 v[39:40], null, v43, v39, 0
	v_add_co_u32 v34, vcc_lo, v41, v35
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v35, null, 0, v36, vcc_lo
	v_add_co_u32 v34, vcc_lo, v34, v37
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v34, vcc_lo, v35, v38, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v35, vcc_lo, 0, v40, vcc_lo
	v_add_co_u32 v34, vcc_lo, v34, v39
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v35, null, 0, v35, vcc_lo
	v_add_co_u32 v36, vcc_lo, v44, v34
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v38, null, v43, v35, vcc_lo
	v_mul_hi_u32 v40, v32, v36
	v_mad_co_u64_u32 v[36:37], null, v33, v36, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[34:35], null, v32, v38, 0
	v_mad_co_u64_u32 v[38:39], null, v33, v38, 0
	v_add_co_u32 v34, vcc_lo, v40, v34
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v35, null, 0, v35, vcc_lo
	v_add_co_u32 v34, vcc_lo, v34, v36
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v34, vcc_lo, v35, v37, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v35, vcc_lo, 0, v39, vcc_lo
	v_add_co_u32 v36, vcc_lo, v34, v38
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v37, null, 0, v35, vcc_lo
	v_mul_lo_u32 v38, v3, v36
	v_mad_co_u64_u32 v[34:35], null, v2, v36, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v39, v2, v37
	v_sub_co_u32 v32, vcc_lo, v32, v34
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v35, v35, v39, v38
	v_sub_nc_u32_e32 v38, v33, v35
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v33, null, v33, v35, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v34, null, v38, v3, vcc_lo
	v_add_co_u32 v38, s0, v36, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v39, null, 0, v37, s0
	v_sub_co_u32 v39, s0, v32, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v34, null, 0, v34, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v39, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v35, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v34, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v39, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v32, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v32, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v33, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v40, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v34, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v34, v39, v35, vcc_lo
	v_add_co_u32 v35, vcc_lo, v36, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v37, null, 0, v37, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v33, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v32, v40, v32, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v34
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v33, v35, v38, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v32
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v34, v36, v33, vcc_lo
                                        ; implicit-def: $vgpr32_vgpr33
.LBB11_185:                             ; %Flow434
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_187
; %bb.186:
	v_cvt_f32_u32_e32 v33, v2
	v_sub_nc_u32_e32 v34, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v33, v33
	v_mul_f32_e32 v33, 0x4f7ffffe, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v33, v33
	v_mul_lo_u32 v34, v34, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v34, v33, v34
	v_add_nc_u32_e32 v33, v33, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v33, v32, v33
	v_mul_lo_u32 v34, v33, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v32, v32, v34
	v_add_nc_u32_e32 v34, 1, v33
	v_sub_nc_u32_e32 v35, v32, v2
	v_cmp_ge_u32_e32 vcc_lo, v32, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v32, v32, v35 :: v_dual_cndmask_b32 v33, v33, v34
	v_cmp_ge_u32_e32 vcc_lo, v32, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v34, 1, v33
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v34, v33, v34, vcc_lo
.LBB11_187:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v33, 0 :: v_dual_add_nc_u32 v32, 1, v34
	scratch_store_b32 off, v32, off offset:116
.LBB11_188:                             ; %Flow435
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v36, v[4:5], off offset:120
	v_mov_b32_e32 v34, 0
	v_mov_b32_e32 v35, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v36
	s_cbranch_execz .LBB11_194
; %bb.189:
	v_ashrrev_i32_e32 v37, 31, v36
	v_mul_lo_u32 v38, v65, v36
	v_mad_co_u64_u32 v[34:35], null, v64, v36, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v36, v64, v37
	v_add3_u32 v35, v35, v36, v38
	v_mov_b32_e32 v36, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v37, v35, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[36:37]
                                        ; implicit-def: $vgpr36_vgpr37
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_191
; %bb.190:
	v_cvt_f32_u32_e32 v36, v2
	v_cvt_f32_u32_e32 v37, v3
	v_sub_co_u32 v43, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v44, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v36, v37, 0x4f800000, v36
	v_rcp_f32_e32 v36, v36
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v36, 0x5f7ffffc, v36
	v_mul_f32_e32 v37, 0x2f800000, v36
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v37, v37
	v_fmamk_f32 v36, v37, 0xcf800000, v36
	v_cvt_u32_f32_e32 v45, v37
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v46, v36
	v_mul_lo_u32 v38, v43, v45
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v39, v44, v46
	v_mad_co_u64_u32 v[36:37], null, v43, v46, 0
	v_add3_u32 v41, v37, v38, v39
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v47, v46, v36
	v_mad_co_u64_u32 v[39:40], null, v45, v36, 0
	v_mad_co_u64_u32 v[37:38], null, v46, v41, 0
	v_mad_co_u64_u32 v[41:42], null, v45, v41, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v36, vcc_lo, v47, v37
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v37, null, 0, v38, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v36, vcc_lo, v36, v39
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v36, vcc_lo, v37, v40, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v37, vcc_lo, 0, v42, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v36, vcc_lo, v36, v41
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v37, null, 0, v37, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v46, vcc_lo, v46, v36
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v45, null, v45, v37, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v38, v44, v46
	v_mad_co_u64_u32 v[36:37], null, v43, v46, 0
	v_mul_lo_u32 v39, v43, v45
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v43, v46, v36
	v_add3_u32 v41, v37, v39, v38
	v_mad_co_u64_u32 v[39:40], null, v45, v36, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[37:38], null, v46, v41, 0
	v_mad_co_u64_u32 v[41:42], null, v45, v41, 0
	v_add_co_u32 v36, vcc_lo, v43, v37
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v37, null, 0, v38, vcc_lo
	v_add_co_u32 v36, vcc_lo, v36, v39
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v36, vcc_lo, v37, v40, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v37, vcc_lo, 0, v42, vcc_lo
	v_add_co_u32 v36, vcc_lo, v36, v41
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v37, null, 0, v37, vcc_lo
	v_add_co_u32 v38, vcc_lo, v46, v36
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v40, null, v45, v37, vcc_lo
	v_mul_hi_u32 v42, v34, v38
	v_mad_co_u64_u32 v[38:39], null, v35, v38, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[36:37], null, v34, v40, 0
	v_mad_co_u64_u32 v[40:41], null, v35, v40, 0
	v_add_co_u32 v36, vcc_lo, v42, v36
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v37, null, 0, v37, vcc_lo
	v_add_co_u32 v36, vcc_lo, v36, v38
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v36, vcc_lo, v37, v39, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v37, vcc_lo, 0, v41, vcc_lo
	v_add_co_u32 v38, vcc_lo, v36, v40
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v39, null, 0, v37, vcc_lo
	v_mul_lo_u32 v40, v3, v38
	v_mad_co_u64_u32 v[36:37], null, v2, v38, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v41, v2, v39
	v_sub_co_u32 v34, vcc_lo, v34, v36
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v37, v37, v41, v40
	v_sub_nc_u32_e32 v40, v35, v37
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v35, null, v35, v37, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v36, null, v40, v3, vcc_lo
	v_add_co_u32 v40, s0, v38, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v41, null, 0, v39, s0
	v_sub_co_u32 v41, s0, v34, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v36, null, 0, v36, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v41, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v37, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v36, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v41, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v34, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v34, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v35, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v36, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v36, v41, v37, vcc_lo
	v_add_co_u32 v37, vcc_lo, v38, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v39, null, 0, v39, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v35, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v34, v42, v34, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v36
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v35, v37, v40, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v34
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v36, v38, v35, vcc_lo
                                        ; implicit-def: $vgpr34_vgpr35
.LBB11_191:                             ; %Flow432
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_193
; %bb.192:
	v_cvt_f32_u32_e32 v35, v2
	v_sub_nc_u32_e32 v36, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v35, v35
	v_mul_f32_e32 v35, 0x4f7ffffe, v35
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v35, v35
	v_mul_lo_u32 v36, v36, v35
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v36, v35, v36
	v_add_nc_u32_e32 v35, v35, v36
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v35, v34, v35
	v_mul_lo_u32 v36, v35, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v34, v34, v36
	v_add_nc_u32_e32 v36, 1, v35
	v_sub_nc_u32_e32 v37, v34, v2
	v_cmp_ge_u32_e32 vcc_lo, v34, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v34, v34, v37 :: v_dual_cndmask_b32 v35, v35, v36
	v_cmp_ge_u32_e32 vcc_lo, v34, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v36, 1, v35
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v36, v35, v36, vcc_lo
.LBB11_193:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v35, 0 :: v_dual_add_nc_u32 v34, 1, v36
	scratch_store_b32 off, v34, off offset:120
.LBB11_194:                             ; %Flow433
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v38, v[4:5], off offset:124
	v_mov_b32_e32 v36, 0
	v_mov_b32_e32 v37, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v38
	s_cbranch_execz .LBB11_200
; %bb.195:
	v_ashrrev_i32_e32 v39, 31, v38
	v_mul_lo_u32 v40, v65, v38
	v_mad_co_u64_u32 v[36:37], null, v64, v38, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v38, v64, v39
	v_add3_u32 v37, v37, v38, v40
	v_mov_b32_e32 v38, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v39, v37, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[38:39]
                                        ; implicit-def: $vgpr38_vgpr39
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_197
; %bb.196:
	v_cvt_f32_u32_e32 v38, v2
	v_cvt_f32_u32_e32 v39, v3
	v_sub_co_u32 v45, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v46, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v38, v39, 0x4f800000, v38
	v_rcp_f32_e32 v38, v38
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v38, 0x5f7ffffc, v38
	v_mul_f32_e32 v39, 0x2f800000, v38
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v39, v39
	v_fmamk_f32 v38, v39, 0xcf800000, v38
	v_cvt_u32_f32_e32 v47, v39
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v48, v38
	v_mul_lo_u32 v40, v45, v47
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v41, v46, v48
	v_mad_co_u64_u32 v[38:39], null, v45, v48, 0
	v_add3_u32 v43, v39, v40, v41
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v49, v48, v38
	v_mad_co_u64_u32 v[41:42], null, v47, v38, 0
	v_mad_co_u64_u32 v[39:40], null, v48, v43, 0
	v_mad_co_u64_u32 v[43:44], null, v47, v43, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v38, vcc_lo, v49, v39
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v39, null, 0, v40, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v38, vcc_lo, v38, v41
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v38, vcc_lo, v39, v42, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v39, vcc_lo, 0, v44, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v38, vcc_lo, v38, v43
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v39, null, 0, v39, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v48, vcc_lo, v48, v38
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v47, null, v47, v39, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v40, v46, v48
	v_mad_co_u64_u32 v[38:39], null, v45, v48, 0
	v_mul_lo_u32 v41, v45, v47
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v45, v48, v38
	v_add3_u32 v43, v39, v41, v40
	v_mad_co_u64_u32 v[41:42], null, v47, v38, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[39:40], null, v48, v43, 0
	v_mad_co_u64_u32 v[43:44], null, v47, v43, 0
	v_add_co_u32 v38, vcc_lo, v45, v39
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v39, null, 0, v40, vcc_lo
	v_add_co_u32 v38, vcc_lo, v38, v41
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v38, vcc_lo, v39, v42, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v39, vcc_lo, 0, v44, vcc_lo
	v_add_co_u32 v38, vcc_lo, v38, v43
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v39, null, 0, v39, vcc_lo
	v_add_co_u32 v40, vcc_lo, v48, v38
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v42, null, v47, v39, vcc_lo
	v_mul_hi_u32 v44, v36, v40
	v_mad_co_u64_u32 v[40:41], null, v37, v40, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[38:39], null, v36, v42, 0
	v_mad_co_u64_u32 v[42:43], null, v37, v42, 0
	v_add_co_u32 v38, vcc_lo, v44, v38
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v39, null, 0, v39, vcc_lo
	v_add_co_u32 v38, vcc_lo, v38, v40
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v38, vcc_lo, v39, v41, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v39, vcc_lo, 0, v43, vcc_lo
	v_add_co_u32 v40, vcc_lo, v38, v42
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v41, null, 0, v39, vcc_lo
	v_mul_lo_u32 v42, v3, v40
	v_mad_co_u64_u32 v[38:39], null, v2, v40, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v43, v2, v41
	v_sub_co_u32 v36, vcc_lo, v36, v38
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v39, v39, v43, v42
	v_sub_nc_u32_e32 v42, v37, v39
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v37, null, v37, v39, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v38, null, v42, v3, vcc_lo
	v_add_co_u32 v42, s0, v40, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v43, null, 0, v41, s0
	v_sub_co_u32 v43, s0, v36, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v38, null, 0, v38, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v43, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v39, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v38, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v36, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v36, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v37, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v38, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v38, v43, v39, vcc_lo
	v_add_co_u32 v39, vcc_lo, v40, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v41, null, 0, v41, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v37, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v36, v44, v36, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v38
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v37, v39, v42, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v36
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v38, v40, v37, vcc_lo
                                        ; implicit-def: $vgpr36_vgpr37
.LBB11_197:                             ; %Flow430
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_199
; %bb.198:
	v_cvt_f32_u32_e32 v37, v2
	v_sub_nc_u32_e32 v38, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v37, v37
	v_mul_f32_e32 v37, 0x4f7ffffe, v37
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v37, v37
	v_mul_lo_u32 v38, v38, v37
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v38, v37, v38
	v_add_nc_u32_e32 v37, v37, v38
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v37, v36, v37
	v_mul_lo_u32 v38, v37, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v36, v36, v38
	v_add_nc_u32_e32 v38, 1, v37
	v_sub_nc_u32_e32 v39, v36, v2
	v_cmp_ge_u32_e32 vcc_lo, v36, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v36, v36, v39 :: v_dual_cndmask_b32 v37, v37, v38
	v_cmp_ge_u32_e32 vcc_lo, v36, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v38, 1, v37
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v38, v37, v38, vcc_lo
.LBB11_199:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v37, 0 :: v_dual_add_nc_u32 v36, 1, v38
	scratch_store_b32 off, v36, off offset:124
.LBB11_200:                             ; %Flow431
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v40, v[4:5], off offset:128
	v_mov_b32_e32 v38, 0
	v_mov_b32_e32 v39, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v40
	s_cbranch_execz .LBB11_206
; %bb.201:
	v_ashrrev_i32_e32 v41, 31, v40
	v_mul_lo_u32 v42, v65, v40
	v_mad_co_u64_u32 v[38:39], null, v64, v40, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v40, v64, v41
	v_add3_u32 v39, v39, v40, v42
	v_mov_b32_e32 v40, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v41, v39, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[40:41]
                                        ; implicit-def: $vgpr40_vgpr41
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_203
; %bb.202:
	v_cvt_f32_u32_e32 v40, v2
	v_cvt_f32_u32_e32 v41, v3
	v_sub_co_u32 v47, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v48, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v40, v41, 0x4f800000, v40
	v_rcp_f32_e32 v40, v40
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v40, 0x5f7ffffc, v40
	v_mul_f32_e32 v41, 0x2f800000, v40
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v41, v41
	v_fmamk_f32 v40, v41, 0xcf800000, v40
	v_cvt_u32_f32_e32 v49, v41
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v50, v40
	v_mul_lo_u32 v42, v47, v49
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v43, v48, v50
	v_mad_co_u64_u32 v[40:41], null, v47, v50, 0
	v_add3_u32 v45, v41, v42, v43
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v51, v50, v40
	v_mad_co_u64_u32 v[43:44], null, v49, v40, 0
	v_mad_co_u64_u32 v[41:42], null, v50, v45, 0
	v_mad_co_u64_u32 v[45:46], null, v49, v45, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v40, vcc_lo, v51, v41
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v41, null, 0, v42, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v40, vcc_lo, v40, v43
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v40, vcc_lo, v41, v44, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v41, vcc_lo, 0, v46, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v40, vcc_lo, v40, v45
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v41, null, 0, v41, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v50, vcc_lo, v50, v40
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v49, null, v49, v41, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v42, v48, v50
	v_mad_co_u64_u32 v[40:41], null, v47, v50, 0
	v_mul_lo_u32 v43, v47, v49
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v47, v50, v40
	v_add3_u32 v45, v41, v43, v42
	v_mad_co_u64_u32 v[43:44], null, v49, v40, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[41:42], null, v50, v45, 0
	v_mad_co_u64_u32 v[45:46], null, v49, v45, 0
	v_add_co_u32 v40, vcc_lo, v47, v41
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v41, null, 0, v42, vcc_lo
	v_add_co_u32 v40, vcc_lo, v40, v43
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v40, vcc_lo, v41, v44, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v41, vcc_lo, 0, v46, vcc_lo
	v_add_co_u32 v40, vcc_lo, v40, v45
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v41, null, 0, v41, vcc_lo
	v_add_co_u32 v42, vcc_lo, v50, v40
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v44, null, v49, v41, vcc_lo
	v_mul_hi_u32 v46, v38, v42
	v_mad_co_u64_u32 v[42:43], null, v39, v42, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[40:41], null, v38, v44, 0
	v_mad_co_u64_u32 v[44:45], null, v39, v44, 0
	v_add_co_u32 v40, vcc_lo, v46, v40
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v41, null, 0, v41, vcc_lo
	v_add_co_u32 v40, vcc_lo, v40, v42
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v40, vcc_lo, v41, v43, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v41, vcc_lo, 0, v45, vcc_lo
	v_add_co_u32 v42, vcc_lo, v40, v44
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v43, null, 0, v41, vcc_lo
	v_mul_lo_u32 v44, v3, v42
	v_mad_co_u64_u32 v[40:41], null, v2, v42, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v45, v2, v43
	v_sub_co_u32 v38, vcc_lo, v38, v40
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v41, v41, v45, v44
	v_sub_nc_u32_e32 v44, v39, v41
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v39, null, v39, v41, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v40, null, v44, v3, vcc_lo
	v_add_co_u32 v44, s0, v42, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v45, null, 0, v43, s0
	v_sub_co_u32 v45, s0, v38, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v40, null, 0, v40, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v45, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v41, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v40, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v45, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v38, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v38, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v39, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v46, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v40, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v40, v45, v41, vcc_lo
	v_add_co_u32 v41, vcc_lo, v42, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v43, null, 0, v43, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v39, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v38, v46, v38, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v40
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v39, v41, v44, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v38
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v40, v42, v39, vcc_lo
                                        ; implicit-def: $vgpr38_vgpr39
.LBB11_203:                             ; %Flow428
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_205
; %bb.204:
	v_cvt_f32_u32_e32 v39, v2
	v_sub_nc_u32_e32 v40, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v39, v39
	v_mul_f32_e32 v39, 0x4f7ffffe, v39
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v39, v39
	v_mul_lo_u32 v40, v40, v39
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v40, v39, v40
	v_add_nc_u32_e32 v39, v39, v40
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v39, v38, v39
	v_mul_lo_u32 v40, v39, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v38, v38, v40
	v_add_nc_u32_e32 v40, 1, v39
	v_sub_nc_u32_e32 v41, v38, v2
	v_cmp_ge_u32_e32 vcc_lo, v38, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v38, v38, v41 :: v_dual_cndmask_b32 v39, v39, v40
	v_cmp_ge_u32_e32 vcc_lo, v38, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v40, 1, v39
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v40, v39, v40, vcc_lo
.LBB11_205:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v39, 0 :: v_dual_add_nc_u32 v38, 1, v40
	scratch_store_b32 off, v38, off offset:128
.LBB11_206:                             ; %Flow429
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v42, v[4:5], off offset:132
	v_mov_b32_e32 v40, 0
	v_mov_b32_e32 v41, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v42
	s_cbranch_execz .LBB11_212
; %bb.207:
	v_ashrrev_i32_e32 v43, 31, v42
	v_mul_lo_u32 v44, v65, v42
	v_mad_co_u64_u32 v[40:41], null, v64, v42, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v42, v64, v43
	v_add3_u32 v41, v41, v42, v44
	v_mov_b32_e32 v42, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v43, v41, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[42:43]
                                        ; implicit-def: $vgpr42_vgpr43
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_209
; %bb.208:
	v_cvt_f32_u32_e32 v42, v2
	v_cvt_f32_u32_e32 v43, v3
	v_sub_co_u32 v49, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v50, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v42, v43, 0x4f800000, v42
	v_rcp_f32_e32 v42, v42
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v42, 0x5f7ffffc, v42
	v_mul_f32_e32 v43, 0x2f800000, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v43, v43
	v_fmamk_f32 v42, v43, 0xcf800000, v42
	v_cvt_u32_f32_e32 v51, v43
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v52, v42
	v_mul_lo_u32 v44, v49, v51
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v45, v50, v52
	v_mad_co_u64_u32 v[42:43], null, v49, v52, 0
	v_add3_u32 v47, v43, v44, v45
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v53, v52, v42
	v_mad_co_u64_u32 v[45:46], null, v51, v42, 0
	v_mad_co_u64_u32 v[43:44], null, v52, v47, 0
	v_mad_co_u64_u32 v[47:48], null, v51, v47, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v42, vcc_lo, v53, v43
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v43, null, 0, v44, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v42, vcc_lo, v42, v45
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v42, vcc_lo, v43, v46, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v43, vcc_lo, 0, v48, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v42, vcc_lo, v42, v47
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v43, null, 0, v43, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v52, vcc_lo, v52, v42
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v51, null, v51, v43, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v44, v50, v52
	v_mad_co_u64_u32 v[42:43], null, v49, v52, 0
	v_mul_lo_u32 v45, v49, v51
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v49, v52, v42
	v_add3_u32 v47, v43, v45, v44
	v_mad_co_u64_u32 v[45:46], null, v51, v42, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[43:44], null, v52, v47, 0
	v_mad_co_u64_u32 v[47:48], null, v51, v47, 0
	v_add_co_u32 v42, vcc_lo, v49, v43
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v43, null, 0, v44, vcc_lo
	v_add_co_u32 v42, vcc_lo, v42, v45
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v42, vcc_lo, v43, v46, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v43, vcc_lo, 0, v48, vcc_lo
	v_add_co_u32 v42, vcc_lo, v42, v47
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v43, null, 0, v43, vcc_lo
	v_add_co_u32 v44, vcc_lo, v52, v42
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v46, null, v51, v43, vcc_lo
	v_mul_hi_u32 v48, v40, v44
	v_mad_co_u64_u32 v[44:45], null, v41, v44, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[42:43], null, v40, v46, 0
	v_mad_co_u64_u32 v[46:47], null, v41, v46, 0
	v_add_co_u32 v42, vcc_lo, v48, v42
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v43, null, 0, v43, vcc_lo
	v_add_co_u32 v42, vcc_lo, v42, v44
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v42, vcc_lo, v43, v45, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v43, vcc_lo, 0, v47, vcc_lo
	v_add_co_u32 v44, vcc_lo, v42, v46
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v45, null, 0, v43, vcc_lo
	v_mul_lo_u32 v46, v3, v44
	v_mad_co_u64_u32 v[42:43], null, v2, v44, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v47, v2, v45
	v_sub_co_u32 v40, vcc_lo, v40, v42
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v43, v43, v47, v46
	v_sub_nc_u32_e32 v46, v41, v43
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v41, null, v41, v43, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v42, null, v46, v3, vcc_lo
	v_add_co_u32 v46, s0, v44, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v47, null, 0, v45, s0
	v_sub_co_u32 v47, s0, v40, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v42, null, 0, v42, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v47, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v42, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v47, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v40, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v40, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v41, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v48, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v42, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v42, v47, v43, vcc_lo
	v_add_co_u32 v43, vcc_lo, v44, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v45, null, 0, v45, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v41, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v40, v48, v40, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v42
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v41, v43, v46, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v40
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v42, v44, v41, vcc_lo
                                        ; implicit-def: $vgpr40_vgpr41
.LBB11_209:                             ; %Flow426
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_211
; %bb.210:
	v_cvt_f32_u32_e32 v41, v2
	v_sub_nc_u32_e32 v42, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v41, v41
	v_mul_f32_e32 v41, 0x4f7ffffe, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v41, v41
	v_mul_lo_u32 v42, v42, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v42, v41, v42
	v_add_nc_u32_e32 v41, v41, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v41, v40, v41
	v_mul_lo_u32 v42, v41, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v40, v40, v42
	v_add_nc_u32_e32 v42, 1, v41
	v_sub_nc_u32_e32 v43, v40, v2
	v_cmp_ge_u32_e32 vcc_lo, v40, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v40, v40, v43 :: v_dual_cndmask_b32 v41, v41, v42
	v_cmp_ge_u32_e32 vcc_lo, v40, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v42, 1, v41
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v42, v41, v42, vcc_lo
.LBB11_211:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v41, 0 :: v_dual_add_nc_u32 v40, 1, v42
	scratch_store_b32 off, v40, off offset:132
.LBB11_212:                             ; %Flow427
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v44, v[4:5], off offset:136
	v_mov_b32_e32 v42, 0
	v_mov_b32_e32 v43, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v44
	s_cbranch_execz .LBB11_218
; %bb.213:
	v_ashrrev_i32_e32 v45, 31, v44
	v_mul_lo_u32 v46, v65, v44
	v_mad_co_u64_u32 v[42:43], null, v64, v44, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v44, v64, v45
	v_add3_u32 v43, v43, v44, v46
	v_mov_b32_e32 v44, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v45, v43, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[44:45]
                                        ; implicit-def: $vgpr44_vgpr45
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_215
; %bb.214:
	v_cvt_f32_u32_e32 v44, v2
	v_cvt_f32_u32_e32 v45, v3
	v_sub_co_u32 v51, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v52, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v44, v45, 0x4f800000, v44
	v_rcp_f32_e32 v44, v44
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v44, 0x5f7ffffc, v44
	v_mul_f32_e32 v45, 0x2f800000, v44
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v45, v45
	v_fmamk_f32 v44, v45, 0xcf800000, v44
	v_cvt_u32_f32_e32 v53, v45
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v54, v44
	v_mul_lo_u32 v46, v51, v53
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v47, v52, v54
	v_mad_co_u64_u32 v[44:45], null, v51, v54, 0
	v_add3_u32 v49, v45, v46, v47
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v55, v54, v44
	v_mad_co_u64_u32 v[47:48], null, v53, v44, 0
	v_mad_co_u64_u32 v[45:46], null, v54, v49, 0
	v_mad_co_u64_u32 v[49:50], null, v53, v49, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v44, vcc_lo, v55, v45
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v45, null, 0, v46, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v44, vcc_lo, v44, v47
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v44, vcc_lo, v45, v48, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v45, vcc_lo, 0, v50, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v44, vcc_lo, v44, v49
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v45, null, 0, v45, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v54, vcc_lo, v54, v44
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v53, null, v53, v45, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v46, v52, v54
	v_mad_co_u64_u32 v[44:45], null, v51, v54, 0
	v_mul_lo_u32 v47, v51, v53
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v51, v54, v44
	v_add3_u32 v49, v45, v47, v46
	v_mad_co_u64_u32 v[47:48], null, v53, v44, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[45:46], null, v54, v49, 0
	v_mad_co_u64_u32 v[49:50], null, v53, v49, 0
	v_add_co_u32 v44, vcc_lo, v51, v45
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v45, null, 0, v46, vcc_lo
	v_add_co_u32 v44, vcc_lo, v44, v47
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v44, vcc_lo, v45, v48, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v45, vcc_lo, 0, v50, vcc_lo
	v_add_co_u32 v44, vcc_lo, v44, v49
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v45, null, 0, v45, vcc_lo
	v_add_co_u32 v46, vcc_lo, v54, v44
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v48, null, v53, v45, vcc_lo
	v_mul_hi_u32 v50, v42, v46
	v_mad_co_u64_u32 v[46:47], null, v43, v46, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[44:45], null, v42, v48, 0
	v_mad_co_u64_u32 v[48:49], null, v43, v48, 0
	v_add_co_u32 v44, vcc_lo, v50, v44
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v45, null, 0, v45, vcc_lo
	v_add_co_u32 v44, vcc_lo, v44, v46
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v44, vcc_lo, v45, v47, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v45, vcc_lo, 0, v49, vcc_lo
	v_add_co_u32 v46, vcc_lo, v44, v48
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v47, null, 0, v45, vcc_lo
	v_mul_lo_u32 v48, v3, v46
	v_mad_co_u64_u32 v[44:45], null, v2, v46, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v49, v2, v47
	v_sub_co_u32 v42, vcc_lo, v42, v44
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v45, v45, v49, v48
	v_sub_nc_u32_e32 v48, v43, v45
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v43, null, v43, v45, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v44, null, v48, v3, vcc_lo
	v_add_co_u32 v48, s0, v46, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v49, null, 0, v47, s0
	v_sub_co_u32 v49, s0, v42, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v44, null, 0, v44, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v49, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v45, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v44, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v49, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v42, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v43, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v50, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v44, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v44, v49, v45, vcc_lo
	v_add_co_u32 v45, vcc_lo, v46, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v47, null, 0, v47, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v43, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v42, v50, v42, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v44
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v43, v45, v48, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v42
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v44, v46, v43, vcc_lo
                                        ; implicit-def: $vgpr42_vgpr43
.LBB11_215:                             ; %Flow424
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_217
; %bb.216:
	v_cvt_f32_u32_e32 v43, v2
	v_sub_nc_u32_e32 v44, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v43, v43
	v_mul_f32_e32 v43, 0x4f7ffffe, v43
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v43, v43
	v_mul_lo_u32 v44, v44, v43
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v44, v43, v44
	v_add_nc_u32_e32 v43, v43, v44
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v43, v42, v43
	v_mul_lo_u32 v44, v43, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v42, v42, v44
	v_add_nc_u32_e32 v44, 1, v43
	v_sub_nc_u32_e32 v45, v42, v2
	v_cmp_ge_u32_e32 vcc_lo, v42, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v42, v42, v45 :: v_dual_cndmask_b32 v43, v43, v44
	v_cmp_ge_u32_e32 vcc_lo, v42, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v44, 1, v43
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v44, v43, v44, vcc_lo
.LBB11_217:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v43, 0 :: v_dual_add_nc_u32 v42, 1, v44
	scratch_store_b32 off, v42, off offset:136
.LBB11_218:                             ; %Flow425
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v46, v[4:5], off offset:140
	v_mov_b32_e32 v44, 0
	v_mov_b32_e32 v45, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v46
	s_cbranch_execz .LBB11_224
; %bb.219:
	v_ashrrev_i32_e32 v47, 31, v46
	v_mul_lo_u32 v48, v65, v46
	v_mad_co_u64_u32 v[44:45], null, v64, v46, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v46, v64, v47
	v_add3_u32 v45, v45, v46, v48
	v_mov_b32_e32 v46, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v47, v45, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[46:47]
                                        ; implicit-def: $vgpr46_vgpr47
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_221
; %bb.220:
	v_cvt_f32_u32_e32 v46, v2
	v_cvt_f32_u32_e32 v47, v3
	v_sub_co_u32 v53, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v54, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v46, v47, 0x4f800000, v46
	v_rcp_f32_e32 v46, v46
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v46, 0x5f7ffffc, v46
	v_mul_f32_e32 v47, 0x2f800000, v46
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v47, v47
	v_fmamk_f32 v46, v47, 0xcf800000, v46
	v_cvt_u32_f32_e32 v55, v47
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v56, v46
	v_mul_lo_u32 v48, v53, v55
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v49, v54, v56
	v_mad_co_u64_u32 v[46:47], null, v53, v56, 0
	v_add3_u32 v51, v47, v48, v49
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v57, v56, v46
	v_mad_co_u64_u32 v[49:50], null, v55, v46, 0
	v_mad_co_u64_u32 v[47:48], null, v56, v51, 0
	v_mad_co_u64_u32 v[51:52], null, v55, v51, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v46, vcc_lo, v57, v47
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v47, null, 0, v48, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v46, vcc_lo, v46, v49
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v46, vcc_lo, v47, v50, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v47, vcc_lo, 0, v52, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v46, vcc_lo, v46, v51
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v47, null, 0, v47, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v56, vcc_lo, v56, v46
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v55, null, v55, v47, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v48, v54, v56
	v_mad_co_u64_u32 v[46:47], null, v53, v56, 0
	v_mul_lo_u32 v49, v53, v55
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v53, v56, v46
	v_add3_u32 v51, v47, v49, v48
	v_mad_co_u64_u32 v[49:50], null, v55, v46, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[47:48], null, v56, v51, 0
	v_mad_co_u64_u32 v[51:52], null, v55, v51, 0
	v_add_co_u32 v46, vcc_lo, v53, v47
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v47, null, 0, v48, vcc_lo
	v_add_co_u32 v46, vcc_lo, v46, v49
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v46, vcc_lo, v47, v50, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v47, vcc_lo, 0, v52, vcc_lo
	v_add_co_u32 v46, vcc_lo, v46, v51
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v47, null, 0, v47, vcc_lo
	v_add_co_u32 v48, vcc_lo, v56, v46
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v50, null, v55, v47, vcc_lo
	v_mul_hi_u32 v52, v44, v48
	v_mad_co_u64_u32 v[48:49], null, v45, v48, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[46:47], null, v44, v50, 0
	v_mad_co_u64_u32 v[50:51], null, v45, v50, 0
	v_add_co_u32 v46, vcc_lo, v52, v46
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v47, null, 0, v47, vcc_lo
	v_add_co_u32 v46, vcc_lo, v46, v48
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v46, vcc_lo, v47, v49, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v47, vcc_lo, 0, v51, vcc_lo
	v_add_co_u32 v48, vcc_lo, v46, v50
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v49, null, 0, v47, vcc_lo
	v_mul_lo_u32 v50, v3, v48
	v_mad_co_u64_u32 v[46:47], null, v2, v48, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v51, v2, v49
	v_sub_co_u32 v44, vcc_lo, v44, v46
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v47, v47, v51, v50
	v_sub_nc_u32_e32 v50, v45, v47
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v45, null, v45, v47, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v46, null, v50, v3, vcc_lo
	v_add_co_u32 v50, s0, v48, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v51, null, 0, v49, s0
	v_sub_co_u32 v51, s0, v44, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v46, null, 0, v46, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v51, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v47, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v46, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v51, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v44, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v45, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v52, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v46, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v46, v51, v47, vcc_lo
	v_add_co_u32 v47, vcc_lo, v48, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v49, null, 0, v49, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v45, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v44, v52, v44, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v46
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v45, v47, v50, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v44
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v46, v48, v45, vcc_lo
                                        ; implicit-def: $vgpr44_vgpr45
.LBB11_221:                             ; %Flow422
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_223
; %bb.222:
	v_cvt_f32_u32_e32 v45, v2
	v_sub_nc_u32_e32 v46, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v45, v45
	v_mul_f32_e32 v45, 0x4f7ffffe, v45
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v45, v45
	v_mul_lo_u32 v46, v46, v45
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v46, v45, v46
	v_add_nc_u32_e32 v45, v45, v46
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v45, v44, v45
	v_mul_lo_u32 v46, v45, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v44, v44, v46
	v_add_nc_u32_e32 v46, 1, v45
	v_sub_nc_u32_e32 v47, v44, v2
	v_cmp_ge_u32_e32 vcc_lo, v44, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v44, v44, v47 :: v_dual_cndmask_b32 v45, v45, v46
	v_cmp_ge_u32_e32 vcc_lo, v44, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v46, 1, v45
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v46, v45, v46, vcc_lo
.LBB11_223:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v45, 0 :: v_dual_add_nc_u32 v44, 1, v46
	scratch_store_b32 off, v44, off offset:140
.LBB11_224:                             ; %Flow423
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v48, v[4:5], off offset:144
	v_mov_b32_e32 v46, 0
	v_mov_b32_e32 v47, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v48
	s_cbranch_execz .LBB11_230
; %bb.225:
	v_ashrrev_i32_e32 v49, 31, v48
	v_mul_lo_u32 v50, v65, v48
	v_mad_co_u64_u32 v[46:47], null, v64, v48, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v48, v64, v49
	v_add3_u32 v47, v47, v48, v50
	v_mov_b32_e32 v48, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v49, v47, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[48:49]
                                        ; implicit-def: $vgpr48_vgpr49
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_227
; %bb.226:
	v_cvt_f32_u32_e32 v48, v2
	v_cvt_f32_u32_e32 v49, v3
	v_sub_co_u32 v55, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v56, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v48, v49, 0x4f800000, v48
	v_rcp_f32_e32 v48, v48
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v48, 0x5f7ffffc, v48
	v_mul_f32_e32 v49, 0x2f800000, v48
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v49, v49
	v_fmamk_f32 v48, v49, 0xcf800000, v48
	v_cvt_u32_f32_e32 v57, v49
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v58, v48
	v_mul_lo_u32 v50, v55, v57
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v51, v56, v58
	v_mad_co_u64_u32 v[48:49], null, v55, v58, 0
	v_add3_u32 v53, v49, v50, v51
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v59, v58, v48
	v_mad_co_u64_u32 v[51:52], null, v57, v48, 0
	v_mad_co_u64_u32 v[49:50], null, v58, v53, 0
	v_mad_co_u64_u32 v[53:54], null, v57, v53, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v48, vcc_lo, v59, v49
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v49, null, 0, v50, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v48, vcc_lo, v48, v51
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v48, vcc_lo, v49, v52, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v49, vcc_lo, 0, v54, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v48, vcc_lo, v48, v53
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v49, null, 0, v49, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v58, vcc_lo, v58, v48
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v57, null, v57, v49, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v50, v56, v58
	v_mad_co_u64_u32 v[48:49], null, v55, v58, 0
	v_mul_lo_u32 v51, v55, v57
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v55, v58, v48
	v_add3_u32 v53, v49, v51, v50
	v_mad_co_u64_u32 v[51:52], null, v57, v48, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[49:50], null, v58, v53, 0
	v_mad_co_u64_u32 v[53:54], null, v57, v53, 0
	v_add_co_u32 v48, vcc_lo, v55, v49
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v49, null, 0, v50, vcc_lo
	v_add_co_u32 v48, vcc_lo, v48, v51
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v48, vcc_lo, v49, v52, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v49, vcc_lo, 0, v54, vcc_lo
	v_add_co_u32 v48, vcc_lo, v48, v53
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v49, null, 0, v49, vcc_lo
	v_add_co_u32 v50, vcc_lo, v58, v48
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v52, null, v57, v49, vcc_lo
	v_mul_hi_u32 v54, v46, v50
	v_mad_co_u64_u32 v[50:51], null, v47, v50, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[48:49], null, v46, v52, 0
	v_mad_co_u64_u32 v[52:53], null, v47, v52, 0
	v_add_co_u32 v48, vcc_lo, v54, v48
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v49, null, 0, v49, vcc_lo
	v_add_co_u32 v48, vcc_lo, v48, v50
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v48, vcc_lo, v49, v51, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v49, vcc_lo, 0, v53, vcc_lo
	v_add_co_u32 v50, vcc_lo, v48, v52
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v51, null, 0, v49, vcc_lo
	v_mul_lo_u32 v52, v3, v50
	v_mad_co_u64_u32 v[48:49], null, v2, v50, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v53, v2, v51
	v_sub_co_u32 v46, vcc_lo, v46, v48
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v49, v49, v53, v52
	v_sub_nc_u32_e32 v52, v47, v49
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v47, null, v47, v49, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v48, null, v52, v3, vcc_lo
	v_add_co_u32 v52, s0, v50, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v53, null, 0, v51, s0
	v_sub_co_u32 v53, s0, v46, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v48, null, 0, v48, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v53, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v49, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v48, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v53, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v46, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v46, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v47, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v54, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v48, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v48, v53, v49, vcc_lo
	v_add_co_u32 v49, vcc_lo, v50, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v51, null, 0, v51, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v47, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v46, v54, v46, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v48
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v47, v49, v52, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v46
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v48, v50, v47, vcc_lo
                                        ; implicit-def: $vgpr46_vgpr47
.LBB11_227:                             ; %Flow420
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_229
; %bb.228:
	v_cvt_f32_u32_e32 v47, v2
	v_sub_nc_u32_e32 v48, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v47, v47
	v_mul_f32_e32 v47, 0x4f7ffffe, v47
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v47, v47
	v_mul_lo_u32 v48, v48, v47
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v48, v47, v48
	v_add_nc_u32_e32 v47, v47, v48
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v47, v46, v47
	v_mul_lo_u32 v48, v47, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v46, v46, v48
	v_add_nc_u32_e32 v48, 1, v47
	v_sub_nc_u32_e32 v49, v46, v2
	v_cmp_ge_u32_e32 vcc_lo, v46, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v46, v46, v49 :: v_dual_cndmask_b32 v47, v47, v48
	v_cmp_ge_u32_e32 vcc_lo, v46, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v48, 1, v47
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v48, v47, v48, vcc_lo
.LBB11_229:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v47, 0 :: v_dual_add_nc_u32 v46, 1, v48
	scratch_store_b32 off, v46, off offset:144
.LBB11_230:                             ; %Flow421
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v50, v[4:5], off offset:148
	v_mov_b32_e32 v48, 0
	v_mov_b32_e32 v49, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v50
	s_cbranch_execz .LBB11_236
; %bb.231:
	v_ashrrev_i32_e32 v51, 31, v50
	v_mul_lo_u32 v52, v65, v50
	v_mad_co_u64_u32 v[48:49], null, v64, v50, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v50, v64, v51
	v_add3_u32 v49, v49, v50, v52
	v_mov_b32_e32 v50, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v51, v49, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[50:51]
                                        ; implicit-def: $vgpr50_vgpr51
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_233
; %bb.232:
	v_cvt_f32_u32_e32 v50, v2
	v_cvt_f32_u32_e32 v51, v3
	v_sub_co_u32 v57, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v58, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v50, v51, 0x4f800000, v50
	v_rcp_f32_e32 v50, v50
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v50, 0x5f7ffffc, v50
	v_mul_f32_e32 v51, 0x2f800000, v50
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v51, v51
	v_fmamk_f32 v50, v51, 0xcf800000, v50
	v_cvt_u32_f32_e32 v59, v51
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v60, v50
	v_mul_lo_u32 v52, v57, v59
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v53, v58, v60
	v_mad_co_u64_u32 v[50:51], null, v57, v60, 0
	v_add3_u32 v55, v51, v52, v53
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v61, v60, v50
	v_mad_co_u64_u32 v[53:54], null, v59, v50, 0
	v_mad_co_u64_u32 v[51:52], null, v60, v55, 0
	v_mad_co_u64_u32 v[55:56], null, v59, v55, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v50, vcc_lo, v61, v51
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v51, null, 0, v52, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v50, vcc_lo, v50, v53
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v50, vcc_lo, v51, v54, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v51, vcc_lo, 0, v56, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v50, vcc_lo, v50, v55
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v51, null, 0, v51, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v60, vcc_lo, v60, v50
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v59, null, v59, v51, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v52, v58, v60
	v_mad_co_u64_u32 v[50:51], null, v57, v60, 0
	v_mul_lo_u32 v53, v57, v59
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v57, v60, v50
	v_add3_u32 v55, v51, v53, v52
	v_mad_co_u64_u32 v[53:54], null, v59, v50, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[51:52], null, v60, v55, 0
	v_mad_co_u64_u32 v[55:56], null, v59, v55, 0
	v_add_co_u32 v50, vcc_lo, v57, v51
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v51, null, 0, v52, vcc_lo
	v_add_co_u32 v50, vcc_lo, v50, v53
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v50, vcc_lo, v51, v54, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v51, vcc_lo, 0, v56, vcc_lo
	v_add_co_u32 v50, vcc_lo, v50, v55
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v51, null, 0, v51, vcc_lo
	v_add_co_u32 v52, vcc_lo, v60, v50
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v54, null, v59, v51, vcc_lo
	v_mul_hi_u32 v56, v48, v52
	v_mad_co_u64_u32 v[52:53], null, v49, v52, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[50:51], null, v48, v54, 0
	v_mad_co_u64_u32 v[54:55], null, v49, v54, 0
	v_add_co_u32 v50, vcc_lo, v56, v50
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v51, null, 0, v51, vcc_lo
	v_add_co_u32 v50, vcc_lo, v50, v52
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v50, vcc_lo, v51, v53, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v51, vcc_lo, 0, v55, vcc_lo
	v_add_co_u32 v52, vcc_lo, v50, v54
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v53, null, 0, v51, vcc_lo
	v_mul_lo_u32 v54, v3, v52
	v_mad_co_u64_u32 v[50:51], null, v2, v52, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v55, v2, v53
	v_sub_co_u32 v48, vcc_lo, v48, v50
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v51, v51, v55, v54
	v_sub_nc_u32_e32 v54, v49, v51
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v49, null, v49, v51, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v50, null, v54, v3, vcc_lo
	v_add_co_u32 v54, s0, v52, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v55, null, 0, v53, s0
	v_sub_co_u32 v55, s0, v48, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v50, null, 0, v50, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v55, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v51, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v50, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v55, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v48, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v48, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v49, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v56, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v50, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v50, v55, v51, vcc_lo
	v_add_co_u32 v51, vcc_lo, v52, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v53, null, 0, v53, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v49, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v48, v56, v48, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v50
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v49, v51, v54, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v48
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v50, v52, v49, vcc_lo
                                        ; implicit-def: $vgpr48_vgpr49
.LBB11_233:                             ; %Flow418
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_235
; %bb.234:
	v_cvt_f32_u32_e32 v49, v2
	v_sub_nc_u32_e32 v50, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v49, v49
	v_mul_f32_e32 v49, 0x4f7ffffe, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v49, v49
	v_mul_lo_u32 v50, v50, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v50, v49, v50
	v_add_nc_u32_e32 v49, v49, v50
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v49, v48, v49
	v_mul_lo_u32 v50, v49, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v48, v48, v50
	v_add_nc_u32_e32 v50, 1, v49
	v_sub_nc_u32_e32 v51, v48, v2
	v_cmp_ge_u32_e32 vcc_lo, v48, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v48, v48, v51 :: v_dual_cndmask_b32 v49, v49, v50
	v_cmp_ge_u32_e32 vcc_lo, v48, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v50, 1, v49
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v50, v49, v50, vcc_lo
.LBB11_235:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v49, 0 :: v_dual_add_nc_u32 v48, 1, v50
	scratch_store_b32 off, v48, off offset:148
.LBB11_236:                             ; %Flow419
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v52, v[4:5], off offset:152
	v_mov_b32_e32 v50, 0
	v_mov_b32_e32 v51, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v52
	s_cbranch_execz .LBB11_242
; %bb.237:
	v_ashrrev_i32_e32 v53, 31, v52
	v_mul_lo_u32 v54, v65, v52
	v_mad_co_u64_u32 v[50:51], null, v64, v52, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v52, v64, v53
	v_add3_u32 v51, v51, v52, v54
	v_mov_b32_e32 v52, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v53, v51, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[52:53]
                                        ; implicit-def: $vgpr52_vgpr53
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_239
; %bb.238:
	v_cvt_f32_u32_e32 v52, v2
	v_cvt_f32_u32_e32 v53, v3
	v_sub_co_u32 v59, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v60, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v52, v53, 0x4f800000, v52
	v_rcp_f32_e32 v52, v52
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v52, 0x5f7ffffc, v52
	v_mul_f32_e32 v53, 0x2f800000, v52
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v53, v53
	v_fmamk_f32 v52, v53, 0xcf800000, v52
	v_cvt_u32_f32_e32 v61, v53
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v62, v52
	v_mul_lo_u32 v54, v59, v61
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v55, v60, v62
	v_mad_co_u64_u32 v[52:53], null, v59, v62, 0
	v_add3_u32 v57, v53, v54, v55
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v63, v62, v52
	v_mad_co_u64_u32 v[55:56], null, v61, v52, 0
	v_mad_co_u64_u32 v[53:54], null, v62, v57, 0
	v_mad_co_u64_u32 v[57:58], null, v61, v57, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v52, vcc_lo, v63, v53
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v53, null, 0, v54, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v52, vcc_lo, v52, v55
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v52, vcc_lo, v53, v56, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v53, vcc_lo, 0, v58, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v52, vcc_lo, v52, v57
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v53, null, 0, v53, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v52
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v61, null, v61, v53, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v54, v60, v62
	v_mad_co_u64_u32 v[52:53], null, v59, v62, 0
	v_mul_lo_u32 v55, v59, v61
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v59, v62, v52
	v_add3_u32 v57, v53, v55, v54
	v_mad_co_u64_u32 v[55:56], null, v61, v52, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[53:54], null, v62, v57, 0
	v_mad_co_u64_u32 v[57:58], null, v61, v57, 0
	v_add_co_u32 v52, vcc_lo, v59, v53
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v53, null, 0, v54, vcc_lo
	v_add_co_u32 v52, vcc_lo, v52, v55
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v52, vcc_lo, v53, v56, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v53, vcc_lo, 0, v58, vcc_lo
	v_add_co_u32 v52, vcc_lo, v52, v57
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v53, null, 0, v53, vcc_lo
	v_add_co_u32 v54, vcc_lo, v62, v52
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v56, null, v61, v53, vcc_lo
	v_mul_hi_u32 v58, v50, v54
	v_mad_co_u64_u32 v[54:55], null, v51, v54, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[52:53], null, v50, v56, 0
	v_mad_co_u64_u32 v[56:57], null, v51, v56, 0
	v_add_co_u32 v52, vcc_lo, v58, v52
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v53, null, 0, v53, vcc_lo
	v_add_co_u32 v52, vcc_lo, v52, v54
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v52, vcc_lo, v53, v55, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v53, vcc_lo, 0, v57, vcc_lo
	v_add_co_u32 v54, vcc_lo, v52, v56
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v55, null, 0, v53, vcc_lo
	v_mul_lo_u32 v56, v3, v54
	v_mad_co_u64_u32 v[52:53], null, v2, v54, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v57, v2, v55
	v_sub_co_u32 v50, vcc_lo, v50, v52
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v53, v53, v57, v56
	v_sub_nc_u32_e32 v56, v51, v53
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v51, null, v51, v53, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v52, null, v56, v3, vcc_lo
	v_add_co_u32 v56, s0, v54, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v57, null, 0, v55, s0
	v_sub_co_u32 v57, s0, v50, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v52, null, 0, v52, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v57, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v53, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v52, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v57, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v50, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v50, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v51, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v58, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v52, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v52, v57, v53, vcc_lo
	v_add_co_u32 v53, vcc_lo, v54, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v55, null, 0, v55, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v51, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v50, v58, v50, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v52
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v51, v53, v56, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v50
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v52, v54, v51, vcc_lo
                                        ; implicit-def: $vgpr50_vgpr51
.LBB11_239:                             ; %Flow416
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_241
; %bb.240:
	v_cvt_f32_u32_e32 v51, v2
	v_sub_nc_u32_e32 v52, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v51, v51
	v_mul_f32_e32 v51, 0x4f7ffffe, v51
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v51, v51
	v_mul_lo_u32 v52, v52, v51
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v52, v51, v52
	v_add_nc_u32_e32 v51, v51, v52
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v51, v50, v51
	v_mul_lo_u32 v52, v51, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v50, v50, v52
	v_add_nc_u32_e32 v52, 1, v51
	v_sub_nc_u32_e32 v53, v50, v2
	v_cmp_ge_u32_e32 vcc_lo, v50, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v50, v50, v53 :: v_dual_cndmask_b32 v51, v51, v52
	v_cmp_ge_u32_e32 vcc_lo, v50, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v52, 1, v51
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v52, v51, v52, vcc_lo
.LBB11_241:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v51, 0 :: v_dual_add_nc_u32 v50, 1, v52
	scratch_store_b32 off, v50, off offset:152
.LBB11_242:                             ; %Flow417
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v54, v[4:5], off offset:156
	v_mov_b32_e32 v52, 0
	v_mov_b32_e32 v53, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v54
	s_cbranch_execz .LBB11_248
; %bb.243:
	v_ashrrev_i32_e32 v55, 31, v54
	v_mul_lo_u32 v56, v65, v54
	v_mad_co_u64_u32 v[52:53], null, v64, v54, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v54, v64, v55
	v_add3_u32 v53, v53, v54, v56
	v_mov_b32_e32 v54, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v55, v53, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[54:55]
                                        ; implicit-def: $vgpr54_vgpr55
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_245
; %bb.244:
	v_cvt_f32_u32_e32 v54, v2
	v_cvt_f32_u32_e32 v55, v3
	v_sub_co_u32 v61, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v62, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v54, v55, 0x4f800000, v54
	v_rcp_f32_e32 v54, v54
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v54, 0x5f7ffffc, v54
	v_mul_f32_e32 v55, 0x2f800000, v54
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v55, v55
	v_fmamk_f32 v54, v55, 0xcf800000, v54
	v_cvt_u32_f32_e32 v63, v55
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v66, v54
	v_mul_lo_u32 v56, v61, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v57, v62, v66
	v_mad_co_u64_u32 v[54:55], null, v61, v66, 0
	v_add3_u32 v59, v55, v56, v57
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v67, v66, v54
	v_mad_co_u64_u32 v[57:58], null, v63, v54, 0
	v_mad_co_u64_u32 v[55:56], null, v66, v59, 0
	v_mad_co_u64_u32 v[59:60], null, v63, v59, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v54, vcc_lo, v67, v55
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v55, null, 0, v56, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v54, vcc_lo, v54, v57
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v54, vcc_lo, v55, v58, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v55, vcc_lo, 0, v60, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v54, vcc_lo, v54, v59
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v55, null, 0, v55, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v66, vcc_lo, v66, v54
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, v63, v55, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v56, v62, v66
	v_mad_co_u64_u32 v[54:55], null, v61, v66, 0
	v_mul_lo_u32 v57, v61, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v61, v66, v54
	v_add3_u32 v59, v55, v57, v56
	v_mad_co_u64_u32 v[57:58], null, v63, v54, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[55:56], null, v66, v59, 0
	v_mad_co_u64_u32 v[59:60], null, v63, v59, 0
	v_add_co_u32 v54, vcc_lo, v61, v55
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v55, null, 0, v56, vcc_lo
	v_add_co_u32 v54, vcc_lo, v54, v57
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v54, vcc_lo, v55, v58, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v55, vcc_lo, 0, v60, vcc_lo
	v_add_co_u32 v54, vcc_lo, v54, v59
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v55, null, 0, v55, vcc_lo
	v_add_co_u32 v56, vcc_lo, v66, v54
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v58, null, v63, v55, vcc_lo
	v_mul_hi_u32 v60, v52, v56
	v_mad_co_u64_u32 v[56:57], null, v53, v56, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[54:55], null, v52, v58, 0
	v_mad_co_u64_u32 v[58:59], null, v53, v58, 0
	v_add_co_u32 v54, vcc_lo, v60, v54
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v55, null, 0, v55, vcc_lo
	v_add_co_u32 v54, vcc_lo, v54, v56
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v54, vcc_lo, v55, v57, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v55, vcc_lo, 0, v59, vcc_lo
	v_add_co_u32 v56, vcc_lo, v54, v58
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v57, null, 0, v55, vcc_lo
	v_mul_lo_u32 v58, v3, v56
	v_mad_co_u64_u32 v[54:55], null, v2, v56, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v59, v2, v57
	v_sub_co_u32 v52, vcc_lo, v52, v54
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v55, v55, v59, v58
	v_sub_nc_u32_e32 v58, v53, v55
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v53, null, v53, v55, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v54, null, v58, v3, vcc_lo
	v_add_co_u32 v58, s0, v56, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v59, null, 0, v57, s0
	v_sub_co_u32 v59, s0, v52, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v54, null, 0, v54, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v59, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v55, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v54, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v52, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v52, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v53, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v54, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v54, v59, v55, vcc_lo
	v_add_co_u32 v55, vcc_lo, v56, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v57, null, 0, v57, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v53, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v52, v60, v52, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v54
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v53, v55, v58, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v52
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v54, v56, v53, vcc_lo
                                        ; implicit-def: $vgpr52_vgpr53
.LBB11_245:                             ; %Flow414
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_247
; %bb.246:
	v_cvt_f32_u32_e32 v53, v2
	v_sub_nc_u32_e32 v54, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v53, v53
	v_mul_f32_e32 v53, 0x4f7ffffe, v53
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v53, v53
	v_mul_lo_u32 v54, v54, v53
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v54, v53, v54
	v_add_nc_u32_e32 v53, v53, v54
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v53, v52, v53
	v_mul_lo_u32 v54, v53, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v52, v52, v54
	v_add_nc_u32_e32 v54, 1, v53
	v_sub_nc_u32_e32 v55, v52, v2
	v_cmp_ge_u32_e32 vcc_lo, v52, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v52, v52, v55 :: v_dual_cndmask_b32 v53, v53, v54
	v_cmp_ge_u32_e32 vcc_lo, v52, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v54, 1, v53
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v54, v53, v54, vcc_lo
.LBB11_247:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v53, 0 :: v_dual_add_nc_u32 v52, 1, v54
	scratch_store_b32 off, v52, off offset:156
.LBB11_248:                             ; %Flow415
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v56, v[4:5], off offset:160
	v_mov_b32_e32 v54, 0
	v_mov_b32_e32 v55, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v56
	s_cbranch_execz .LBB11_254
; %bb.249:
	v_ashrrev_i32_e32 v57, 31, v56
	v_mul_lo_u32 v58, v65, v56
	v_mad_co_u64_u32 v[54:55], null, v64, v56, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v56, v64, v57
	v_add3_u32 v55, v55, v56, v58
	v_mov_b32_e32 v56, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v57, v55, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[56:57]
                                        ; implicit-def: $vgpr56_vgpr57
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_251
; %bb.250:
	v_cvt_f32_u32_e32 v56, v2
	v_cvt_f32_u32_e32 v57, v3
	v_sub_co_u32 v63, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v66, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v56, v57, 0x4f800000, v56
	v_rcp_f32_e32 v56, v56
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v56, 0x5f7ffffc, v56
	v_mul_f32_e32 v57, 0x2f800000, v56
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v57, v57
	v_fmamk_f32 v56, v57, 0xcf800000, v56
	v_cvt_u32_f32_e32 v67, v57
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v68, v56
	v_mul_lo_u32 v58, v63, v67
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v59, v66, v68
	v_mad_co_u64_u32 v[56:57], null, v63, v68, 0
	v_add3_u32 v61, v57, v58, v59
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v69, v68, v56
	v_mad_co_u64_u32 v[59:60], null, v67, v56, 0
	v_mad_co_u64_u32 v[57:58], null, v68, v61, 0
	v_mad_co_u64_u32 v[61:62], null, v67, v61, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v56, vcc_lo, v69, v57
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v57, null, 0, v58, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v56, vcc_lo, v56, v59
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v56, vcc_lo, v57, v60, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v57, vcc_lo, 0, v62, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v56, vcc_lo, v56, v61
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v57, null, 0, v57, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v68, vcc_lo, v68, v56
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v67, null, v67, v57, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v58, v66, v68
	v_mad_co_u64_u32 v[56:57], null, v63, v68, 0
	v_mul_lo_u32 v59, v63, v67
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v63, v68, v56
	v_add3_u32 v61, v57, v59, v58
	v_mad_co_u64_u32 v[59:60], null, v67, v56, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[57:58], null, v68, v61, 0
	v_mad_co_u64_u32 v[61:62], null, v67, v61, 0
	v_add_co_u32 v56, vcc_lo, v63, v57
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v57, null, 0, v58, vcc_lo
	v_add_co_u32 v56, vcc_lo, v56, v59
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v56, vcc_lo, v57, v60, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v57, vcc_lo, 0, v62, vcc_lo
	v_add_co_u32 v56, vcc_lo, v56, v61
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v57, null, 0, v57, vcc_lo
	v_add_co_u32 v58, vcc_lo, v68, v56
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v60, null, v67, v57, vcc_lo
	v_mul_hi_u32 v62, v54, v58
	v_mad_co_u64_u32 v[58:59], null, v55, v58, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[56:57], null, v54, v60, 0
	v_mad_co_u64_u32 v[60:61], null, v55, v60, 0
	v_add_co_u32 v56, vcc_lo, v62, v56
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v57, null, 0, v57, vcc_lo
	v_add_co_u32 v56, vcc_lo, v56, v58
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v56, vcc_lo, v57, v59, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v57, vcc_lo, 0, v61, vcc_lo
	v_add_co_u32 v58, vcc_lo, v56, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v59, null, 0, v57, vcc_lo
	v_mul_lo_u32 v60, v3, v58
	v_mad_co_u64_u32 v[56:57], null, v2, v58, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v61, v2, v59
	v_sub_co_u32 v54, vcc_lo, v54, v56
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v57, v57, v61, v60
	v_sub_nc_u32_e32 v60, v55, v57
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v55, null, v55, v57, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v56, null, v60, v3, vcc_lo
	v_add_co_u32 v60, s0, v58, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v61, null, 0, v59, s0
	v_sub_co_u32 v61, s0, v54, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v56, null, 0, v56, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v61, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v57, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v56, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v54, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v54, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v55, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v62, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v56, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v56, v61, v57, vcc_lo
	v_add_co_u32 v57, vcc_lo, v58, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v59, null, 0, v59, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v55, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v54, v62, v54, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v56
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v55, v57, v60, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v54
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v56, v58, v55, vcc_lo
                                        ; implicit-def: $vgpr54_vgpr55
.LBB11_251:                             ; %Flow412
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_253
; %bb.252:
	v_cvt_f32_u32_e32 v55, v2
	v_sub_nc_u32_e32 v56, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v55, v55
	v_mul_f32_e32 v55, 0x4f7ffffe, v55
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v55, v55
	v_mul_lo_u32 v56, v56, v55
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v56, v55, v56
	v_add_nc_u32_e32 v55, v55, v56
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v55, v54, v55
	v_mul_lo_u32 v56, v55, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v54, v54, v56
	v_add_nc_u32_e32 v56, 1, v55
	v_sub_nc_u32_e32 v57, v54, v2
	v_cmp_ge_u32_e32 vcc_lo, v54, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v54, v54, v57 :: v_dual_cndmask_b32 v55, v55, v56
	v_cmp_ge_u32_e32 vcc_lo, v54, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v56, 1, v55
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v56, v55, v56, vcc_lo
.LBB11_253:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v55, 0 :: v_dual_add_nc_u32 v54, 1, v56
	scratch_store_b32 off, v54, off offset:160
.LBB11_254:                             ; %Flow413
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v58, v[4:5], off offset:164
	v_mov_b32_e32 v56, 0
	v_mov_b32_e32 v57, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v58
	s_cbranch_execz .LBB11_260
; %bb.255:
	v_ashrrev_i32_e32 v59, 31, v58
	v_mul_lo_u32 v60, v65, v58
	v_mad_co_u64_u32 v[56:57], null, v64, v58, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v58, v64, v59
	v_add3_u32 v57, v57, v58, v60
	v_mov_b32_e32 v58, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v59, v57, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[58:59]
                                        ; implicit-def: $vgpr58_vgpr59
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_257
; %bb.256:
	v_cvt_f32_u32_e32 v58, v2
	v_cvt_f32_u32_e32 v59, v3
	v_sub_co_u32 v63, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v68, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v58, v59, 0x4f800000, v58
	v_rcp_f32_e32 v58, v58
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v58, 0x5f7ffffc, v58
	v_mul_f32_e32 v59, 0x2f800000, v58
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v59, v59
	v_fmamk_f32 v58, v59, 0xcf800000, v58
	v_cvt_u32_f32_e32 v69, v59
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v70, v58
	v_mul_lo_u32 v60, v63, v69
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v61, v68, v70
	v_mad_co_u64_u32 v[58:59], null, v63, v70, 0
	v_add3_u32 v66, v59, v60, v61
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v71, v70, v58
	v_mad_co_u64_u32 v[61:62], null, v69, v58, 0
	v_mad_co_u64_u32 v[59:60], null, v70, v66, 0
	v_mad_co_u64_u32 v[66:67], null, v69, v66, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v58, vcc_lo, v71, v59
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v59, null, 0, v60, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v58, vcc_lo, v58, v61
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v58, vcc_lo, v59, v62, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v59, vcc_lo, 0, v67, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v58, vcc_lo, v58, v66
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v59, null, 0, v59, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v70, vcc_lo, v70, v58
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v69, null, v69, v59, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v60, v68, v70
	v_mad_co_u64_u32 v[58:59], null, v63, v70, 0
	v_mul_lo_u32 v61, v63, v69
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v68, v70, v58
	v_add3_u32 v63, v59, v61, v60
	v_mad_co_u64_u32 v[61:62], null, v69, v58, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[59:60], null, v70, v63, 0
	v_mad_co_u64_u32 v[66:67], null, v69, v63, 0
	v_add_co_u32 v58, vcc_lo, v68, v59
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v59, null, 0, v60, vcc_lo
	v_add_co_u32 v58, vcc_lo, v58, v61
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v58, vcc_lo, v59, v62, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v59, vcc_lo, 0, v67, vcc_lo
	v_add_co_u32 v58, vcc_lo, v58, v66
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v59, null, 0, v59, vcc_lo
	v_add_co_u32 v60, vcc_lo, v70, v58
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v62, null, v69, v59, vcc_lo
	v_mul_hi_u32 v66, v56, v60
	v_mad_co_u64_u32 v[60:61], null, v57, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[58:59], null, v56, v62, 0
	v_mad_co_u64_u32 v[62:63], null, v57, v62, 0
	v_add_co_u32 v58, vcc_lo, v66, v58
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v59, null, 0, v59, vcc_lo
	v_add_co_u32 v58, vcc_lo, v58, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v58, vcc_lo, v59, v61, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v59, vcc_lo, 0, v63, vcc_lo
	v_add_co_u32 v60, vcc_lo, v58, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v59, vcc_lo
	v_mul_lo_u32 v62, v3, v60
	v_mad_co_u64_u32 v[58:59], null, v2, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v63, v2, v61
	v_sub_co_u32 v56, vcc_lo, v56, v58
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v59, v59, v63, v62
	v_sub_nc_u32_e32 v62, v57, v59
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v57, null, v57, v59, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v58, null, v62, v3, vcc_lo
	v_add_co_u32 v62, s0, v60, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v63, null, 0, v61, s0
	v_sub_co_u32 v63, s0, v56, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v58, null, 0, v58, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v63, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v58, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v56, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v56, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v57, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v66, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v58, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v58, v63, v59, vcc_lo
	v_add_co_u32 v59, vcc_lo, v60, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v57, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v56, v66, v56, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v58
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v57, v59, v62, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v56
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v58, v60, v57, vcc_lo
                                        ; implicit-def: $vgpr56_vgpr57
.LBB11_257:                             ; %Flow410
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_259
; %bb.258:
	v_cvt_f32_u32_e32 v57, v2
	v_sub_nc_u32_e32 v58, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v57, v57
	v_mul_f32_e32 v57, 0x4f7ffffe, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v57, v57
	v_mul_lo_u32 v58, v58, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v58, v57, v58
	v_add_nc_u32_e32 v57, v57, v58
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v57, v56, v57
	v_mul_lo_u32 v58, v57, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v56, v56, v58
	v_add_nc_u32_e32 v58, 1, v57
	v_sub_nc_u32_e32 v59, v56, v2
	v_cmp_ge_u32_e32 vcc_lo, v56, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v56, v56, v59 :: v_dual_cndmask_b32 v57, v57, v58
	v_cmp_ge_u32_e32 vcc_lo, v56, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v58, 1, v57
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v58, v57, v58, vcc_lo
.LBB11_259:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v57, 0 :: v_dual_add_nc_u32 v56, 1, v58
	scratch_store_b32 off, v56, off offset:164
.LBB11_260:                             ; %Flow411
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:168
	v_mov_b32_e32 v58, 0
	v_mov_b32_e32 v59, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_266
; %bb.261:
	v_ashrrev_i32_e32 v61, 31, v60
	v_mul_lo_u32 v62, v65, v60
	v_mad_co_u64_u32 v[58:59], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v60, v64, v61
	v_add3_u32 v59, v59, v60, v62
	v_mov_b32_e32 v60, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v61, v59, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[60:61]
                                        ; implicit-def: $vgpr60_vgpr61
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_263
; %bb.262:
	v_cvt_f32_u32_e32 v60, v2
	v_cvt_f32_u32_e32 v61, v3
	v_sub_co_u32 v63, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v70, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v60, v61, 0x4f800000, v60
	v_rcp_f32_e32 v60, v60
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v60, 0x5f7ffffc, v60
	v_mul_f32_e32 v61, 0x2f800000, v60
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v61, v61
	v_fmamk_f32 v60, v61, 0xcf800000, v60
	v_cvt_u32_f32_e32 v71, v61
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v72, v60
	v_mul_lo_u32 v62, v63, v71
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v66, v70, v72
	v_mad_co_u64_u32 v[60:61], null, v63, v72, 0
	v_add3_u32 v68, v61, v62, v66
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v73, v72, v60
	v_mad_co_u64_u32 v[66:67], null, v71, v60, 0
	v_mad_co_u64_u32 v[61:62], null, v72, v68, 0
	v_mad_co_u64_u32 v[68:69], null, v71, v68, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v60, vcc_lo, v73, v61
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v61, null, 0, v62, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v60, vcc_lo, v60, v66
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v60, vcc_lo, v61, v67, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v61, vcc_lo, 0, v69, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v60, vcc_lo, v60, v68
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v72, vcc_lo, v72, v60
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v71, null, v71, v61, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v62, v70, v72
	v_mad_co_u64_u32 v[60:61], null, v63, v72, 0
	v_mul_lo_u32 v63, v63, v71
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v70, v72, v60
	v_mad_co_u64_u32 v[66:67], null, v71, v60, 0
	v_add3_u32 v63, v61, v63, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[61:62], null, v72, v63, 0
	v_mad_co_u64_u32 v[68:69], null, v71, v63, 0
	v_add_co_u32 v60, vcc_lo, v70, v61
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v62, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v66
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v60, vcc_lo, v61, v67, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v61, vcc_lo, 0, v69, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v68
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v62, vcc_lo, v72, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v66, null, v71, v61, vcc_lo
	v_mul_hi_u32 v68, v58, v62
	v_mad_co_u64_u32 v[62:63], null, v59, v62, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[60:61], null, v58, v66, 0
	v_mad_co_u64_u32 v[66:67], null, v59, v66, 0
	v_add_co_u32 v60, vcc_lo, v68, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v60, vcc_lo, v61, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v61, vcc_lo, 0, v67, vcc_lo
	v_add_co_u32 v62, vcc_lo, v60, v66
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v61, vcc_lo
	v_mul_lo_u32 v66, v3, v62
	v_mad_co_u64_u32 v[60:61], null, v2, v62, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v67, v2, v63
	v_sub_co_u32 v58, vcc_lo, v58, v60
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v61, v61, v67, v66
	v_sub_nc_u32_e32 v66, v59, v61
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v59, null, v59, v61, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v60, null, v66, v3, vcc_lo
	v_add_co_u32 v66, s0, v62, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v67, null, 0, v63, s0
	v_sub_co_u32 v67, s0, v58, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v60, null, 0, v60, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v67, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v58, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v58, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v59, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v60, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v67, v61, vcc_lo
	v_add_co_u32 v61, vcc_lo, v62, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v59, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v58, v68, v58, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v59, v61, v66, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v58
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v62, v59, vcc_lo
                                        ; implicit-def: $vgpr58_vgpr59
.LBB11_263:                             ; %Flow408
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_265
; %bb.264:
	v_cvt_f32_u32_e32 v59, v2
	v_sub_nc_u32_e32 v60, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v59, v59
	v_mul_f32_e32 v59, 0x4f7ffffe, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v59, v59
	v_mul_lo_u32 v60, v60, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v60, v59, v60
	v_add_nc_u32_e32 v59, v59, v60
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v59, v58, v59
	v_mul_lo_u32 v60, v59, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v58, v58, v60
	v_add_nc_u32_e32 v60, 1, v59
	v_sub_nc_u32_e32 v61, v58, v2
	v_cmp_ge_u32_e32 vcc_lo, v58, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v58, v58, v61 :: v_dual_cndmask_b32 v59, v59, v60
	v_cmp_ge_u32_e32 vcc_lo, v58, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v59
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v59, v60, vcc_lo
.LBB11_265:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v59, 0 :: v_dual_add_nc_u32 v58, 1, v60
	scratch_store_b32 off, v58, off offset:168
.LBB11_266:                             ; %Flow409
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:172
	v_mov_b32_e32 v66, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_272
; %bb.267:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_269
; %bb.268:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v70, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v71, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v72, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v73, v62
	v_mul_lo_u32 v66, v70, v72
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v67, v71, v73
	v_mad_co_u64_u32 v[62:63], null, v70, v73, 0
	v_add3_u32 v68, v63, v66, v67
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v74, v73, v62
	v_mad_co_u64_u32 v[62:63], null, v72, v62, 0
	v_mad_co_u64_u32 v[66:67], null, v73, v68, 0
	v_mad_co_u64_u32 v[68:69], null, v72, v68, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v66, vcc_lo, v74, v66
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v67, null, 0, v67, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v66, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v67, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v69, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v68
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v73, vcc_lo, v73, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v72, null, v72, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v66, v71, v73
	v_mad_co_u64_u32 v[62:63], null, v70, v73, 0
	v_mul_lo_u32 v67, v70, v72
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v70, v73, v62
	v_add3_u32 v68, v63, v67, v66
	v_mad_co_u64_u32 v[62:63], null, v72, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[66:67], null, v73, v68, 0
	v_mad_co_u64_u32 v[68:69], null, v72, v68, 0
	v_add_co_u32 v66, vcc_lo, v70, v66
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v67, null, 0, v67, vcc_lo
	v_add_co_u32 v62, vcc_lo, v66, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v67, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v69, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v68
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v66, vcc_lo, v73, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v68, null, v72, v63, vcc_lo
	v_mul_hi_u32 v70, v60, v66
	v_mad_co_u64_u32 v[66:67], null, v61, v66, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v68, 0
	v_mad_co_u64_u32 v[68:69], null, v61, v68, 0
	v_add_co_u32 v62, vcc_lo, v70, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v66
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v67, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v69, vcc_lo
	v_add_co_u32 v66, vcc_lo, v62, v68
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v67, null, 0, v63, vcc_lo
	v_mul_lo_u32 v68, v3, v66
	v_mad_co_u64_u32 v[62:63], null, v2, v66, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v69, v2, v67
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v69, v68
	v_sub_nc_u32_e32 v68, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v68, v3, vcc_lo
	v_add_co_u32 v68, s0, v66, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v69, null, 0, v67, s0
	v_sub_co_u32 v69, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v69, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v70, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v69, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v66, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v67, null, 0, v67, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v70, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v68, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v66, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_269:                             ; %Flow406
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_271
; %bb.270:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_271:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v66, 1, v62
	scratch_store_b32 off, v66, off offset:172
.LBB11_272:                             ; %Flow407
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:176
	v_mov_b32_e32 v67, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_278
; %bb.273:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_275
; %bb.274:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v71, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v72, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v73, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v74, v62
	v_mul_lo_u32 v67, v71, v73
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v68, v72, v74
	v_mad_co_u64_u32 v[62:63], null, v71, v74, 0
	v_add3_u32 v69, v63, v67, v68
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v75, v74, v62
	v_mad_co_u64_u32 v[62:63], null, v73, v62, 0
	v_mad_co_u64_u32 v[67:68], null, v74, v69, 0
	v_mad_co_u64_u32 v[69:70], null, v73, v69, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v67, vcc_lo, v75, v67
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v68, null, 0, v68, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v67, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v68, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v70, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v69
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v74, vcc_lo, v74, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v73, null, v73, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v67, v72, v74
	v_mad_co_u64_u32 v[62:63], null, v71, v74, 0
	v_mul_lo_u32 v68, v71, v73
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v71, v74, v62
	v_add3_u32 v69, v63, v68, v67
	v_mad_co_u64_u32 v[62:63], null, v73, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[67:68], null, v74, v69, 0
	v_mad_co_u64_u32 v[69:70], null, v73, v69, 0
	v_add_co_u32 v67, vcc_lo, v71, v67
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v68, null, 0, v68, vcc_lo
	v_add_co_u32 v62, vcc_lo, v67, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v68, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v70, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v69
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v67, vcc_lo, v74, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v69, null, v73, v63, vcc_lo
	v_mul_hi_u32 v71, v60, v67
	v_mad_co_u64_u32 v[67:68], null, v61, v67, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v69, 0
	v_mad_co_u64_u32 v[69:70], null, v61, v69, 0
	v_add_co_u32 v62, vcc_lo, v71, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v67
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v68, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v70, vcc_lo
	v_add_co_u32 v67, vcc_lo, v62, v69
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v68, null, 0, v63, vcc_lo
	v_mul_lo_u32 v69, v3, v67
	v_mad_co_u64_u32 v[62:63], null, v2, v67, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v70, v2, v68
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v70, v69
	v_sub_nc_u32_e32 v69, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v69, v3, vcc_lo
	v_add_co_u32 v69, s0, v67, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v70, null, 0, v68, s0
	v_sub_co_u32 v70, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v70, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v70, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v70, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v67, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v68, null, 0, v68, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v71, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v69, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v67, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_275:                             ; %Flow404
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_277
; %bb.276:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_277:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v67, 1, v62
	scratch_store_b32 off, v67, off offset:176
.LBB11_278:                             ; %Flow405
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:180
	v_mov_b32_e32 v68, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_284
; %bb.279:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_281
; %bb.280:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v72, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v73, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v74, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v75, v62
	v_mul_lo_u32 v68, v72, v74
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v69, v73, v75
	v_mad_co_u64_u32 v[62:63], null, v72, v75, 0
	v_add3_u32 v70, v63, v68, v69
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v76, v75, v62
	v_mad_co_u64_u32 v[62:63], null, v74, v62, 0
	v_mad_co_u64_u32 v[68:69], null, v75, v70, 0
	v_mad_co_u64_u32 v[70:71], null, v74, v70, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v68, vcc_lo, v76, v68
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v69, null, 0, v69, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v68, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v69, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v71, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v70
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v75, vcc_lo, v75, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v74, null, v74, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v68, v73, v75
	v_mad_co_u64_u32 v[62:63], null, v72, v75, 0
	v_mul_lo_u32 v69, v72, v74
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v72, v75, v62
	v_add3_u32 v70, v63, v69, v68
	v_mad_co_u64_u32 v[62:63], null, v74, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[68:69], null, v75, v70, 0
	v_mad_co_u64_u32 v[70:71], null, v74, v70, 0
	v_add_co_u32 v68, vcc_lo, v72, v68
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v69, null, 0, v69, vcc_lo
	v_add_co_u32 v62, vcc_lo, v68, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v69, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v71, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v70
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v68, vcc_lo, v75, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v70, null, v74, v63, vcc_lo
	v_mul_hi_u32 v72, v60, v68
	v_mad_co_u64_u32 v[68:69], null, v61, v68, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v70, 0
	v_mad_co_u64_u32 v[70:71], null, v61, v70, 0
	v_add_co_u32 v62, vcc_lo, v72, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v68
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v69, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v71, vcc_lo
	v_add_co_u32 v68, vcc_lo, v62, v70
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v69, null, 0, v63, vcc_lo
	v_mul_lo_u32 v70, v3, v68
	v_mad_co_u64_u32 v[62:63], null, v2, v68, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v71, v2, v69
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v71, v70
	v_sub_nc_u32_e32 v70, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v70, v3, vcc_lo
	v_add_co_u32 v70, s0, v68, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v71, null, 0, v69, s0
	v_sub_co_u32 v71, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v71, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v71, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v68, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v69, null, 0, v69, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v72, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v70, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v68, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_281:                             ; %Flow402
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_283
; %bb.282:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_283:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v68, 1, v62
	scratch_store_b32 off, v68, off offset:180
.LBB11_284:                             ; %Flow403
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:184
	v_mov_b32_e32 v69, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_290
; %bb.285:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_287
; %bb.286:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v73, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v74, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v75, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v76, v62
	v_mul_lo_u32 v69, v73, v75
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v70, v74, v76
	v_mad_co_u64_u32 v[62:63], null, v73, v76, 0
	v_add3_u32 v71, v63, v69, v70
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v77, v76, v62
	v_mad_co_u64_u32 v[62:63], null, v75, v62, 0
	v_mad_co_u64_u32 v[69:70], null, v76, v71, 0
	v_mad_co_u64_u32 v[71:72], null, v75, v71, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v69, vcc_lo, v77, v69
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v70, null, 0, v70, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v69, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v70, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v72, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v71
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v76, vcc_lo, v76, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v75, null, v75, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v69, v74, v76
	v_mad_co_u64_u32 v[62:63], null, v73, v76, 0
	v_mul_lo_u32 v70, v73, v75
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v73, v76, v62
	v_add3_u32 v71, v63, v70, v69
	v_mad_co_u64_u32 v[62:63], null, v75, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[69:70], null, v76, v71, 0
	v_mad_co_u64_u32 v[71:72], null, v75, v71, 0
	v_add_co_u32 v69, vcc_lo, v73, v69
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v70, null, 0, v70, vcc_lo
	v_add_co_u32 v62, vcc_lo, v69, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v70, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v72, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v71
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v69, vcc_lo, v76, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v71, null, v75, v63, vcc_lo
	v_mul_hi_u32 v73, v60, v69
	v_mad_co_u64_u32 v[69:70], null, v61, v69, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v71, 0
	v_mad_co_u64_u32 v[71:72], null, v61, v71, 0
	v_add_co_u32 v62, vcc_lo, v73, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v69
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v70, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v72, vcc_lo
	v_add_co_u32 v69, vcc_lo, v62, v71
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v70, null, 0, v63, vcc_lo
	v_mul_lo_u32 v71, v3, v69
	v_mad_co_u64_u32 v[62:63], null, v2, v69, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v72, v2, v70
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v72, v71
	v_sub_nc_u32_e32 v71, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v71, v3, vcc_lo
	v_add_co_u32 v71, s0, v69, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v72, null, 0, v70, s0
	v_sub_co_u32 v72, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v72, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v72, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v69, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v70, null, 0, v70, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v73, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v71, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v69, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_287:                             ; %Flow400
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_289
; %bb.288:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_289:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v69, 1, v62
	scratch_store_b32 off, v69, off offset:184
.LBB11_290:                             ; %Flow401
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:188
	v_mov_b32_e32 v70, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_296
; %bb.291:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_293
; %bb.292:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v74, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v75, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v76, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v77, v62
	v_mul_lo_u32 v70, v74, v76
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v71, v75, v77
	v_mad_co_u64_u32 v[62:63], null, v74, v77, 0
	v_add3_u32 v72, v63, v70, v71
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v78, v77, v62
	v_mad_co_u64_u32 v[62:63], null, v76, v62, 0
	v_mad_co_u64_u32 v[70:71], null, v77, v72, 0
	v_mad_co_u64_u32 v[72:73], null, v76, v72, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v70, vcc_lo, v78, v70
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v71, null, 0, v71, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v70, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v71, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v73, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v72
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v77, vcc_lo, v77, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v76, null, v76, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v70, v75, v77
	v_mad_co_u64_u32 v[62:63], null, v74, v77, 0
	v_mul_lo_u32 v71, v74, v76
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v74, v77, v62
	v_add3_u32 v72, v63, v71, v70
	v_mad_co_u64_u32 v[62:63], null, v76, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[70:71], null, v77, v72, 0
	v_mad_co_u64_u32 v[72:73], null, v76, v72, 0
	v_add_co_u32 v70, vcc_lo, v74, v70
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v71, null, 0, v71, vcc_lo
	v_add_co_u32 v62, vcc_lo, v70, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v71, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v73, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v72
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v70, vcc_lo, v77, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v72, null, v76, v63, vcc_lo
	v_mul_hi_u32 v74, v60, v70
	v_mad_co_u64_u32 v[70:71], null, v61, v70, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v72, 0
	v_mad_co_u64_u32 v[72:73], null, v61, v72, 0
	v_add_co_u32 v62, vcc_lo, v74, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v70
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v71, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v73, vcc_lo
	v_add_co_u32 v70, vcc_lo, v62, v72
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v71, null, 0, v63, vcc_lo
	v_mul_lo_u32 v72, v3, v70
	v_mad_co_u64_u32 v[62:63], null, v2, v70, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v73, v2, v71
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v73, v72
	v_sub_nc_u32_e32 v72, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v72, v3, vcc_lo
	v_add_co_u32 v72, s0, v70, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v73, null, 0, v71, s0
	v_sub_co_u32 v73, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v73, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v73, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v70, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v71, null, 0, v71, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v74, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v72, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v70, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_293:                             ; %Flow398
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_295
; %bb.294:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_295:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v70, 1, v62
	scratch_store_b32 off, v70, off offset:188
.LBB11_296:                             ; %Flow399
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:192
	v_mov_b32_e32 v71, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_302
; %bb.297:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_299
; %bb.298:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v75, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v76, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v77, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v78, v62
	v_mul_lo_u32 v71, v75, v77
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v72, v76, v78
	v_mad_co_u64_u32 v[62:63], null, v75, v78, 0
	v_add3_u32 v73, v63, v71, v72
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v79, v78, v62
	v_mad_co_u64_u32 v[62:63], null, v77, v62, 0
	v_mad_co_u64_u32 v[71:72], null, v78, v73, 0
	v_mad_co_u64_u32 v[73:74], null, v77, v73, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v71, vcc_lo, v79, v71
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v72, null, 0, v72, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v71, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v72, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v74, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v73
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v78, vcc_lo, v78, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v77, null, v77, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v71, v76, v78
	v_mad_co_u64_u32 v[62:63], null, v75, v78, 0
	v_mul_lo_u32 v72, v75, v77
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v75, v78, v62
	v_add3_u32 v73, v63, v72, v71
	v_mad_co_u64_u32 v[62:63], null, v77, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[71:72], null, v78, v73, 0
	v_mad_co_u64_u32 v[73:74], null, v77, v73, 0
	v_add_co_u32 v71, vcc_lo, v75, v71
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v72, null, 0, v72, vcc_lo
	v_add_co_u32 v62, vcc_lo, v71, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v72, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v74, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v73
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v71, vcc_lo, v78, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v73, null, v77, v63, vcc_lo
	v_mul_hi_u32 v75, v60, v71
	v_mad_co_u64_u32 v[71:72], null, v61, v71, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v73, 0
	v_mad_co_u64_u32 v[73:74], null, v61, v73, 0
	v_add_co_u32 v62, vcc_lo, v75, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v71
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v72, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v74, vcc_lo
	v_add_co_u32 v71, vcc_lo, v62, v73
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v72, null, 0, v63, vcc_lo
	v_mul_lo_u32 v73, v3, v71
	v_mad_co_u64_u32 v[62:63], null, v2, v71, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v74, v2, v72
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v74, v73
	v_sub_nc_u32_e32 v73, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v73, v3, vcc_lo
	v_add_co_u32 v73, s0, v71, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v74, null, 0, v72, s0
	v_sub_co_u32 v74, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v74, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v75, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v74, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v71, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v72, null, 0, v72, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v75, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v73, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v71, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_299:                             ; %Flow396
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_301
; %bb.300:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_301:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v71, 1, v62
	scratch_store_b32 off, v71, off offset:192
.LBB11_302:                             ; %Flow397
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:196
	v_mov_b32_e32 v72, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_308
; %bb.303:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_305
; %bb.304:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v76, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v77, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v78, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v79, v62
	v_mul_lo_u32 v72, v76, v78
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v73, v77, v79
	v_mad_co_u64_u32 v[62:63], null, v76, v79, 0
	v_add3_u32 v74, v63, v72, v73
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v80, v79, v62
	v_mad_co_u64_u32 v[62:63], null, v78, v62, 0
	v_mad_co_u64_u32 v[72:73], null, v79, v74, 0
	v_mad_co_u64_u32 v[74:75], null, v78, v74, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v72, vcc_lo, v80, v72
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v73, null, 0, v73, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v72, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v73, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v75, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v74
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v79, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v78, null, v78, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v72, v77, v79
	v_mad_co_u64_u32 v[62:63], null, v76, v79, 0
	v_mul_lo_u32 v73, v76, v78
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v76, v79, v62
	v_add3_u32 v74, v63, v73, v72
	v_mad_co_u64_u32 v[62:63], null, v78, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[72:73], null, v79, v74, 0
	v_mad_co_u64_u32 v[74:75], null, v78, v74, 0
	v_add_co_u32 v72, vcc_lo, v76, v72
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v73, null, 0, v73, vcc_lo
	v_add_co_u32 v62, vcc_lo, v72, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v73, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v75, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v74
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v72, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v74, null, v78, v63, vcc_lo
	v_mul_hi_u32 v76, v60, v72
	v_mad_co_u64_u32 v[72:73], null, v61, v72, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v74, 0
	v_mad_co_u64_u32 v[74:75], null, v61, v74, 0
	v_add_co_u32 v62, vcc_lo, v76, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v72
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v73, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v75, vcc_lo
	v_add_co_u32 v72, vcc_lo, v62, v74
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v73, null, 0, v63, vcc_lo
	v_mul_lo_u32 v74, v3, v72
	v_mad_co_u64_u32 v[62:63], null, v2, v72, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v75, v2, v73
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v75, v74
	v_sub_nc_u32_e32 v74, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v74, v3, vcc_lo
	v_add_co_u32 v74, s0, v72, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v75, null, 0, v73, s0
	v_sub_co_u32 v75, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v75, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v75, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v76, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v75, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v72, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v73, null, 0, v73, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v76, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v74, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v72, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_305:                             ; %Flow394
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_307
; %bb.306:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_307:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v72, 1, v62
	scratch_store_b32 off, v72, off offset:196
.LBB11_308:                             ; %Flow395
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:200
	v_mov_b32_e32 v73, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_314
; %bb.309:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_311
; %bb.310:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v77, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v78, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v79, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v80, v62
	v_mul_lo_u32 v73, v77, v79
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v74, v78, v80
	v_mad_co_u64_u32 v[62:63], null, v77, v80, 0
	v_add3_u32 v75, v63, v73, v74
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v81, v80, v62
	v_mad_co_u64_u32 v[62:63], null, v79, v62, 0
	v_mad_co_u64_u32 v[73:74], null, v80, v75, 0
	v_mad_co_u64_u32 v[75:76], null, v79, v75, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v73, vcc_lo, v81, v73
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v74, null, 0, v74, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v73, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v74, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v76, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v75
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v80, vcc_lo, v80, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v79, null, v79, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v73, v78, v80
	v_mad_co_u64_u32 v[62:63], null, v77, v80, 0
	v_mul_lo_u32 v74, v77, v79
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v77, v80, v62
	v_add3_u32 v75, v63, v74, v73
	v_mad_co_u64_u32 v[62:63], null, v79, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[73:74], null, v80, v75, 0
	v_mad_co_u64_u32 v[75:76], null, v79, v75, 0
	v_add_co_u32 v73, vcc_lo, v77, v73
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v74, null, 0, v74, vcc_lo
	v_add_co_u32 v62, vcc_lo, v73, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v74, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v76, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v75
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v73, vcc_lo, v80, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v75, null, v79, v63, vcc_lo
	v_mul_hi_u32 v77, v60, v73
	v_mad_co_u64_u32 v[73:74], null, v61, v73, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v75, 0
	v_mad_co_u64_u32 v[75:76], null, v61, v75, 0
	v_add_co_u32 v62, vcc_lo, v77, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v73
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v74, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v76, vcc_lo
	v_add_co_u32 v73, vcc_lo, v62, v75
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v74, null, 0, v63, vcc_lo
	v_mul_lo_u32 v75, v3, v73
	v_mad_co_u64_u32 v[62:63], null, v2, v73, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v76, v2, v74
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v76, v75
	v_sub_nc_u32_e32 v75, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v75, v3, vcc_lo
	v_add_co_u32 v75, s0, v73, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v76, null, 0, v74, s0
	v_sub_co_u32 v76, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v76, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v76, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v77, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v76, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v73, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v74, null, 0, v74, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v77, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v75, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v73, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_311:                             ; %Flow392
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_313
; %bb.312:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_313:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v73, 1, v62
	scratch_store_b32 off, v73, off offset:200
.LBB11_314:                             ; %Flow393
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:204
	v_mov_b32_e32 v74, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_320
; %bb.315:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_317
; %bb.316:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v78, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v79, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v80, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v81, v62
	v_mul_lo_u32 v74, v78, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v75, v79, v81
	v_mad_co_u64_u32 v[62:63], null, v78, v81, 0
	v_add3_u32 v76, v63, v74, v75
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v82, v81, v62
	v_mad_co_u64_u32 v[62:63], null, v80, v62, 0
	v_mad_co_u64_u32 v[74:75], null, v81, v76, 0
	v_mad_co_u64_u32 v[76:77], null, v80, v76, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v74, vcc_lo, v82, v74
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v75, null, 0, v75, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v74, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v75, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v77, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v76
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v81, vcc_lo, v81, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, v80, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v74, v79, v81
	v_mad_co_u64_u32 v[62:63], null, v78, v81, 0
	v_mul_lo_u32 v75, v78, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v78, v81, v62
	v_add3_u32 v76, v63, v75, v74
	v_mad_co_u64_u32 v[62:63], null, v80, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[74:75], null, v81, v76, 0
	v_mad_co_u64_u32 v[76:77], null, v80, v76, 0
	v_add_co_u32 v74, vcc_lo, v78, v74
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v75, null, 0, v75, vcc_lo
	v_add_co_u32 v62, vcc_lo, v74, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v75, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v77, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v76
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v74, vcc_lo, v81, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v76, null, v80, v63, vcc_lo
	v_mul_hi_u32 v78, v60, v74
	v_mad_co_u64_u32 v[74:75], null, v61, v74, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v76, 0
	v_mad_co_u64_u32 v[76:77], null, v61, v76, 0
	v_add_co_u32 v62, vcc_lo, v78, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v74
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v75, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v77, vcc_lo
	v_add_co_u32 v74, vcc_lo, v62, v76
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v75, null, 0, v63, vcc_lo
	v_mul_lo_u32 v76, v3, v74
	v_mad_co_u64_u32 v[62:63], null, v2, v74, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v77, v2, v75
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v77, v76
	v_sub_nc_u32_e32 v76, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v76, v3, vcc_lo
	v_add_co_u32 v76, s0, v74, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v77, null, 0, v75, s0
	v_sub_co_u32 v77, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v77, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v77, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v78, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v77, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v74, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v75, null, 0, v75, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v78, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v76, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v74, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_317:                             ; %Flow390
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_319
; %bb.318:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_319:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v74, 1, v62
	scratch_store_b32 off, v74, off offset:204
.LBB11_320:                             ; %Flow391
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:208
	v_mov_b32_e32 v75, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_326
; %bb.321:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_323
; %bb.322:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v79, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v80, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v81, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v82, v62
	v_mul_lo_u32 v75, v79, v81
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v76, v80, v82
	v_mad_co_u64_u32 v[62:63], null, v79, v82, 0
	v_add3_u32 v77, v63, v75, v76
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v83, v82, v62
	v_mad_co_u64_u32 v[62:63], null, v81, v62, 0
	v_mad_co_u64_u32 v[75:76], null, v82, v77, 0
	v_mad_co_u64_u32 v[77:78], null, v81, v77, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v75, vcc_lo, v83, v75
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v76, null, 0, v76, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v75, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v76, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v78, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v77
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v82, vcc_lo, v82, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v81, null, v81, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v75, v80, v82
	v_mad_co_u64_u32 v[62:63], null, v79, v82, 0
	v_mul_lo_u32 v76, v79, v81
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v79, v82, v62
	v_add3_u32 v77, v63, v76, v75
	v_mad_co_u64_u32 v[62:63], null, v81, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[75:76], null, v82, v77, 0
	v_mad_co_u64_u32 v[77:78], null, v81, v77, 0
	v_add_co_u32 v75, vcc_lo, v79, v75
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v76, null, 0, v76, vcc_lo
	v_add_co_u32 v62, vcc_lo, v75, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v76, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v78, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v77
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v75, vcc_lo, v82, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v77, null, v81, v63, vcc_lo
	v_mul_hi_u32 v79, v60, v75
	v_mad_co_u64_u32 v[75:76], null, v61, v75, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v77, 0
	v_mad_co_u64_u32 v[77:78], null, v61, v77, 0
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v75
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v76, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v78, vcc_lo
	v_add_co_u32 v75, vcc_lo, v62, v77
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v76, null, 0, v63, vcc_lo
	v_mul_lo_u32 v77, v3, v75
	v_mad_co_u64_u32 v[62:63], null, v2, v75, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v78, v2, v76
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v78, v77
	v_sub_nc_u32_e32 v77, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v77, v3, vcc_lo
	v_add_co_u32 v77, s0, v75, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v78, null, 0, v76, s0
	v_sub_co_u32 v78, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v78, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v78, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v78, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v75, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v76, null, 0, v76, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v79, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v77, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v75, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_323:                             ; %Flow388
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_325
; %bb.324:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_325:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v75, 1, v62
	scratch_store_b32 off, v75, off offset:208
.LBB11_326:                             ; %Flow389
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:212
	v_mov_b32_e32 v76, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_332
; %bb.327:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_329
; %bb.328:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v80, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v81, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v82, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v83, v62
	v_mul_lo_u32 v76, v80, v82
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v77, v81, v83
	v_mad_co_u64_u32 v[62:63], null, v80, v83, 0
	v_add3_u32 v78, v63, v76, v77
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v84, v83, v62
	v_mad_co_u64_u32 v[62:63], null, v82, v62, 0
	v_mad_co_u64_u32 v[76:77], null, v83, v78, 0
	v_mad_co_u64_u32 v[78:79], null, v82, v78, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v76, vcc_lo, v84, v76
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v77, null, 0, v77, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v76, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v77, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v79, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v78
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v83, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v82, null, v82, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v76, v81, v83
	v_mad_co_u64_u32 v[62:63], null, v80, v83, 0
	v_mul_lo_u32 v77, v80, v82
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v80, v83, v62
	v_add3_u32 v78, v63, v77, v76
	v_mad_co_u64_u32 v[62:63], null, v82, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[76:77], null, v83, v78, 0
	v_mad_co_u64_u32 v[78:79], null, v82, v78, 0
	v_add_co_u32 v76, vcc_lo, v80, v76
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v77, null, 0, v77, vcc_lo
	v_add_co_u32 v62, vcc_lo, v76, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v77, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v79, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v78
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v76, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v78, null, v82, v63, vcc_lo
	v_mul_hi_u32 v80, v60, v76
	v_mad_co_u64_u32 v[76:77], null, v61, v76, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v78, 0
	v_mad_co_u64_u32 v[78:79], null, v61, v78, 0
	v_add_co_u32 v62, vcc_lo, v80, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v76
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v77, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v79, vcc_lo
	v_add_co_u32 v76, vcc_lo, v62, v78
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v77, null, 0, v63, vcc_lo
	v_mul_lo_u32 v78, v3, v76
	v_mad_co_u64_u32 v[62:63], null, v2, v76, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v79, v2, v77
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v79, v78
	v_sub_nc_u32_e32 v78, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v78, v3, vcc_lo
	v_add_co_u32 v78, s0, v76, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v79, null, 0, v77, s0
	v_sub_co_u32 v79, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v79, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v80, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v76, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v77, null, 0, v77, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v80, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v78, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v76, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_329:                             ; %Flow386
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_331
; %bb.330:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_331:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v76, 1, v62
	scratch_store_b32 off, v76, off offset:212
.LBB11_332:                             ; %Flow387
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:216
	v_mov_b32_e32 v77, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_338
; %bb.333:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_335
; %bb.334:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v81, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v82, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v83, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v84, v62
	v_mul_lo_u32 v77, v81, v83
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v78, v82, v84
	v_mad_co_u64_u32 v[62:63], null, v81, v84, 0
	v_add3_u32 v79, v63, v77, v78
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v85, v84, v62
	v_mad_co_u64_u32 v[62:63], null, v83, v62, 0
	v_mad_co_u64_u32 v[77:78], null, v84, v79, 0
	v_mad_co_u64_u32 v[79:80], null, v83, v79, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v77, vcc_lo, v85, v77
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v78, null, 0, v78, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v77, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v78, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v84, vcc_lo, v84, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v83, null, v83, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v77, v82, v84
	v_mad_co_u64_u32 v[62:63], null, v81, v84, 0
	v_mul_lo_u32 v78, v81, v83
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v81, v84, v62
	v_add3_u32 v79, v63, v78, v77
	v_mad_co_u64_u32 v[62:63], null, v83, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[77:78], null, v84, v79, 0
	v_mad_co_u64_u32 v[79:80], null, v83, v79, 0
	v_add_co_u32 v77, vcc_lo, v81, v77
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v78, null, 0, v78, vcc_lo
	v_add_co_u32 v62, vcc_lo, v77, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v78, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v77, vcc_lo, v84, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v79, null, v83, v63, vcc_lo
	v_mul_hi_u32 v81, v60, v77
	v_mad_co_u64_u32 v[77:78], null, v61, v77, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v79, 0
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	v_add_co_u32 v62, vcc_lo, v81, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v77
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v78, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v80, vcc_lo
	v_add_co_u32 v77, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v78, null, 0, v63, vcc_lo
	v_mul_lo_u32 v79, v3, v77
	v_mad_co_u64_u32 v[62:63], null, v2, v77, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v80, v2, v78
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v80, v79
	v_sub_nc_u32_e32 v79, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v79, v3, vcc_lo
	v_add_co_u32 v79, s0, v77, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v80, null, 0, v78, s0
	v_sub_co_u32 v80, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v80, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v80, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v81, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v80, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v77, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v78, null, 0, v78, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v81, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v79, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v77, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_335:                             ; %Flow384
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_337
; %bb.336:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_337:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v77, 1, v62
	scratch_store_b32 off, v77, off offset:216
.LBB11_338:                             ; %Flow385
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:220
	v_mov_b32_e32 v78, 0
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_344
; %bb.339:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_341
; %bb.340:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v82, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v83, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v84, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v85, v62
	v_mul_lo_u32 v78, v82, v84
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v79, v83, v85
	v_mad_co_u64_u32 v[62:63], null, v82, v85, 0
	v_add3_u32 v80, v63, v78, v79
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v86, v85, v62
	v_mad_co_u64_u32 v[62:63], null, v84, v62, 0
	v_mad_co_u64_u32 v[78:79], null, v85, v80, 0
	v_mad_co_u64_u32 v[80:81], null, v84, v80, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v78, vcc_lo, v86, v78
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v79, null, 0, v79, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v78, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v79, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v80
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v85, vcc_lo, v85, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v84, null, v84, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v78, v83, v85
	v_mad_co_u64_u32 v[62:63], null, v82, v85, 0
	v_mul_lo_u32 v79, v82, v84
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v82, v85, v62
	v_add3_u32 v80, v63, v79, v78
	v_mad_co_u64_u32 v[62:63], null, v84, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[78:79], null, v85, v80, 0
	v_mad_co_u64_u32 v[80:81], null, v84, v80, 0
	v_add_co_u32 v78, vcc_lo, v82, v78
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v79, null, 0, v79, vcc_lo
	v_add_co_u32 v62, vcc_lo, v78, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v79, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v81, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v80
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v78, vcc_lo, v85, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, v84, v63, vcc_lo
	v_mul_hi_u32 v82, v60, v78
	v_mad_co_u64_u32 v[78:79], null, v61, v78, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v80, 0
	v_mad_co_u64_u32 v[80:81], null, v61, v80, 0
	v_add_co_u32 v62, vcc_lo, v82, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v78
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v79, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v81, vcc_lo
	v_add_co_u32 v78, vcc_lo, v62, v80
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v79, null, 0, v63, vcc_lo
	v_mul_lo_u32 v80, v3, v78
	v_mad_co_u64_u32 v[62:63], null, v2, v78, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v81, v2, v79
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v81, v80
	v_sub_nc_u32_e32 v80, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v80, v3, vcc_lo
	v_add_co_u32 v80, s0, v78, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v81, null, 0, v79, s0
	v_sub_co_u32 v81, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v81, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v81, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v81, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v78, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v79, null, 0, v79, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v82, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v78, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_341:                             ; %Flow382
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_343
; %bb.342:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_343:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v78, 1, v62
	scratch_store_b32 off, v78, off offset:220
.LBB11_344:                             ; %Flow383
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:224
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_350
; %bb.345:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_347
; %bb.346:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_347:                             ; %Flow380
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_349
; %bb.348:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_349:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:224
.LBB11_350:                             ; %Flow381
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:228
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_356
; %bb.351:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_353
; %bb.352:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_353:                             ; %Flow378
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_355
; %bb.354:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_355:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:228
.LBB11_356:                             ; %Flow379
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:232
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_362
; %bb.357:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_359
; %bb.358:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_359:                             ; %Flow376
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_361
; %bb.360:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_361:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:232
.LBB11_362:                             ; %Flow377
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:236
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_368
; %bb.363:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_365
; %bb.364:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_365:                             ; %Flow374
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_367
; %bb.366:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_367:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:236
.LBB11_368:                             ; %Flow375
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:240
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_374
; %bb.369:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_371
; %bb.370:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_371:                             ; %Flow372
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_373
; %bb.372:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_373:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:240
.LBB11_374:                             ; %Flow373
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:244
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_380
; %bb.375:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_377
; %bb.376:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_377:                             ; %Flow370
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_379
; %bb.378:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_379:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:244
.LBB11_380:                             ; %Flow371
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v60, v[4:5], off offset:248
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v60
	s_cbranch_execz .LBB11_386
; %bb.381:
	v_ashrrev_i32_e32 v62, 31, v60
	v_mul_lo_u32 v63, v65, v60
	v_mad_co_u64_u32 v[60:61], null, v64, v60, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v62, v64, v62
	v_add3_u32 v61, v61, v62, v63
	v_mov_b32_e32 v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v63, v61, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[62:63]
                                        ; implicit-def: $vgpr62_vgpr63
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_383
; %bb.382:
	v_cvt_f32_u32_e32 v62, v2
	v_cvt_f32_u32_e32 v63, v3
	v_sub_co_u32 v83, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v84, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v62, v63, 0x4f800000, v62
	v_rcp_f32_e32 v62, v62
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v62, 0x5f7ffffc, v62
	v_mul_f32_e32 v63, 0x2f800000, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v63, v63
	v_fmamk_f32 v62, v63, 0xcf800000, v62
	v_cvt_u32_f32_e32 v85, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v86, v62
	v_mul_lo_u32 v79, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v80, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_add3_u32 v81, v63, v79, v80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v87, v86, v62
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v79, vcc_lo, v87, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v86, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v85, null, v85, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v79, v84, v86
	v_mad_co_u64_u32 v[62:63], null, v83, v86, 0
	v_mul_lo_u32 v80, v83, v85
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v83, v86, v62
	v_add3_u32 v81, v63, v80, v79
	v_mad_co_u64_u32 v[62:63], null, v85, v62, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[79:80], null, v86, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v85, v81, 0
	v_add_co_u32 v79, vcc_lo, v83, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_add_co_u32 v62, vcc_lo, v79, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v80, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v79, vcc_lo, v86, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v81, null, v85, v63, vcc_lo
	v_mul_hi_u32 v83, v60, v79
	v_mad_co_u64_u32 v[79:80], null, v61, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[62:63], null, v60, v81, 0
	v_mad_co_u64_u32 v[81:82], null, v61, v81, 0
	v_add_co_u32 v62, vcc_lo, v83, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_add_co_u32 v62, vcc_lo, v62, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v62, vcc_lo, v63, v80, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v63, vcc_lo, 0, v82, vcc_lo
	v_add_co_u32 v79, vcc_lo, v62, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v80, null, 0, v63, vcc_lo
	v_mul_lo_u32 v81, v3, v79
	v_mad_co_u64_u32 v[62:63], null, v2, v79, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v82, v2, v80
	v_sub_co_u32 v60, vcc_lo, v60, v62
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v63, v63, v82, v81
	v_sub_nc_u32_e32 v81, v61, v63
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v61, null, v61, v63, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v62, null, v81, v3, vcc_lo
	v_add_co_u32 v81, s0, v79, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v82, null, 0, v80, s0
	v_sub_co_u32 v82, s0, v60, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v62, null, 0, v62, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v82, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v62, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v82, v63, vcc_lo
	v_add_co_u32 v63, vcc_lo, v79, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v80, null, 0, v80, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v61, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v83, v60, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v62
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v61, v63, v81, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v79, v61, vcc_lo
                                        ; implicit-def: $vgpr60_vgpr61
.LBB11_383:                             ; %Flow368
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_385
; %bb.384:
	v_cvt_f32_u32_e32 v61, v2
	v_sub_nc_u32_e32 v62, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v61, v61
	v_mul_f32_e32 v61, 0x4f7ffffe, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v61, v61
	v_mul_lo_u32 v62, v62, v61
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v62, v61, v62
	v_add_nc_u32_e32 v61, v61, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v61, v60, v61
	v_mul_lo_u32 v62, v61, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v60, v60, v62
	v_add_nc_u32_e32 v62, 1, v61
	v_sub_nc_u32_e32 v63, v60, v2
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v60, v60, v63 :: v_dual_cndmask_b32 v61, v61, v62
	v_cmp_ge_u32_e32 vcc_lo, v60, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v62, 1, v61
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v62, v61, v62, vcc_lo
.LBB11_385:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v60, 1, v62
	scratch_store_b32 off, v60, off offset:248
.LBB11_386:                             ; %Flow369
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b32 v4, v[4:5], off offset:252
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v4
	s_cbranch_execz .LBB11_392
; %bb.387:
	v_ashrrev_i32_e32 v60, 31, v4
	v_mul_lo_u32 v61, v65, v4
	v_mad_co_u64_u32 v[4:5], null, v64, v4, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v60, v64, v60
	v_add3_u32 v5, v5, v60, v61
	v_mov_b32_e32 v60, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v61, v5, v3
	v_cmp_ne_u64_e32 vcc_lo, 0, v[60:61]
                                        ; implicit-def: $vgpr60_vgpr61
	s_and_saveexec_b32 s0, vcc_lo
	s_wait_alu 0xfffe
	s_xor_b32 s3, exec_lo, s0
	s_cbranch_execz .LBB11_389
; %bb.388:
	v_cvt_f32_u32_e32 v60, v2
	v_cvt_f32_u32_e32 v61, v3
	v_sub_co_u32 v65, vcc_lo, 0, v2
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v81, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmamk_f32 v60, v61, 0x4f800000, v60
	v_rcp_f32_e32 v60, v60
	s_delay_alu instid0(TRANS32_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v60, 0x5f7ffffc, v60
	v_mul_f32_e32 v61, 0x2f800000, v60
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_trunc_f32_e32 v61, v61
	v_fmamk_f32 v60, v61, 0xcf800000, v60
	v_cvt_u32_f32_e32 v82, v61
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_u32_f32_e32 v83, v60
	v_mul_lo_u32 v62, v65, v82
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v63, v81, v83
	v_mad_co_u64_u32 v[60:61], null, v65, v83, 0
	v_add3_u32 v79, v61, v62, v63
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_hi_u32 v84, v83, v60
	v_mad_co_u64_u32 v[63:64], null, v82, v60, 0
	v_mad_co_u64_u32 v[61:62], null, v83, v79, 0
	v_mad_co_u64_u32 v[79:80], null, v82, v79, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v60, vcc_lo, v84, v61
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v61, null, 0, v62, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v60, vcc_lo, v60, v63
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v60, vcc_lo, v61, v64, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v61, vcc_lo, 0, v80, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v60, vcc_lo, v60, v79
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v83, vcc_lo, v83, v60
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v82, null, v82, v61, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v62, v81, v83
	v_mad_co_u64_u32 v[60:61], null, v65, v83, 0
	v_mul_lo_u32 v63, v65, v82
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_hi_u32 v81, v83, v60
	v_add3_u32 v65, v61, v63, v62
	v_mad_co_u64_u32 v[63:64], null, v82, v60, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[61:62], null, v83, v65, 0
	v_mad_co_u64_u32 v[79:80], null, v82, v65, 0
	v_add_co_u32 v60, vcc_lo, v81, v61
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v62, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v63
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v60, vcc_lo, v61, v64, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v61, vcc_lo, 0, v80, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v62, vcc_lo, v83, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v64, null, v82, v61, vcc_lo
	v_mul_hi_u32 v79, v4, v62
	v_mad_co_u64_u32 v[62:63], null, v5, v62, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_co_u64_u32 v[60:61], null, v4, v64, 0
	v_mad_co_u64_u32 v[64:65], null, v5, v64, 0
	v_add_co_u32 v60, vcc_lo, v79, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e32 v60, vcc_lo, v61, v63, vcc_lo
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e32 v61, vcc_lo, 0, v65, vcc_lo
	v_add_co_u32 v62, vcc_lo, v60, v64
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v63, null, 0, v61, vcc_lo
	v_mul_lo_u32 v64, v3, v62
	v_mad_co_u64_u32 v[60:61], null, v2, v62, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_lo_u32 v65, v2, v63
	v_sub_co_u32 v4, vcc_lo, v4, v60
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v61, v61, v65, v64
	v_sub_nc_u32_e32 v64, v5, v61
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v5, null, v5, v61, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_sub_co_ci_u32_e64 v60, null, v64, v3, vcc_lo
	v_add_co_u32 v64, s0, v62, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v65, null, 0, v63, s0
	v_sub_co_u32 v65, s0, v4, v2
	s_wait_alu 0xf1ff
	v_subrev_co_ci_u32_e64 v60, null, 0, v60, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_cmp_ge_u32_e32 vcc_lo, v65, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v60, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v4, v2
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v4, 0, -1, vcc_lo
	v_cmp_ge_u32_e32 vcc_lo, v5, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v60, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v65, v61, vcc_lo
	v_add_co_u32 v61, vcc_lo, v62, 1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v63, null, 0, v63, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, v5, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v3, v79, v4, vcc_lo
	v_cmp_ne_u32_e32 vcc_lo, 0, v60
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v4, v61, v64, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_ne_u32_e32 vcc_lo, 0, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v62, v4, vcc_lo
                                        ; implicit-def: $vgpr4_vgpr5
.LBB11_389:                             ; %Flow366
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s3
	s_cbranch_execz .LBB11_391
; %bb.390:
	v_cvt_f32_u32_e32 v3, v2
	v_sub_nc_u32_e32 v5, 0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v3, v3
	v_mul_f32_e32 v3, 0x4f7ffffe, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v3, v3
	v_mul_lo_u32 v5, v5, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v5, v3, v5
	v_add_nc_u32_e32 v3, v3, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v3, v4, v3
	v_mul_lo_u32 v5, v3, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_u32_e32 v4, v4, v5
	v_add_nc_u32_e32 v5, 1, v3
	v_sub_nc_u32_e32 v60, v4, v2
	v_cmp_ge_u32_e32 vcc_lo, v4, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_cndmask_b32 v4, v4, v60 :: v_dual_cndmask_b32 v3, v3, v5
	v_cmp_ge_u32_e32 vcc_lo, v4, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v5, 1, v3
	s_wait_alu 0xfffd
	v_cndmask_b32_e32 v60, v3, v5, vcc_lo
.LBB11_391:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v2, 1, v60
	scratch_store_b32 off, v2, off offset:252
.LBB11_392:                             ; %Flow367
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	s_clause 0x4
	scratch_load_b128 v[2:5], off, off
	scratch_load_b128 v[60:63], off, off offset:16
	scratch_load_b128 v[79:82], off, off offset:32
	scratch_load_b128 v[83:86], off, off offset:48
	scratch_load_b128 v[87:90], off, off offset:224
	s_wait_loadcnt 0x4
	v_add_co_u32 v2, s0, v2, v3
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, 0, 0, s0
	s_mov_b32 s0, exec_lo
	v_add_co_u32 v2, vcc_lo, v2, v4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v64, null, 0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_u32 v65, vcc_lo, v2, v5
	scratch_load_b128 v[2:5], off, off offset:240
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v64, null, 0, v64, vcc_lo
	s_wait_loadcnt 0x4
	v_add_co_u32 v60, vcc_lo, v65, v60
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v64, null, 0, v64, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v61
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v64, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v62
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v63
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	s_wait_loadcnt 0x3
	v_add_co_u32 v60, vcc_lo, v60, v79
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v80
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v81
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v82
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	s_wait_loadcnt 0x2
	v_add_co_u32 v60, vcc_lo, v60, v83
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v84
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v85
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v60, vcc_lo, v60, v86
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v61, null, 0, v61, vcc_lo
	v_add_co_u32 v6, vcc_lo, v60, v6
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v61, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v8
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v9, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v10
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v11, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v12
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v13, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v14
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v15, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v16
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v17, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v18
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v19, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v20
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v21, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v22
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v23, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v24
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v25, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v26
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v27, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v28
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v29, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v30
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v31, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v32
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v33, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v34
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v35, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v36
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v37, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v38
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v39, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v40
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v41, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v42
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v43, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v44
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v45, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v46
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v47, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v48
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v49, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v50
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v51, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v52
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v53, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v54
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v55, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v56
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v57, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v58
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v59, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v66
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v67
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v68
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v69
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v70
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v71
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v72
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v73
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v74
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v75
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v76
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v77
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v78
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	s_wait_loadcnt 0x1
	v_add_co_u32 v6, vcc_lo, v6, v87
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v88
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v89
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	v_add_co_u32 v6, vcc_lo, v6, v90
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, 0, v7, vcc_lo
	s_wait_loadcnt 0x0
	v_add_co_u32 v2, vcc_lo, v6, v2
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v6, null, 0, v7, vcc_lo
	v_add_co_u32 v2, vcc_lo, v2, v3
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v3, null, 0, v6, vcc_lo
	v_add_co_u32 v2, vcc_lo, v2, v4
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	v_mov_b32_e32 v4, 0
	v_add_co_u32 v2, vcc_lo, v2, v5
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	v_cmpx_lt_u64_e32 0x1000, v[2:3]
	s_cbranch_execz .LBB11_398
; %bb.393:                              ; %.lr.ph.preheader
	s_mov_b32 s2, 0
	s_mov_b32 s3, 0
	s_branch .LBB11_395
.LBB11_394:                             ;   in Loop: Header=BB11_395 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s5
	s_add_co_i32 s3, s3, 1
	v_cmp_gt_u64_e32 vcc_lo, 0x1001, v[2:3]
	s_wait_alu 0xfffe
	s_ashr_i32 s4, s3, 31
	s_wait_alu 0xfffe
	s_lshr_b32 s4, s4, 26
	s_wait_alu 0xfffe
	s_add_co_i32 s4, s3, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 s4, s4, 63
	s_wait_alu 0xfffe
	s_sub_co_i32 s3, s3, s4
	s_or_b32 s2, vcc_lo, s2
	s_wait_alu 0xfffe
	v_mov_b32_e32 v4, s3
	s_and_not1_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB11_397
.LBB11_395:                             ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	s_lshl_b32 s4, s3, 2
	s_mov_b32 s5, exec_lo
	scratch_load_b32 v4, off, s4
	s_wait_loadcnt 0x0
	v_cmpx_lt_u32_e32 1, v4
	s_cbranch_execz .LBB11_394
; %bb.396:                              ;   in Loop: Header=BB11_395 Depth=1
	v_add_co_u32 v2, vcc_lo, v2, -1
	v_add_nc_u32_e32 v4, -1, v4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, -1, v3, vcc_lo
	scratch_store_b32 off, v4, s4
	s_branch .LBB11_394
.LBB11_397:                             ; %Flow364
	s_or_b32 exec_lo, exec_lo, s2
	v_mov_b32_e32 v2, 0x1000
	v_mov_b32_e32 v3, 0
.LBB11_398:                             ; %Flow365
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	s_mov_b32 s0, exec_lo
	v_cmpx_gt_u64_e32 0x1000, v[2:3]
	s_cbranch_execz .LBB11_403
; %bb.399:                              ; %.lr.ph103.preheader
	s_mov_b32 s2, 0
	s_branch .LBB11_401
.LBB11_400:                             ;   in Loop: Header=BB11_401 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v4, 1, v4
	v_cmp_lt_u64_e32 vcc_lo, 0xfff, v[2:3]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v5, 31, v4
	s_or_b32 s2, vcc_lo, s2
	v_lshrrev_b32_e32 v5, 26, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v5, v4, v5
	v_and_b32_e32 v5, 0xffffffc0, v5
	s_delay_alu instid0(VALU_DEP_1)
	v_sub_nc_u32_e32 v4, v4, v5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB11_403
.LBB11_401:                             ; %.lr.ph103
                                        ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v6, 2, v4
	s_mov_b32 s3, exec_lo
	scratch_load_b32 v5, v6, off
	s_wait_loadcnt 0x0
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB11_400
; %bb.402:                              ;   in Loop: Header=BB11_401 Depth=1
	v_add_co_u32 v2, vcc_lo, v2, 1
	v_add_nc_u32_e32 v5, 1, v5
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	scratch_store_b32 v6, v5, off
	s_branch .LBB11_400
.LBB11_403:                             ; %Flow363
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	s_clause 0xf
	scratch_load_b128 v[2:5], off, off offset:16
	scratch_load_b128 v[6:9], off, off
	scratch_load_b128 v[10:13], off, off offset:48
	scratch_load_b128 v[14:17], off, off offset:32
	scratch_load_b128 v[18:21], off, off offset:80
	scratch_load_b128 v[22:25], off, off offset:64
	scratch_load_b128 v[26:29], off, off offset:112
	scratch_load_b128 v[30:33], off, off offset:96
	scratch_load_b128 v[34:37], off, off offset:144
	scratch_load_b128 v[38:41], off, off offset:128
	scratch_load_b128 v[42:45], off, off offset:176
	scratch_load_b128 v[46:49], off, off offset:160
	scratch_load_b128 v[50:53], off, off offset:208
	scratch_load_b128 v[54:57], off, off offset:192
	scratch_load_b128 v[58:61], off, off offset:240
	scratch_load_b128 v[62:65], off, off offset:224
	s_wait_loadcnt 0xf
	v_perm_b32 v5, v5, v4, 0x5040100
	v_perm_b32 v4, v3, v2, 0x5040100
	s_wait_loadcnt 0xe
	v_perm_b32 v3, v9, v8, 0x5040100
	v_perm_b32 v2, v7, v6, 0x5040100
	s_wait_loadcnt 0xd
	v_perm_b32 v9, v13, v12, 0x5040100
	v_perm_b32 v8, v11, v10, 0x5040100
	s_wait_loadcnt 0xc
	v_perm_b32 v7, v17, v16, 0x5040100
	v_perm_b32 v6, v15, v14, 0x5040100
	s_wait_loadcnt 0xb
	v_perm_b32 v13, v21, v20, 0x5040100
	v_perm_b32 v12, v19, v18, 0x5040100
	s_wait_loadcnt 0xa
	v_perm_b32 v11, v25, v24, 0x5040100
	v_perm_b32 v10, v23, v22, 0x5040100
	s_wait_loadcnt 0x9
	v_perm_b32 v17, v29, v28, 0x5040100
	v_perm_b32 v16, v27, v26, 0x5040100
	s_wait_loadcnt 0x8
	v_perm_b32 v15, v33, v32, 0x5040100
	v_perm_b32 v14, v31, v30, 0x5040100
	s_wait_loadcnt 0x7
	v_perm_b32 v21, v37, v36, 0x5040100
	v_perm_b32 v20, v35, v34, 0x5040100
	s_wait_loadcnt 0x6
	v_perm_b32 v19, v41, v40, 0x5040100
	v_perm_b32 v18, v39, v38, 0x5040100
	s_wait_loadcnt 0x5
	v_perm_b32 v25, v45, v44, 0x5040100
	v_perm_b32 v24, v43, v42, 0x5040100
	s_wait_loadcnt 0x4
	v_perm_b32 v23, v49, v48, 0x5040100
	v_perm_b32 v22, v47, v46, 0x5040100
	s_wait_loadcnt 0x3
	v_perm_b32 v29, v53, v52, 0x5040100
	v_perm_b32 v28, v51, v50, 0x5040100
	s_wait_loadcnt 0x2
	v_perm_b32 v27, v57, v56, 0x5040100
	v_perm_b32 v26, v55, v54, 0x5040100
	s_wait_loadcnt 0x1
	v_perm_b32 v33, v61, v60, 0x5040100
	v_perm_b32 v32, v59, v58, 0x5040100
	s_wait_loadcnt 0x0
	v_perm_b32 v31, v65, v64, 0x5040100
	v_perm_b32 v30, v63, v62, 0x5040100
	s_clause 0x7
	global_store_b128 v[0:1], v[2:5], off
	global_store_b128 v[0:1], v[6:9], off offset:16
	global_store_b128 v[0:1], v[10:13], off offset:32
	global_store_b128 v[0:1], v[14:17], off offset:48
	global_store_b128 v[0:1], v[18:21], off offset:64
	global_store_b128 v[0:1], v[22:25], off offset:80
	global_store_b128 v[0:1], v[26:29], off offset:96
	global_store_b128 v[0:1], v[30:33], off offset:112
                                        ; implicit-def: $vgpr0_vgpr1
.LBB11_404:                             ; %Flow494
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s0, s1
	s_cbranch_execz .LBB11_406
; %bb.405:                              ; %.preheader.preheader
	s_mov_b32 s0, 0
	v_mov_b32_e32 v2, 0x1000
	s_wait_alu 0xfffe
	s_mov_b32 s3, s0
	s_mov_b32 s1, s0
	s_mov_b32 s2, s0
	s_wait_alu 0xfffe
	v_dual_mov_b32 v9, s3 :: v_dual_mov_b32 v6, s0
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v8, s2
	v_mov_b32_e32 v7, s1
	s_clause 0x1
	global_store_b128 v[0:1], v[6:9], off offset:32
	global_store_b128 v[0:1], v[6:9], off offset:48
	v_dual_mov_b32 v4, v3 :: v_dual_mov_b32 v5, v3
	s_clause 0x5
	global_store_b128 v[0:1], v[6:9], off offset:64
	global_store_b128 v[0:1], v[6:9], off offset:80
	global_store_b128 v[0:1], v[6:9], off offset:96
	global_store_b128 v[0:1], v[6:9], off offset:112
	global_store_b128 v[0:1], v[6:9], off offset:16
	global_store_b128 v[0:1], v[2:5], off
.LBB11_406:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z6k_normPKiS0_Ptiii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 272
		.amdhsa_kernarg_size 296
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 91
		.amdhsa_next_free_sgpr 11
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 255
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end11:
	.size	_Z6k_normPKiS0_Ptiii, .Lfunc_end11-_Z6k_normPKiS0_Ptiii
                                        ; -- End function
	.set _Z6k_normPKiS0_Ptiii.num_vgpr, 91
	.set _Z6k_normPKiS0_Ptiii.num_agpr, 0
	.set _Z6k_normPKiS0_Ptiii.numbered_sgpr, 11
	.set _Z6k_normPKiS0_Ptiii.num_named_barrier, 0
	.set _Z6k_normPKiS0_Ptiii.private_seg_size, 272
	.set _Z6k_normPKiS0_Ptiii.uses_vcc, 1
	.set _Z6k_normPKiS0_Ptiii.uses_flat_scratch, 1
	.set _Z6k_normPKiS0_Ptiii.has_dyn_sized_stack, 0
	.set _Z6k_normPKiS0_Ptiii.has_recursion, 0
	.set _Z6k_normPKiS0_Ptiii.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 74596
; TotalNumSgprs: 13
; NumVgprs: 91
; ScratchSize: 272
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 11
; NumSGPRsForWavesPerEU: 13
; NumVGPRsForWavesPerEU: 91
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 1
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z8k_unpackPKhPKjS2_PhS2_i ; -- Begin function _Z8k_unpackPKhPKjS2_PhS2_i
	.globl	_Z8k_unpackPKhPKjS2_PhS2_i
	.p2align	8
	.type	_Z8k_unpackPKhPKjS2_PhS2_i,@function
_Z8k_unpackPKhPKjS2_PhS2_i:             ; @_Z8k_unpackPKhPKjS2_PhS2_i
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x3c
	s_load_b32 s3, s[0:1], 0x28
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB12_23
; %bb.1:
	s_load_b64 s[2:3], s[0:1], 0x10
	v_ashrrev_i32_e32 v1, 31, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[0:1], 2, v[0:1]
	s_wait_kmcnt 0x0
	v_add_co_u32 v2, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v3, null, s3, v1, vcc_lo
	global_load_b32 v10, v[2:3], off
	s_wait_loadcnt 0x0
	v_cmp_ne_u32_e32 vcc_lo, 0, v10
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB12_23
; %bb.2:                                ; %.lr.ph.preheader
	s_clause 0x1
	s_load_b128 s[4:7], s[0:1], 0x18
	s_load_b64 s[2:3], s[0:1], 0x8
	v_dual_mov_b32 v13, 0 :: v_dual_mov_b32 v4, 0
	v_mov_b32_e32 v5, 0
	s_wait_kmcnt 0x0
	v_add_co_u32 v2, vcc_lo, s6, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, s7, v1, vcc_lo
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_load_b32 v12, v[2:3], off
	s_mov_b32 s6, -1
	s_mov_b32 s3, exec_lo
	global_load_b32 v11, v[0:1], off
	v_mad_co_u64_u32 v[0:1], null, v10, 6, 7
	s_delay_alu instid0(VALU_DEP_1)
	v_lshrrev_b64 v[2:3], 3, v[0:1]
	s_wait_loadcnt 0x1
	v_add_co_u32 v0, s2, s4, v12
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v1, null, s5, 0, s2
	v_cmpx_lt_u32_e32 4, v10
	s_cbranch_execz .LBB12_6
; %bb.3:                                ; %vector.ph
	v_and_b32_e32 v5, 1, v3
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_dual_mov_b32 v7, v1 :: v_dual_and_b32 v4, -4, v2
	v_mov_b32_e32 v6, v0
	s_mov_b32 s6, 0
	v_dual_mov_b32 v9, v5 :: v_dual_mov_b32 v8, v4
.LBB12_4:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v8, vcc_lo, v8, -4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v9, null, -1, v9, vcc_lo
	global_store_b32 v[6:7], v13, off
	v_add_co_u32 v6, s2, v6, 4
	v_cmp_eq_u64_e32 vcc_lo, 0, v[8:9]
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v7, null, 0, v7, s2
	s_wait_alu 0xfffe
	s_or_b32 s6, vcc_lo, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB12_4
; %bb.5:                                ; %middle.block
	s_or_b32 exec_lo, exec_lo, s6
	v_cmp_ne_u64_e32 vcc_lo, v[2:3], v[4:5]
	s_or_not1_b32 s6, vcc_lo, exec_lo
.LBB12_6:                               ; %Flow61
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	s_load_b64 s[2:3], s[0:1], 0x0
	s_and_saveexec_b32 s1, s6
	s_cbranch_execz .LBB12_9
; %bb.7:                                ; %.lr.ph.preheader47
	v_add_co_u32 v6, vcc_lo, v4, v12
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, 0, v5, vcc_lo
	v_sub_co_u32 v2, vcc_lo, v2, v4
	s_wait_alu 0xfffd
	v_sub_co_ci_u32_e64 v3, null, v3, v5, vcc_lo
	v_add_co_u32 v4, vcc_lo, s4, v6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s5, v7, vcc_lo
	v_mov_b32_e32 v6, 0
	s_mov_b32 s4, 0
.LBB12_8:                               ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	v_add_co_u32 v2, vcc_lo, v2, -1
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v3, null, -1, v3, vcc_lo
	global_store_b8 v[4:5], v6, off
	v_add_co_u32 v4, s0, v4, 1
	v_cmp_eq_u64_e32 vcc_lo, 0, v[2:3]
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v5, null, 0, v5, s0
	s_wait_alu 0xfffe
	s_or_b32 s4, vcc_lo, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB12_8
.LBB12_9:                               ; %Flow62
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s1
	s_wait_loadcnt 0x0
	s_wait_kmcnt 0x0
	v_add_co_u32 v2, s0, s2, v11
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, s3, 0, s0
	s_mov_b64 s[2:3], 0
	s_mov_b32 s1, 0
	s_branch .LBB12_11
.LBB12_10:                              ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_add_nc_u32_e32 v10, -1, v10
	v_add_co_u32 v2, s0, v2, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v3, null, 0, v3, s0
	s_delay_alu instid0(VALU_DEP_3)
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	s_add_nc_u64 s[2:3], s[2:3], 6
	s_or_b32 s1, vcc_lo, s1
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execz .LBB12_23
.LBB12_11:                              ; %.preheader
                                        ; =>This Inner Loop Header: Depth=1
	global_load_u8 v4, v[2:3], off
	s_mov_b32 s0, exec_lo
	s_wait_loadcnt 0x0
	v_and_b32_e32 v5, 1, v4
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v5
	s_cbranch_execz .LBB12_13
; %bb.12:                               ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_lshr_b64 s[4:5], s[2:3], 3
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v0, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s5, v1, vcc_lo
	s_and_b32 s4, s2, 6
	s_wait_alu 0xfffe
	s_lshl_b32 s4, 1, s4
	global_load_u8 v7, v[5:6], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_or_b32_e32 v7, s4, v7
	global_store_b8 v[5:6], v7, off
.LBB12_13:                              ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_and_b32_e32 v4, 0xff, v4
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v5, 2, v4
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB12_15
; %bb.14:                               ;   in Loop: Header=BB12_11 Depth=1
	s_lshr_b64 s[4:5], s[2:3], 3
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v0, s4
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s5, v1, vcc_lo
	s_and_b32 s4, s2, 6
	s_wait_alu 0xfffe
	s_lshl_b32 s4, 2, s4
	global_load_u8 v7, v[5:6], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_or_b32_e32 v7, s4, v7
	global_store_b8 v[5:6], v7, off
.LBB12_15:                              ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_and_b32_e32 v5, 4, v4
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB12_17
; %bb.16:                               ;   in Loop: Header=BB12_11 Depth=1
	s_add_nc_u64 s[4:5], s[2:3], 2
	s_wait_alu 0xfffe
	s_lshr_b64 s[6:7], s[4:5], 3
	s_and_b32 s4, s4, 6
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v0, s6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s7, v1, vcc_lo
	s_lshl_b32 s4, 1, s4
	global_load_u8 v7, v[5:6], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_or_b32_e32 v7, s4, v7
	global_store_b8 v[5:6], v7, off
.LBB12_17:                              ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_and_b32_e32 v5, 8, v4
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB12_19
; %bb.18:                               ;   in Loop: Header=BB12_11 Depth=1
	s_add_nc_u64 s[4:5], s[2:3], 3
	s_wait_alu 0xfffe
	s_lshr_b64 s[6:7], s[4:5], 3
	s_and_b32 s4, s4, 7
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v0, s6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s7, v1, vcc_lo
	s_lshl_b32 s4, 1, s4
	global_load_u8 v7, v[5:6], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_or_b32_e32 v7, s4, v7
	global_store_b8 v[5:6], v7, off
.LBB12_19:                              ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_and_b32_e32 v5, 16, v4
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB12_21
; %bb.20:                               ;   in Loop: Header=BB12_11 Depth=1
	s_add_nc_u64 s[4:5], s[2:3], 4
	s_wait_alu 0xfffe
	s_lshr_b64 s[6:7], s[4:5], 3
	s_and_b32 s4, s4, 6
	s_wait_alu 0xfffe
	v_add_co_u32 v5, vcc_lo, v0, s6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, s7, v1, vcc_lo
	s_lshl_b32 s4, 1, s4
	global_load_u8 v7, v[5:6], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_or_b32_e32 v7, s4, v7
	global_store_b8 v[5:6], v7, off
.LBB12_21:                              ;   in Loop: Header=BB12_11 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_and_b32_e32 v4, 32, v4
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ne_u32_e32 0, v4
	s_cbranch_execz .LBB12_10
; %bb.22:                               ;   in Loop: Header=BB12_11 Depth=1
	s_add_nc_u64 s[4:5], s[2:3], 5
	s_wait_alu 0xfffe
	s_lshr_b64 s[6:7], s[4:5], 3
	s_and_b32 s4, s4, 7
	s_wait_alu 0xfffe
	v_add_co_u32 v4, vcc_lo, v0, s6
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v5, null, s7, v1, vcc_lo
	s_lshl_b32 s4, 1, s4
	global_load_u8 v6, v[4:5], off
	s_wait_loadcnt 0x0
	s_wait_alu 0xfffe
	v_or_b32_e32 v6, s4, v6
	global_store_b8 v[4:5], v6, off
	s_branch .LBB12_10
.LBB12_23:                              ; %.loopexit
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z8k_unpackPKhPKjS2_PhS2_i
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 304
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 14
		.amdhsa_next_free_sgpr 8
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 11
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end12:
	.size	_Z8k_unpackPKhPKjS2_PhS2_i, .Lfunc_end12-_Z8k_unpackPKhPKjS2_PhS2_i
                                        ; -- End function
	.set _Z8k_unpackPKhPKjS2_PhS2_i.num_vgpr, 14
	.set _Z8k_unpackPKhPKjS2_PhS2_i.num_agpr, 0
	.set _Z8k_unpackPKhPKjS2_PhS2_i.numbered_sgpr, 8
	.set _Z8k_unpackPKhPKjS2_PhS2_i.num_named_barrier, 0
	.set _Z8k_unpackPKhPKjS2_PhS2_i.private_seg_size, 0
	.set _Z8k_unpackPKhPKjS2_PhS2_i.uses_vcc, 1
	.set _Z8k_unpackPKhPKjS2_PhS2_i.uses_flat_scratch, 0
	.set _Z8k_unpackPKhPKjS2_PhS2_i.has_dyn_sized_stack, 0
	.set _Z8k_unpackPKhPKjS2_PhS2_i.has_recursion, 0
	.set _Z8k_unpackPKhPKjS2_PhS2_i.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1360
; TotalNumSgprs: 10
; NumVgprs: 14
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 10
; NumVGPRsForWavesPerEU: 14
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z10k_block_mbP5bdesci  ; -- Begin function _Z10k_block_mbP5bdesci
	.globl	_Z10k_block_mbP5bdesci
	.p2align	8
	.type	_Z10k_block_mbP5bdesci,@function
_Z10k_block_mbP5bdesci:                 ; @_Z10k_block_mbP5bdesci
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x1c
	s_load_b32 s3, s[0:1], 0x8
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB13_10
; %bb.1:
	s_load_b64 s[0:1], s[0:1], 0x0
	v_mov_b32_e32 v10, 0
	s_mov_b32 s2, exec_lo
	s_wait_kmcnt 0x0
	v_mad_co_i64_i32 v[6:7], null, v0, 40, s[0:1]
	global_load_b96 v[0:2], v[6:7], off offset:4
	s_wait_loadcnt 0x0
	v_cmpx_lt_i32_e32 0, v2
	s_cbranch_execz .LBB13_9
; %bb.2:                                ; %.lr.ph35
	s_clause 0x1
	global_load_b32 v8, v[6:7], off
	global_load_b96 v[3:5], v[6:7], off offset:24
	s_mov_b32 s3, 0
	s_mov_b32 s4, 0
	v_cmp_lt_i32_e32 vcc_lo, 0, v1
	s_wait_loadcnt 0x1
	v_ashrrev_i32_e32 v9, 31, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[9:10], 1, v[8:9]
	s_wait_loadcnt 0x0
	v_mul_lo_u32 v8, v0, v5
	v_add_co_u32 v0, s0, v3, v9
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_ci_u32_e64 v11, null, v4, v10, s0
	v_mov_b32_e32 v10, 0
	s_branch .LBB13_4
.LBB13_3:                               ; %Flow53
                                        ;   in Loop: Header=BB13_4 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s5
	s_add_co_i32 s4, s4, 1
	v_add_nc_u32_e32 v8, v8, v5
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s4, v2
	s_or_b32 s3, s0, s3
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s3
	s_cbranch_execz .LBB13_8
.LBB13_4:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB13_6 Depth 2
	s_and_saveexec_b32 s5, vcc_lo
	s_cbranch_execz .LBB13_3
; %bb.5:                                ; %.lr.ph.preheader
                                        ;   in Loop: Header=BB13_4 Depth=1
	v_ashrrev_i32_e32 v9, 31, v8
	s_mov_b32 s6, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[3:4], 1, v[8:9]
	v_mov_b32_e32 v9, v1
	v_add_co_u32 v3, s0, v0, v3
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_ci_u32_e64 v4, null, v11, v4, s0
.LBB13_6:                               ; %.lr.ph
                                        ;   Parent Loop BB13_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	flat_load_u16 v12, v[3:4]
	v_add_nc_u32_e32 v9, -1, v9
	v_add_co_u32 v3, s0, v3, 2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v4, null, 0, v4, s0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e64 s1, 0, v9
	s_or_b32 s6, s1, s6
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v13, 0, v12
	v_max_i16 v12, v12, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0xffff, v12
	v_max_u32_e32 v10, v10, v12
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB13_6
; %bb.7:                                ; %Flow
                                        ;   in Loop: Header=BB13_4 Depth=1
	s_or_b32 exec_lo, exec_lo, s6
	s_branch .LBB13_3
.LBB13_8:                               ; %Flow54
	s_or_b32 exec_lo, exec_lo, s3
.LBB13_9:                               ; %Flow55
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	v_clz_i32_u32_e32 v0, v10
	v_cmp_ne_u32_e32 vcc_lo, 0, v10
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u32_e32 v0, 32, v0
	v_cndmask_b32_e32 v0, 0, v0, vcc_lo
	global_store_b32 v[6:7], v0, off offset:16
.LBB13_10:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z10k_block_mbP5bdesci
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 272
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 14
		.amdhsa_next_free_sgpr 7
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 4
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end13:
	.size	_Z10k_block_mbP5bdesci, .Lfunc_end13-_Z10k_block_mbP5bdesci
                                        ; -- End function
	.set _Z10k_block_mbP5bdesci.num_vgpr, 14
	.set _Z10k_block_mbP5bdesci.num_agpr, 0
	.set _Z10k_block_mbP5bdesci.numbered_sgpr, 7
	.set _Z10k_block_mbP5bdesci.num_named_barrier, 0
	.set _Z10k_block_mbP5bdesci.private_seg_size, 0
	.set _Z10k_block_mbP5bdesci.uses_vcc, 1
	.set _Z10k_block_mbP5bdesci.uses_flat_scratch, 0
	.set _Z10k_block_mbP5bdesci.has_dyn_sized_stack, 0
	.set _Z10k_block_mbP5bdesci.has_recursion, 0
	.set _Z10k_block_mbP5bdesci.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 460
; TotalNumSgprs: 9
; NumVgprs: 14
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 9
; NumVGPRsForWavesPerEU: 14
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z7k_newlyPK5bdesciPj   ; -- Begin function _Z7k_newlyPK5bdesciPj
	.globl	_Z7k_newlyPK5bdesciPj
	.p2align	8
	.type	_Z7k_newlyPK5bdesciPj,@function
_Z7k_newlyPK5bdesciPj:                  ; @_Z7k_newlyPK5bdesciPj
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x24
	s_load_b32 s3, s[0:1], 0x8
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_mad_co_u64_u32 v[3:4], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_ashrrev_i32_e32 v0, 4, v3
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB14_14
; %bb.1:
	s_clause 0x1
	s_load_b64 s[4:5], s[0:1], 0x0
	s_load_b64 s[2:3], s[0:1], 0x10
	v_and_b32_e32 v6, 15, v3
	s_wait_kmcnt 0x0
	v_mad_co_i64_i32 v[4:5], null, v0, 40, s[4:5]
	global_load_b96 v[0:2], v[4:5], off offset:8
	s_wait_loadcnt 0x0
	v_cmp_lt_i32_e32 vcc_lo, v6, v2
	v_mov_b32_e32 v2, 0
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB14_13
; %bb.2:
	v_mov_b32_e32 v2, 0
	s_mov_b32 s5, exec_lo
	v_cmpx_lt_i32_e32 0, v1
	s_cbranch_execz .LBB14_12
; %bb.3:                                ; %.lr.ph59
	s_clause 0x1
	global_load_b96 v[7:9], v[4:5], off offset:24
	global_load_b64 v[4:5], v[4:5], off
	v_add_nc_u32_e32 v10, 1, v6
	v_lshlrev_b32_e64 v11, v6, 1
	v_max_i32_e32 v12, 0, v0
	s_mov_b32 s6, 0
	s_mov_b32 s7, 0
	v_cmp_lt_i32_e32 vcc_lo, 0, v0
	s_wait_loadcnt 0x1
	v_ashrrev_i32_e32 v17, 31, v9
	s_wait_loadcnt 0x0
	v_mul_lo_u32 v13, v5, v9
	v_ashrrev_i32_e32 v5, 31, v4
	v_mov_b32_e32 v16, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[18:19], 1, v[4:5]
	v_lshlrev_b64_e32 v[4:5], 1, v[16:17]
	v_ashrrev_i32_e32 v14, 31, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b64_e32 v[14:15], 1, v[13:14]
	v_mov_b32_e32 v13, 0
	v_add_co_u32 v2, s0, v7, v14
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v8, v15, s0
	v_add_co_u32 v6, s0, v2, v18
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v7, null, v7, v19, s0
	v_mov_b32_e32 v2, 0
	s_branch .LBB14_6
.LBB14_4:                               ; %Flow
                                        ;   in Loop: Header=BB14_6 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
.LBB14_5:                               ; %Flow76
                                        ;   in Loop: Header=BB14_6 Depth=1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_add_co_i32 s7, s7, 1
	v_add_co_u32 v6, s1, v6, v4
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s7, v1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v7, null, v7, v5, s1
	v_add_nc_u32_e32 v13, v13, v12
	s_delay_alu instid0(VALU_DEP_3)
	s_or_b32 s6, s0, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB14_11
.LBB14_6:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB14_9 Depth 2
	s_and_saveexec_b32 s8, vcc_lo
	s_cbranch_execz .LBB14_5
; %bb.7:                                ; %.lr.ph.preheader
                                        ;   in Loop: Header=BB14_6 Depth=1
	v_dual_mov_b32 v9, v7 :: v_dual_mov_b32 v8, v6
	s_mov_b32 s9, 0
	s_mov_b32 s10, 0
	s_branch .LBB14_9
.LBB14_8:                               ;   in Loop: Header=BB14_9 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s1
	s_add_co_i32 s10, s10, 1
	v_add_co_u32 v8, s1, v8, 2
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s10, v0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v9, null, 0, v9, s1
	s_or_b32 s9, s0, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s9
	s_cbranch_execz .LBB14_4
.LBB14_9:                               ; %.lr.ph
                                        ;   Parent Loop BB14_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	flat_load_u16 v14, v[8:9]
	s_mov_b32 s1, exec_lo
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v15, 0, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_max_i16 v14, v14, v15
	v_and_b32_e32 v14, 0xffff, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v15, v10, v14
	v_cmpx_eq_u32_e32 0, v15
	s_cbranch_execz .LBB14_8
; %bb.10:                               ;   in Loop: Header=BB14_9 Depth=2
	s_wait_alu 0xfffe
	v_add_nc_u32_e32 v15, s10, v13
	v_and_b32_e32 v14, v11, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v15, 5, v15
	v_cmp_ne_u32_e64 s0, 0, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e64 v15, v15, 1
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v14, 0, v15, s0
	s_delay_alu instid0(VALU_DEP_1)
	v_or_b32_e32 v2, v14, v2
	s_branch .LBB14_8
.LBB14_11:                              ; %Flow77
	s_or_b32 exec_lo, exec_lo, s6
.LBB14_12:                              ; %Flow78
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s5
.LBB14_13:                              ; %.sink.split
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	v_ashrrev_i32_e32 v4, 31, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[0:1], 2, v[3:4]
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v2, off
.LBB14_14:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z7k_newlyPK5bdesciPj
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 280
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 20
		.amdhsa_next_free_sgpr 11
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 6
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end14:
	.size	_Z7k_newlyPK5bdesciPj, .Lfunc_end14-_Z7k_newlyPK5bdesciPj
                                        ; -- End function
	.set _Z7k_newlyPK5bdesciPj.num_vgpr, 20
	.set _Z7k_newlyPK5bdesciPj.num_agpr, 0
	.set _Z7k_newlyPK5bdesciPj.numbered_sgpr, 11
	.set _Z7k_newlyPK5bdesciPj.num_named_barrier, 0
	.set _Z7k_newlyPK5bdesciPj.private_seg_size, 0
	.set _Z7k_newlyPK5bdesciPj.uses_vcc, 1
	.set _Z7k_newlyPK5bdesciPj.uses_flat_scratch, 0
	.set _Z7k_newlyPK5bdesciPj.has_dyn_sized_stack, 0
	.set _Z7k_newlyPK5bdesciPj.has_recursion, 0
	.set _Z7k_newlyPK5bdesciPj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 672
; TotalNumSgprs: 13
; NumVgprs: 20
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 13
; NumVGPRsForWavesPerEU: 20
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.protected	_Z9k_desym_wPKhPKjPK5bdesci ; -- Begin function _Z9k_desym_wPKhPKjPK5bdesci
	.globl	_Z9k_desym_wPKhPKjPK5bdesci
	.p2align	8
	.type	_Z9k_desym_wPKhPKjPK5bdesci,@function
_Z9k_desym_wPKhPKjPK5bdesci:            ; @_Z9k_desym_wPKhPKjPK5bdesci
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x2c
	s_load_b32 s3, s[0:1], 0x18
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_mad_co_u64_u32 v[11:12], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_ashrrev_i32_e32 v4, 5, v11
	v_cmpx_gt_i32_e64 s3, v4
	s_cbranch_execz .LBB15_43
; %bb.1:
	s_load_b128 s[4:7], s[0:1], 0x8
	v_and_b32_e32 v11, 31, v11
	v_mov_b32_e32 v27, 0
	v_mov_b32_e32 v25, 0
	s_wait_kmcnt 0x0
	v_mad_co_i64_i32 v[8:9], null, v4, 40, s[6:7]
	v_lshlrev_b32_e32 v4, 2, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v5, 31, v4
	global_load_b128 v[0:3], v[8:9], off
	v_lshlrev_b64_e32 v[4:5], 2, v[4:5]
	v_add_co_u32 v4, vcc_lo, s4, v4
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v5, null, s5, v5, vcc_lo
	global_load_b32 v12, v[8:9], off offset:16
	global_load_b128 v[4:7], v[4:5], off
	global_load_b96 v[8:10], v[8:9], off offset:24
	s_wait_loadcnt 0x3
	v_mul_lo_u32 v3, v3, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v13, 31, v3
	v_ashrrev_i32_e32 v14, 31, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v14, 27, v14
	v_add_nc_u32_e32 v13, v13, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v26, 5, v13
	v_lshlrev_b32_e32 v13, 5, v11
	v_cmp_lt_i32_e32 vcc_lo, v11, v26
	s_and_saveexec_b32 s3, vcc_lo
	s_cbranch_execz .LBB15_3
; %bb.2:
	v_sub_nc_u32_e32 v14, 0, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_max_i32_e32 v14, v2, v14
	v_cvt_f32_u32_e32 v15, v14
	v_sub_nc_u32_e32 v16, 0, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(TRANS32_DEP_1)
	v_rcp_iflag_f32_e32 v15, v15
	v_mul_f32_e32 v15, 0x4f7ffffe, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_u32_f32_e32 v15, v15
	v_mul_lo_u32 v16, v16, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v16, v15, v16
	v_add_nc_u32_e32 v15, v15, v16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_hi_u32 v15, v13, v15
	v_mul_lo_u32 v16, v15, v14
	v_add_nc_u32_e32 v17, 1, v15
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_u32_e32 v16, v13, v16
	v_sub_nc_u32_e32 v18, v16, v14
	v_cmp_ge_u32_e64 s2, v16, v14
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v15, v15, v17, s2
	v_cndmask_b32_e64 v16, v16, v18, s2
	v_ashrrev_i32_e32 v18, 31, v2
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v17, 1, v15
	v_cmp_ge_u32_e64 s2, v16, v14
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v14, v15, v17, s2
	v_xor_b32_e32 v14, v14, v18
	s_delay_alu instid0(VALU_DEP_1)
	v_sub_nc_u32_e32 v27, v14, v18
.LBB15_3:
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	s_wait_loadcnt 0x0
	v_mul_lo_u32 v14, v10, v1
	v_sub_nc_u32_e32 v3, v3, v13
	v_mul_lo_u32 v18, v27, v2
	v_ashrrev_i32_e32 v1, 31, v0
	s_mov_b32 s9, exec_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_min_i32_e32 v3, 32, v3
	v_lshlrev_b64_e32 v[16:17], 1, v[0:1]
	v_ashrrev_i32_e32 v15, 31, v14
	v_sub_nc_u32_e32 v0, v13, v18
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cndmask_b32_e32 v24, 0, v3, vcc_lo
	v_lshlrev_b64_e32 v[14:15], 1, v[14:15]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e32 v0, 0, v0, vcc_lo
	v_add_co_u32 v1, s2, v8, v14
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v3, null, v9, v15, s2
	v_add_co_u32 v1, s2, v1, v16
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v9, null, v3, v17, s2
	v_cmpx_lt_i32_e32 0, v12
	s_cbranch_execz .LBB15_37
; %bb.4:                                ; %.lr.ph283
	s_load_b64 s[0:1], s[0:1], 0x0
	v_mad_co_i64_i32 v[13:14], null, v27, v10, 0
	v_mbcnt_lo_u32_b32 v8, -1, 0
	v_add_nc_u32_e32 v28, -1, v12
	v_mov_b32_e32 v12, 0
	v_cmp_gt_i32_e64 s6, 1, v24
	v_ashrrev_i32_e32 v37, 31, v10
	v_cmp_gt_u32_e64 s4, 8, v11
	v_cmp_gt_u32_e64 s5, 16, v11
	s_mov_b32 s10, 0
	s_xor_b32 s11, s6, -1
	v_mov_b32_e32 v44, 0x7c
	s_wait_kmcnt 0x0
	v_add_co_u32 v29, s2, s0, v4
	v_lshlrev_b64_e32 v[3:4], 1, v[13:14]
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v30, null, s1, 0, s2
	v_add_co_u32 v31, s2, s0, v5
	v_add_nc_u32_e32 v5, -1, v8
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v32, null, s1, 0, s2
	v_add_co_u32 v33, s2, s0, v6
	v_add_co_u32 v35, s0, s0, v7
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v36, null, s1, 0, s0
	v_add_co_u32 v3, s0, v1, v3
	v_dual_mov_b32 v25, v12 :: v_dual_add_nc_u32 v6, -2, v8
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v4, null, v9, v4, s0
	v_cmp_gt_i32_e64 s0, 0, v5
	v_mov_b32_e32 v13, 0
	v_add_nc_u32_e32 v7, -16, v8
	v_add_co_ci_u32_e64 v34, null, s1, 0, s2
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v5, v5, v8, s0
	v_cmp_gt_i32_e64 s0, 0, v6
	v_mov_b32_e32 v38, v10
	v_cmp_eq_u32_e64 s1, 0, v11
	v_cmp_gt_u32_e64 s2, 2, v11
	v_lshlrev_b32_e32 v39, 2, v5
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v6, v6, v8, s0
	v_add_nc_u32_e32 v5, -4, v8
	v_cmp_lt_i32_e64 s0, 0, v24
	v_mov_b32_e32 v14, 0
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v40, 2, v6
	v_add_nc_u32_e32 v6, -8, v8
	v_cmp_gt_i32_e64 s3, 0, v5
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v5, v5, v8, s3
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_gt_i32_e64 s3, 0, v6
	v_lshlrev_b32_e32 v41, 2, v5
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v6, v6, v8, s3
	v_dual_mov_b32 v5, 0 :: v_dual_lshlrev_b32 v42, 2, v6
	v_mov_b32_e32 v6, 0
	v_cmp_gt_i32_e64 s3, 0, v7
	v_mov_b32_e32 v45, v28
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v7, v7, v8, s3
	v_cmp_gt_u32_e64 s3, 4, v11
	v_lshlrev_b32_e32 v43, 2, v7
	v_mov_b32_e32 v7, 0
	v_mov_b32_e32 v8, 0
	s_branch .LBB15_7
.LBB15_5:                               ; %Flow307
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_or_b32 exec_lo, exec_lo, s8
.LBB15_6:                               ; %Flow308
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s7
	v_ashrrev_i32_e32 v15, 31, v49
	v_ashrrev_i32_e32 v16, 31, v48
	v_add_co_u32 v5, s6, v5, v49
	s_wait_dscnt 0x0
	v_add_co_u32 v13, s7, v13, v17
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v6, null, v6, v15, s6
	v_add_co_u32 v7, s6, v7, v48
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v8, null, v8, v16, s6
	v_ashrrev_i32_e32 v15, 31, v17
	v_add_nc_u32_e32 v16, -1, v45
	v_cmp_gt_i32_e64 s6, 1, v45
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v14, null, v14, v15, s7
	v_mov_b32_e32 v45, v16
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 s10, s6, s10
	s_and_not1_b32 exec_lo, exec_lo, s10
	s_cbranch_execz .LBB15_36
.LBB15_7:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB15_12 Depth 2
                                        ;     Child Loop BB15_20 Depth 2
                                        ;     Child Loop BB15_34 Depth 2
	s_mov_b32 s12, -1
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB15_9
; %bb.8:                                ;   in Loop: Header=BB15_7 Depth=1
	v_sub_nc_u32_e32 v17, v28, v45
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mad_co_u64_u32 v[15:16], null, v17, v26, v[11:12]
	v_ashrrev_i32_e32 v17, 31, v17
	v_mad_co_u64_u32 v[16:17], null, v17, v26, v[16:17]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b64 v[16:17], 3, v[15:16]
	v_and_b32_e32 v15, 7, v15
	v_add_co_u32 v16, s6, v29, v16
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v17, null, v30, v17, s6
	global_load_u8 v16, v[16:17], off
	s_wait_loadcnt 0x0
	v_bfe_u32 v15, v16, v15, 1
	v_cmp_eq_u32_e64 s6, 0, v15
	s_or_not1_b32 s12, s6, exec_lo
.LBB15_9:                               ;   in Loop: Header=BB15_7 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s7
	v_dual_mov_b32 v20, 0 :: v_dual_mov_b32 v19, 0
	v_dual_mov_b32 v46, 0 :: v_dual_mov_b32 v47, 0
	s_and_saveexec_b32 s13, s0
	s_cbranch_execz .LBB15_17
; %bb.10:                               ; %.lr.ph
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_xor_b32 s6, s12, -1
	v_dual_mov_b32 v47, 0 :: v_dual_mov_b32 v16, v4
	v_dual_mov_b32 v20, 0 :: v_dual_add_nc_u32 v21, 1, v45
	s_wait_alu 0xfffe
	v_cndmask_b32_e64 v22, 0, 1, s6
	v_dual_mov_b32 v19, 0 :: v_dual_mov_b32 v46, 0
	v_mov_b32_e32 v17, v0
	v_mov_b32_e32 v15, v3
	s_mov_b32 s14, 0
	s_mov_b32 s15, 0
	s_branch .LBB15_12
.LBB15_11:                              ;   in Loop: Header=BB15_12 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s6
	v_add_nc_u32_e32 v23, 1, v17
	s_add_co_i32 s15, s15, 1
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s7, s15, v24
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e64 s6, v23, v2
	s_or_b32 s14, s7, s14
	v_cndmask_b32_e64 v18, 0, v37, s6
	v_cndmask_b32_e64 v17, 0, v38, s6
	v_lshlrev_b64_e32 v[17:18], 1, v[17:18]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v15, s8, v15, v17
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v16, null, v16, v18, s8
	v_cndmask_b32_e64 v17, v23, 0, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s14
	s_cbranch_execz .LBB15_16
.LBB15_12:                              ;   Parent Loop BB15_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v18, 31, v17
	s_wait_alu 0xfffe
	s_lshl_b32 s7, 1, s15
	v_lshlrev_b64_e32 v[48:49], 1, v[17:18]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v48, s6, v15, v48
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v49, null, v16, v49, s6
	flat_load_u16 v18, v[48:49]
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v23, 0, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_max_i16 v18, v18, v23
	v_and_b32_e32 v18, 0xffff, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v18, v21, v18
	v_cmp_ne_u32_e64 s6, 0, v18
	s_and_saveexec_b32 s8, s6
	s_wait_alu 0xfffe
	s_xor_b32 s6, exec_lo, s8
; %bb.13:                               ;   in Loop: Header=BB15_12 Depth=2
	v_or_b32_e32 v47, s7, v47
	v_add_nc_u32_e32 v20, 1, v20
; %bb.14:                               ; %Flow315
                                        ;   in Loop: Header=BB15_12 Depth=2
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s6, s6
	s_cbranch_execz .LBB15_11
; %bb.15:                               ;   in Loop: Header=BB15_12 Depth=2
	v_cndmask_b32_e64 v18, s7, 0, s12
	v_add_nc_u32_e32 v19, v19, v22
	s_delay_alu instid0(VALU_DEP_2)
	v_or_b32_e32 v46, v18, v46
	s_branch .LBB15_11
.LBB15_16:                              ; %Flow316
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_or_b32 exec_lo, exec_lo, s14
.LBB15_17:                              ; %Flow317
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s13
	ds_bpermute_b32 v15, v39, v19
	ds_bpermute_b32 v16, v39, v20
	s_mov_b32 s13, 0
	v_mov_b32_e32 v50, 0
	s_wait_dscnt 0x1
	v_cndmask_b32_e64 v15, v15, 0, s1
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v16, v16, 0, s1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v15, v15, v19
	v_add_nc_u32_e32 v16, v16, v20
	ds_bpermute_b32 v17, v40, v15
	ds_bpermute_b32 v18, v40, v16
	s_wait_dscnt 0x1
	v_cndmask_b32_e64 v17, v17, 0, s2
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v18, v18, 0, s2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v15, v17, v15
	v_add_nc_u32_e32 v16, v18, v16
	ds_bpermute_b32 v17, v41, v15
	ds_bpermute_b32 v18, v41, v16
	s_wait_dscnt 0x1
	v_cndmask_b32_e64 v17, v17, 0, s3
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v18, v18, 0, s3
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v15, v17, v15
	v_add_nc_u32_e32 v16, v18, v16
	ds_bpermute_b32 v17, v42, v15
	ds_bpermute_b32 v18, v42, v16
	s_wait_dscnt 0x1
	v_cndmask_b32_e64 v17, v17, 0, s4
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v18, v18, 0, s4
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v15, v17, v15
	v_add_nc_u32_e32 v16, v18, v16
	ds_bpermute_b32 v17, v43, v15
	ds_bpermute_b32 v18, v43, v16
	s_wait_dscnt 0x1
	v_cndmask_b32_e64 v17, v17, 0, s5
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v18, v18, 0, s5
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v15, v17, v15
	v_add_nc_u32_e32 v16, v18, v16
	ds_bpermute_b32 v49, v44, v15
	ds_bpermute_b32 v48, v44, v16
	s_and_saveexec_b32 s12, s0
	s_cbranch_execz .LBB15_31
; %bb.18:                               ; %.lr.ph268
                                        ;   in Loop: Header=BB15_7 Depth=1
	v_sub_nc_u32_e32 v16, v16, v20
	v_sub_nc_u32_e32 v17, v15, v19
	v_lshlrev_b32_e64 v51, v45, 1
	v_dual_mov_b32 v50, 0 :: v_dual_mov_b32 v21, v0
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_ashrrev_i32_e32 v18, 31, v16
	v_ashrrev_i32_e32 v19, 31, v17
	v_add_co_u32 v15, s6, v7, v16
	s_mov_b32 s14, 0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v16, null, v8, v18, s6
	v_add_co_u32 v17, s6, v5, v17
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v18, null, v6, v19, s6
	v_dual_mov_b32 v20, v4 :: v_dual_mov_b32 v19, v3
	s_branch .LBB15_20
.LBB15_19:                              ;   in Loop: Header=BB15_20 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s6
	v_add_nc_u32_e32 v23, 1, v21
	s_add_co_i32 s14, s14, 1
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s7, s14, v24
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e64 s6, v23, v2
	s_or_b32 s13, s7, s13
	v_cndmask_b32_e64 v22, 0, v37, s6
	v_cndmask_b32_e64 v21, 0, v38, s6
	v_lshlrev_b64_e32 v[21:22], 1, v[21:22]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v19, s8, v19, v21
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v20, null, v20, v22, s8
	v_cndmask_b32_e64 v21, v23, 0, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s13
	s_cbranch_execz .LBB15_30
.LBB15_20:                              ;   Parent Loop BB15_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_delay_alu instid0(VALU_DEP_1)
	v_ashrrev_i32_e32 v22, 31, v21
	s_wait_alu 0xfffe
	s_lshl_b32 s8, 1, s14
	s_mov_b32 s7, 0
	s_wait_alu 0xfffe
	v_and_b32_e32 v52, s8, v47
	v_lshlrev_b64_e32 v[22:23], 1, v[21:22]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v22, s6, v19, v22
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v23, null, v20, v23, s6
	v_cmp_ne_u32_e64 s6, 0, v52
                                        ; implicit-def: $vgpr52
	s_and_saveexec_b32 s15, s6
	s_wait_alu 0xfffe
	s_xor_b32 s15, exec_lo, s15
	s_cbranch_execnz .LBB15_23
; %bb.21:                               ; %Flow309
                                        ;   in Loop: Header=BB15_20 Depth=2
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s15, s15
	s_cbranch_execnz .LBB15_24
.LBB15_22:                              ; %Flow310
                                        ;   in Loop: Header=BB15_20 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s15
	s_and_saveexec_b32 s6, s7
	s_cbranch_execz .LBB15_19
	s_branch .LBB15_29
.LBB15_23:                              ;   in Loop: Header=BB15_20 Depth=2
	v_lshrrev_b64 v[52:53], 3, v[15:16]
	v_and_b32_e32 v54, 7, v15
	s_mov_b32 s7, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v52, s6, v35, v52
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v53, null, v36, v53, s6
	global_load_u8 v52, v[52:53], off
	flat_load_u16 v53, v[22:23]
	s_wait_loadcnt 0x1
	v_lshrrev_b32_e32 v52, v54, v52
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v54, 0, v53
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_and_b32_e32 v52, 1, v52
	v_max_i16 v53, v53, v54
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e64 s6, 1, v52
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v52, 0, v51, s6
	v_add_co_u32 v15, s6, v15, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v16, null, 0, v16, s6
	s_delay_alu instid0(VALU_DEP_3)
	v_or_b32_e32 v52, v52, v53
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s15, s15
	s_cbranch_execz .LBB15_22
.LBB15_24:                              ;   in Loop: Header=BB15_20 Depth=2
	v_and_b32_e32 v52, s8, v46
	s_mov_b32 s17, s7
	s_mov_b32 s16, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ne_u32_e32 0, v52
	s_cbranch_execz .LBB15_28
; %bb.25:                               ;   in Loop: Header=BB15_20 Depth=2
	v_lshrrev_b64 v[52:53], 3, v[17:18]
	s_mov_b32 s17, s7
	s_mov_b32 s18, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v52, s6, v31, v52
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v53, null, v32, v53, s6
	global_load_u8 v52, v[52:53], off
	v_and_b32_e32 v53, 7, v17
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v52, v53, v52
	v_and_b32_e32 v52, 1, v52
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v52
; %bb.26:                               ;   in Loop: Header=BB15_20 Depth=2
	v_or_b32_e32 v50, s8, v50
	s_or_b32 s17, s7, exec_lo
; %bb.27:                               ; %Flow312
                                        ;   in Loop: Header=BB15_20 Depth=2
	s_or_b32 exec_lo, exec_lo, s18
	v_add_co_u32 v17, s6, v17, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v18, null, 0, v18, s6
	s_and_not1_b32 s6, s7, exec_lo
	s_and_b32 s8, s17, exec_lo
	s_wait_alu 0xfffe
	s_or_b32 s17, s6, s8
.LBB15_28:                              ; %Flow311
                                        ;   in Loop: Header=BB15_20 Depth=2
	s_or_b32 exec_lo, exec_lo, s16
	v_mov_b32_e32 v52, v51
	s_and_not1_b32 s6, s7, exec_lo
	s_and_b32 s7, s17, exec_lo
	s_wait_alu 0xfffe
	s_or_b32 s7, s6, s7
	s_or_b32 exec_lo, exec_lo, s15
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s6, s7
	s_cbranch_execz .LBB15_19
.LBB15_29:                              ; %.sink.split
                                        ;   in Loop: Header=BB15_20 Depth=2
	flat_store_b16 v[22:23], v52
	s_branch .LBB15_19
.LBB15_30:                              ; %Flow313
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_or_b32 exec_lo, exec_lo, s13
.LBB15_31:                              ; %Flow314
                                        ;   in Loop: Header=BB15_7 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s12
	v_bcnt_u32_b32 v15, v50, 0
	v_cmp_ne_u32_e64 s6, 0, v50
	ds_bpermute_b32 v16, v39, v15
	s_and_b32 s6, s6, s11
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v16, v16, 0, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v16, v50, v16
	ds_bpermute_b32 v17, v40, v16
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v17, v17, 0, s2
	v_add_nc_u32_e32 v16, v17, v16
	ds_bpermute_b32 v17, v41, v16
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v17, v17, 0, s3
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v16, v17, v16
	ds_bpermute_b32 v17, v42, v16
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v17, v17, 0, s4
	v_add_nc_u32_e32 v16, v17, v16
	ds_bpermute_b32 v17, v43, v16
	s_wait_dscnt 0x0
	v_cndmask_b32_e64 v17, v17, 0, s5
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v16, v17, v16
	ds_bpermute_b32 v17, v44, v16
	s_wait_alu 0xfffe
	s_and_saveexec_b32 s7, s6
	s_cbranch_execz .LBB15_6
; %bb.32:                               ; %.lr.ph275.preheader
                                        ;   in Loop: Header=BB15_7 Depth=1
	v_sub_nc_u32_e32 v15, v16, v15
	s_mov_b32 s8, 0
	s_mov_b32 s12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v16, 31, v15
	v_add_co_u32 v15, s6, v13, v15
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v16, null, v14, v16, s6
	s_branch .LBB15_34
.LBB15_33:                              ;   in Loop: Header=BB15_34 Depth=2
	s_or_b32 exec_lo, exec_lo, s13
	s_add_co_i32 s12, s12, 1
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s6, s12, v24
	s_or_b32 s8, s6, s8
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s8
	s_cbranch_execz .LBB15_5
.LBB15_34:                              ; %.lr.ph275
                                        ;   Parent Loop BB15_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_wait_alu 0xfffe
	s_lshl_b32 s14, 1, s12
	s_mov_b32 s13, exec_lo
	s_wait_alu 0xfffe
	v_and_b32_e32 v18, s14, v50
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_ne_u32_e32 0, v18
	s_cbranch_execz .LBB15_33
; %bb.35:                               ;   in Loop: Header=BB15_34 Depth=2
	v_lshrrev_b64 v[18:19], 3, v[15:16]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v18, s6, v33, v18
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v19, null, v34, v19, s6
	global_load_u8 v18, v[18:19], off
	v_and_b32_e32 v19, 7, v15
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v18, v19, v18
	v_and_b32_e32 v18, 1, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e64 s6, 1, v18
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v18, 0, s14, s6
	v_add_co_u32 v15, s6, v15, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v16, null, 0, v16, s6
	s_delay_alu instid0(VALU_DEP_3)
	v_or_b32_e32 v25, v18, v25
	s_branch .LBB15_33
.LBB15_36:                              ; %Flow319
	s_or_b32 exec_lo, exec_lo, s10
.LBB15_37:                              ; %Flow320
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s9
	v_cmp_ne_u32_e32 vcc_lo, 0, v25
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB15_43
; %bb.38:
	v_cmp_lt_i32_e32 vcc_lo, 0, v24
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB15_43
; %bb.39:                               ; %.lr.ph290.preheader
	v_mad_co_i64_i32 v[3:4], null, v27, v10, 0
	s_mov_b32 s2, 0
	s_mov_b32 s3, 0
	v_lshlrev_b64_e32 v[5:6], 1, v[3:4]
	v_ashrrev_i32_e32 v3, 31, v10
	v_mov_b32_e32 v4, v10
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_add_co_u32 v5, vcc_lo, v1, v5
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v6, null, v9, v6, vcc_lo
	s_branch .LBB15_41
.LBB15_40:                              ;   in Loop: Header=BB15_41 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s0
	v_add_nc_u32_e32 v7, 1, v0
	s_add_co_i32 s3, s3, 1
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s3, v24
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e32 vcc_lo, v7, v2
	s_or_b32 s2, s0, s2
	s_wait_alu 0xfffd
	v_dual_cndmask_b32 v1, 0, v3 :: v_dual_cndmask_b32 v0, 0, v4
	v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v5, s1, v5, v0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v6, null, v6, v1, s1
	v_cndmask_b32_e64 v0, v7, 0, vcc_lo
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB15_43
.LBB15_41:                              ; %.lr.ph290
                                        ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	v_lshrrev_b32_e32 v1, s3, v25
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v1, 1, v1
	v_cmpx_eq_u32_e32 1, v1
	s_cbranch_execz .LBB15_40
; %bb.42:                               ;   in Loop: Header=BB15_41 Depth=1
	v_ashrrev_i32_e32 v1, 31, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[7:8], 1, v[0:1]
	v_add_co_u32 v7, vcc_lo, v5, v7
	s_wait_alu 0xfffd
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v8, null, v6, v8, vcc_lo
	flat_load_u16 v1, v[7:8]
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v1, 0, v1
	flat_store_b16 v[7:8], v1
	s_branch .LBB15_40
.LBB15_43:                              ; %.loopexit
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z9k_desym_wPKhPKjPK5bdesci
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 288
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 55
		.amdhsa_next_free_sgpr 19
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 26
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end15:
	.size	_Z9k_desym_wPKhPKjPK5bdesci, .Lfunc_end15-_Z9k_desym_wPKhPKjPK5bdesci
                                        ; -- End function
	.set _Z9k_desym_wPKhPKjPK5bdesci.num_vgpr, 55
	.set _Z9k_desym_wPKhPKjPK5bdesci.num_agpr, 0
	.set _Z9k_desym_wPKhPKjPK5bdesci.numbered_sgpr, 19
	.set _Z9k_desym_wPKhPKjPK5bdesci.num_named_barrier, 0
	.set _Z9k_desym_wPKhPKjPK5bdesci.private_seg_size, 0
	.set _Z9k_desym_wPKhPKjPK5bdesci.uses_vcc, 1
	.set _Z9k_desym_wPKhPKjPK5bdesci.uses_flat_scratch, 0
	.set _Z9k_desym_wPKhPKjPK5bdesci.has_dyn_sized_stack, 0
	.set _Z9k_desym_wPKhPKjPK5bdesci.has_recursion, 0
	.set _Z9k_desym_wPKhPKjPK5bdesci.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3272
; TotalNumSgprs: 21
; NumVgprs: 55
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 6
; NumSGPRsForWavesPerEU: 21
; NumVGPRsForWavesPerEU: 55
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.section	.text._Z7k_desymILi1024EEvPKhPKjPK5bdesci,"axG",@progbits,_Z7k_desymILi1024EEvPKhPKjPK5bdesci,comdat
	.protected	_Z7k_desymILi1024EEvPKhPKjPK5bdesci ; -- Begin function _Z7k_desymILi1024EEvPKhPKjPK5bdesci
	.globl	_Z7k_desymILi1024EEvPKhPKjPK5bdesci
	.p2align	8
	.type	_Z7k_desymILi1024EEvPKhPKjPK5bdesci,@function
_Z7k_desymILi1024EEvPKhPKjPK5bdesci:    ; @_Z7k_desymILi1024EEvPKhPKjPK5bdesci
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x2c
	s_load_b32 s3, s[0:1], 0x18
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB16_39
; %bb.1:                                ; %.preheader109
	s_clause 0x1
	s_load_b64 s[4:5], s[0:1], 0x10
	s_load_b128 s[0:3], s[0:1], 0x0
	v_lshlrev_b32_e32 v1, 2, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v2, 31, v1
	s_wait_kmcnt 0x0
	v_mad_co_i64_i32 v[3:4], null, v0, 40, s[4:5]
	v_lshlrev_b64_e32 v[0:1], 2, v[1:2]
	s_mov_b32 s5, 0
	s_mov_b32 s4, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s2, v0
	global_load_b128 v[32:35], v[3:4], off
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_load_b32 v52, v[3:4], off offset:16
	global_load_b128 v[36:39], v[0:1], off
	global_load_b96 v[40:42], v[3:4], off offset:24
	v_mov_b32_e32 v0, 0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v1, v0 :: v_dual_mov_b32 v2, v0
	v_dual_mov_b32 v3, v0 :: v_dual_mov_b32 v4, v0
	v_dual_mov_b32 v5, v0 :: v_dual_mov_b32 v6, v0
	v_dual_mov_b32 v7, v0 :: v_dual_mov_b32 v8, v0
	v_dual_mov_b32 v9, v0 :: v_dual_mov_b32 v10, v0
	v_dual_mov_b32 v11, v0 :: v_dual_mov_b32 v12, v0
	v_dual_mov_b32 v13, v0 :: v_dual_mov_b32 v14, v0
	v_dual_mov_b32 v15, v0 :: v_dual_mov_b32 v16, v0
	v_dual_mov_b32 v17, v0 :: v_dual_mov_b32 v18, v0
	v_dual_mov_b32 v19, v0 :: v_dual_mov_b32 v20, v0
	v_dual_mov_b32 v21, v0 :: v_dual_mov_b32 v22, v0
	v_dual_mov_b32 v23, v0 :: v_dual_mov_b32 v24, v0
	v_dual_mov_b32 v25, v0 :: v_dual_mov_b32 v26, v0
	v_dual_mov_b32 v27, v0 :: v_dual_mov_b32 v28, v0
	v_dual_mov_b32 v29, v0 :: v_dual_mov_b32 v30, v0
	v_mov_b32_e32 v31, v0
	s_wait_loadcnt 0x3
	v_mul_lo_u32 v43, v35, v34
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_lt_i32_e32 0, v43
	s_cbranch_execz .LBB16_5
; %bb.2:                                ; %.lr.ph.preheader
	v_dual_mov_b32 v2, v0 :: v_dual_add_nc_u32 v5, 31, v43
	v_dual_mov_b32 v1, v0 :: v_dual_mov_b32 v4, v0
	v_dual_mov_b32 v3, v0 :: v_dual_mov_b32 v6, v0
	s_delay_alu instid0(VALU_DEP_3)
	v_lshrrev_b32_e32 v43, 5, v5
	v_dual_mov_b32 v5, v0 :: v_dual_mov_b32 v8, v0
	v_dual_mov_b32 v7, v0 :: v_dual_mov_b32 v10, v0
	v_dual_mov_b32 v9, v0 :: v_dual_mov_b32 v12, v0
	v_dual_mov_b32 v11, v0 :: v_dual_mov_b32 v14, v0
	v_dual_mov_b32 v13, v0 :: v_dual_mov_b32 v16, v0
	v_dual_mov_b32 v15, v0 :: v_dual_mov_b32 v18, v0
	v_dual_mov_b32 v17, v0 :: v_dual_mov_b32 v20, v0
	v_dual_mov_b32 v19, v0 :: v_dual_mov_b32 v22, v0
	v_dual_mov_b32 v21, v0 :: v_dual_mov_b32 v24, v0
	v_dual_mov_b32 v23, v0 :: v_dual_mov_b32 v26, v0
	v_dual_mov_b32 v25, v0 :: v_dual_mov_b32 v28, v0
	v_dual_mov_b32 v27, v0 :: v_dual_mov_b32 v30, v0
	v_mov_b32_e32 v29, v0
	v_mov_b32_e32 v31, v0
	s_mov_b64 s[2:3], 0
.LBB16_3:                               ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	s_wait_alu 0xfffe
	s_mov_b32 m0, s2
	s_add_nc_u64 s[2:3], s[2:3], 1
	v_movreld_b32_e32 v0, 0
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e32 vcc_lo, s2, v43
	s_or_b32 s5, vcc_lo, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB16_3
; %bb.4:                                ; %Flow205
	s_or_b32 exec_lo, exec_lo, s5
.LBB16_5:                               ; %Flow206
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	s_wait_loadcnt 0x0
	v_mul_lo_u32 v43, v42, v33
	v_ashrrev_i32_e32 v33, 31, v32
	v_max_i32_e32 v53, 0, v34
	s_mov_b32 s34, 0
	s_mov_b32 s33, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b64_e32 v[32:33], 1, v[32:33]
	v_ashrrev_i32_e32 v44, 31, v43
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b64_e32 v[43:44], 1, v[43:44]
	v_cmpx_lt_i32_e32 0, v52
	s_cbranch_execz .LBB16_31
; %bb.6:                                ; %.preheader106.lr.ph
	v_add_co_u32 v54, s2, s0, v36
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v55, null, s1, 0, s2
	v_add_co_u32 v56, s2, s0, v37
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v57, null, s1, 0, s2
	v_add_co_u32 v58, s2, s0, v38
	v_add_co_u32 v60, s0, s0, v39
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v59, null, s1, 0, s2
	v_add_co_ci_u32_e64 v61, null, s1, 0, s0
	v_add_co_u32 v49, s1, v32, v43
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v50, null, v33, v44, s1
	v_dual_mov_b32 v36, 0 :: v_dual_mov_b32 v45, 0
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_u32 v62, s1, v40, v49
	v_dual_mov_b32 v37, 0 :: v_dual_mov_b32 v38, 0
	v_dual_mov_b32 v46, 0 :: v_dual_mov_b32 v47, 0
	v_cmp_lt_i32_e64 s0, 0, v34
	v_dual_mov_b32 v39, 0 :: v_dual_mov_b32 v48, 0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v63, null, v41, v50, s1
	v_cmp_lt_i32_e32 vcc_lo, 0, v35
	s_branch .LBB16_9
.LBB16_7:                               ; %Flow201
                                        ;   in Loop: Header=BB16_9 Depth=1
	s_or_b32 exec_lo, exec_lo, s36
.LBB16_8:                               ; %Flow202
                                        ;   in Loop: Header=BB16_9 Depth=1
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s35
	v_cmp_gt_i32_e64 s1, 2, v52
	v_mov_b32_e32 v52, v64
	s_or_b32 s34, s1, s34
	s_and_not1_b32 exec_lo, exec_lo, s34
	s_cbranch_execz .LBB16_30
.LBB16_9:                               ; %.preheader106
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB16_13 Depth 2
                                        ;       Child Loop BB16_19 Depth 3
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v64, -1, v52
	s_and_saveexec_b32 s35, vcc_lo
	s_cbranch_execz .LBB16_8
; %bb.10:                               ; %.lr.ph138
                                        ;   in Loop: Header=BB16_9 Depth=1
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e64 v65, v64, 1
	v_dual_mov_b32 v66, 0 :: v_dual_mov_b32 v49, 0
	v_mov_b32_e32 v67, 0
	s_mov_b32 s36, 0
	s_mov_b32 s37, 0
	s_branch .LBB16_13
.LBB16_11:                              ; %Flow199
                                        ;   in Loop: Header=BB16_13 Depth=2
	s_or_b32 exec_lo, exec_lo, s39
.LBB16_12:                              ; %Flow200
                                        ;   in Loop: Header=BB16_13 Depth=2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s38
	s_wait_alu 0xfffe
	s_add_co_i32 s37, s37, 1
	v_add_nc_u32_e32 v49, v49, v42
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s1, s37, v35
	v_add_nc_u32_e32 v66, v66, v53
	s_or_b32 s36, s1, s36
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s36
	s_cbranch_execz .LBB16_7
.LBB16_13:                              ;   Parent Loop BB16_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB16_19 Depth 3
	s_and_saveexec_b32 s38, s0
	s_cbranch_execz .LBB16_12
; %bb.14:                               ; %.lr.ph122.preheader
                                        ;   in Loop: Header=BB16_13 Depth=2
	v_ashrrev_i32_e32 v50, 31, v49
	s_mov_b32 s39, 0
	s_mov_b32 s40, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[50:51], 1, v[49:50]
	v_add_co_u32 v50, s1, v62, v50
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v51, null, v63, v51, s1
	s_branch .LBB16_19
.LBB16_15:                              ; %Flow195
                                        ;   in Loop: Header=BB16_19 Depth=3
	s_or_b32 exec_lo, exec_lo, s44
	v_add_co_u32 v45, s1, v45, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v46, null, 0, v46, s1
.LBB16_16:                              ; %Flow196
                                        ;   in Loop: Header=BB16_19 Depth=3
	s_or_b32 exec_lo, exec_lo, s43
	v_add_co_u32 v38, s1, v38, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v39, null, 0, v39, s1
.LBB16_17:                              ; %Flow197
                                        ;   in Loop: Header=BB16_19 Depth=3
	s_or_b32 exec_lo, exec_lo, s42
.LBB16_18:                              ;   in Loop: Header=BB16_19 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s41
	s_add_co_i32 s40, s40, 1
	v_add_co_u32 v50, s2, v50, 2
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s1, s40, v34
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v51, null, 0, v51, s2
	s_or_b32 s39, s1, s39
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s39
	s_cbranch_execz .LBB16_11
.LBB16_19:                              ; %.lr.ph122
                                        ;   Parent Loop BB16_9 Depth=1
                                        ;     Parent Loop BB16_13 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	s_wait_alu 0xfffe
	v_add_nc_u32_e32 v69, s40, v66
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v68, 31, v69
	v_cmpx_eq_u32_e32 0, v68
	s_cbranch_execz .LBB16_21
; %bb.20:                               ;   in Loop: Header=BB16_19 Depth=3
	v_lshrrev_b64 v[70:71], 3, v[36:37]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v70, s1, v54, v70
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v71, null, v55, v71, s1
	global_load_u8 v67, v[70:71], off
	v_and_b32_e32 v70, 7, v36
	v_add_co_u32 v36, s1, v36, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v37, null, 0, v37, s1
	s_wait_loadcnt 0x0
	v_bfe_u32 v67, v67, v70, 1
.LBB16_21:                              ;   in Loop: Header=BB16_19 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	flat_load_u16 v70, v[50:51]
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt_dscnt 0x0
	v_bfe_i32 v71, v70, 0, 16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v71, v52, v71
	v_cmpx_ne_u32_e32 0, v71
	s_wait_alu 0xfffe
	s_xor_b32 s2, exec_lo, s2
	s_cbranch_execz .LBB16_25
; %bb.22:                               ;   in Loop: Header=BB16_19 Depth=3
	v_lshrrev_b64 v[68:69], 3, v[47:48]
	s_mov_b32 s3, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v68, s1, v60, v68
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v69, null, v61, v69, s1
	global_load_u8 v68, v[68:69], off
	v_and_b32_e32 v69, 7, v47
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v68, v69, v68
	v_and_b32_e32 v68, 1, v68
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v68
	s_cbranch_execz .LBB16_24
; %bb.23:                               ;   in Loop: Header=BB16_19 Depth=3
	v_or_b32_e32 v68, v70, v65
	flat_store_b16 v[50:51], v68
.LBB16_24:                              ; %Flow194
                                        ;   in Loop: Header=BB16_19 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_add_co_u32 v47, s1, v47, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v48, null, 0, v48, s1
                                        ; implicit-def: $vgpr69
                                        ; implicit-def: $vgpr68
.LBB16_25:                              ; %Flow198
                                        ;   in Loop: Header=BB16_19 Depth=3
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s41, s2
	s_cbranch_execz .LBB16_18
; %bb.26:                               ;   in Loop: Header=BB16_19 Depth=3
	s_mov_b32 s42, exec_lo
	v_cmpx_ne_u32_e32 0, v67
	s_cbranch_execz .LBB16_17
; %bb.27:                               ;   in Loop: Header=BB16_19 Depth=3
	v_lshrrev_b64 v[70:71], 3, v[38:39]
	s_mov_b32 s43, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v70, s1, v56, v70
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v71, null, v57, v71, s1
	global_load_u8 v70, v[70:71], off
	v_and_b32_e32 v71, 7, v38
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v70, v71, v70
	v_and_b32_e32 v70, 1, v70
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v70
	s_cbranch_execz .LBB16_16
; %bb.28:                               ;   in Loop: Header=BB16_19 Depth=3
	v_lshrrev_b64 v[70:71], 3, v[45:46]
	s_mov_b32 s44, exec_lo
	flat_store_b16 v[50:51], v65
	v_add_co_u32 v70, s1, v58, v70
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v71, null, v59, v71, s1
	global_load_u8 v70, v[70:71], off
	v_and_b32_e32 v71, 7, v45
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v70, v71, v70
	v_and_b32_e32 v70, 1, v70
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v70
	s_cbranch_execz .LBB16_15
; %bb.29:                               ;   in Loop: Header=BB16_19 Depth=3
	v_ashrrev_i32_e32 v69, 5, v69
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_eq_u32_e64 s1, 1, v69
	v_cmp_eq_u32_e64 s2, 2, v69
	v_cmp_eq_u32_e64 s3, 3, v69
	v_cmp_eq_u32_e64 s4, 4, v69
	v_cmp_eq_u32_e64 s5, 5, v69
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v70, v0, v1, s1
	v_cmp_eq_u32_e64 s6, 6, v69
	v_cmp_eq_u32_e64 s7, 7, v69
	v_cmp_eq_u32_e64 s8, 8, v69
	v_cmp_eq_u32_e64 s9, 9, v69
	v_cndmask_b32_e64 v70, v70, v2, s2
	v_cmp_eq_u32_e64 s10, 10, v69
	v_cmp_eq_u32_e64 s11, 11, v69
	v_cmp_eq_u32_e64 s12, 12, v69
	v_cmp_eq_u32_e64 s13, 13, v69
	v_cndmask_b32_e64 v70, v70, v3, s3
	v_cmp_eq_u32_e64 s14, 14, v69
	v_cmp_eq_u32_e64 s15, 15, v69
	v_cmp_eq_u32_e64 s16, 16, v69
	v_cmp_eq_u32_e64 s17, 17, v69
	v_cndmask_b32_e64 v70, v70, v4, s4
	v_cmp_eq_u32_e64 s18, 18, v69
	v_cmp_eq_u32_e64 s19, 19, v69
	v_cmp_eq_u32_e64 s20, 20, v69
	v_cmp_eq_u32_e64 s21, 21, v69
	v_cndmask_b32_e64 v70, v70, v5, s5
	v_cmp_eq_u32_e64 s22, 22, v69
	v_cmp_eq_u32_e64 s23, 23, v69
	v_cmp_eq_u32_e64 s24, 24, v69
	v_cmp_eq_u32_e64 s25, 25, v69
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v70, v70, v6, s6
	v_cmp_eq_u32_e64 s26, 26, v69
	v_cmp_eq_u32_e64 s27, 27, v69
	v_cmp_eq_u32_e64 s28, 28, v69
	v_cmp_eq_u32_e64 s29, 29, v69
	v_cndmask_b32_e64 v70, v70, v7, s7
	v_cmp_eq_u32_e64 s30, 30, v69
	v_cmp_eq_u32_e64 s31, 31, v69
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v8, s8
	v_cndmask_b32_e64 v70, v70, v9, s9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v10, s10
	v_cndmask_b32_e64 v70, v70, v11, s11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v12, s12
	v_cndmask_b32_e64 v70, v70, v13, s13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v14, s14
	v_cndmask_b32_e64 v70, v70, v15, s15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v16, s16
	v_cndmask_b32_e64 v70, v70, v17, s17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v18, s18
	v_cndmask_b32_e64 v70, v70, v19, s19
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v20, s20
	v_cndmask_b32_e64 v70, v70, v21, s21
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v22, s22
	v_cndmask_b32_e64 v70, v70, v23, s23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v24, s24
	v_cndmask_b32_e64 v70, v70, v25, s25
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v26, s26
	v_cndmask_b32_e64 v70, v70, v27, s27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v28, s28
	v_cndmask_b32_e64 v70, v70, v29, s29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v70, v70, v30, s30
	v_cndmask_b32_e64 v70, v70, v31, s31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v68, 1, v68, v70
	v_cndmask_b32_e64 v1, v1, v68, s1
	v_cmp_eq_u32_e64 s1, 0, v69
	v_cndmask_b32_e64 v31, v31, v68, s31
	v_cndmask_b32_e64 v30, v30, v68, s30
	v_cndmask_b32_e64 v29, v29, v68, s29
	v_cndmask_b32_e64 v28, v28, v68, s28
	v_cndmask_b32_e64 v27, v27, v68, s27
	v_cndmask_b32_e64 v26, v26, v68, s26
	v_cndmask_b32_e64 v25, v25, v68, s25
	v_cndmask_b32_e64 v24, v24, v68, s24
	v_cndmask_b32_e64 v23, v23, v68, s23
	v_cndmask_b32_e64 v22, v22, v68, s22
	v_cndmask_b32_e64 v21, v21, v68, s21
	v_cndmask_b32_e64 v20, v20, v68, s20
	v_cndmask_b32_e64 v19, v19, v68, s19
	v_cndmask_b32_e64 v18, v18, v68, s18
	v_cndmask_b32_e64 v17, v17, v68, s17
	v_cndmask_b32_e64 v16, v16, v68, s16
	v_cndmask_b32_e64 v15, v15, v68, s15
	v_cndmask_b32_e64 v14, v14, v68, s14
	v_cndmask_b32_e64 v13, v13, v68, s13
	v_cndmask_b32_e64 v12, v12, v68, s12
	v_cndmask_b32_e64 v11, v11, v68, s11
	v_cndmask_b32_e64 v10, v10, v68, s10
	v_cndmask_b32_e64 v9, v9, v68, s9
	v_cndmask_b32_e64 v8, v8, v68, s8
	v_cndmask_b32_e64 v7, v7, v68, s7
	v_cndmask_b32_e64 v6, v6, v68, s6
	v_cndmask_b32_e64 v5, v5, v68, s5
	v_cndmask_b32_e64 v4, v4, v68, s4
	v_cndmask_b32_e64 v3, v3, v68, s3
	v_cndmask_b32_e64 v2, v2, v68, s2
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v0, v0, v68, s1
	s_branch .LBB16_15
.LBB16_30:                              ; %Flow203
	s_or_b32 exec_lo, exec_lo, s34
.LBB16_31:                              ; %Flow204
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s33
	v_cmp_lt_i32_e32 vcc_lo, 0, v35
	s_mov_b32 s2, 0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB16_39
; %bb.32:                               ; %.lr.ph161
	v_add_co_u32 v38, vcc_lo, v40, v43
	v_ashrrev_i32_e32 v37, 31, v42
	v_mov_b32_e32 v36, v42
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v39, null, v41, v44, vcc_lo
	v_add_co_u32 v32, vcc_lo, v38, v32
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_lshlrev_b64_e32 v[36:37], 1, v[36:37]
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v33, null, v39, v33, vcc_lo
	v_mov_b32_e32 v40, 0
	s_mov_b32 s3, 0
	v_cmp_lt_i32_e32 vcc_lo, 0, v34
	s_branch .LBB16_34
.LBB16_33:                              ; %Flow191
                                        ;   in Loop: Header=BB16_34 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	s_add_co_i32 s3, s3, 1
	v_add_co_u32 v32, s1, v32, v36
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s3, v35
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v33, null, v33, v37, s1
	v_add_nc_u32_e32 v40, v40, v53
	s_delay_alu instid0(VALU_DEP_3)
	s_or_b32 s2, s0, s2
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB16_39
.LBB16_34:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB16_37 Depth 2
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB16_33
; %bb.35:                               ; %.lr.ph156.preheader
                                        ;   in Loop: Header=BB16_34 Depth=1
	v_dual_mov_b32 v39, v33 :: v_dual_mov_b32 v38, v32
	s_mov_b32 s5, 0
	s_mov_b32 s6, 0
	s_branch .LBB16_37
.LBB16_36:                              ;   in Loop: Header=BB16_37 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s1
	s_add_co_i32 s6, s6, 1
	v_add_co_u32 v38, s1, v38, 2
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s6, v34
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v39, null, 0, v39, s1
	s_or_b32 s5, s0, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execz .LBB16_33
.LBB16_37:                              ; %.lr.ph156
                                        ;   Parent Loop BB16_34 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_wait_alu 0xfffe
	v_add_nc_u32_e32 v41, s6, v40
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v42, 5, v41
	v_cmp_eq_u32_e64 s0, 1, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v0, v1, s0
	v_cmp_eq_u32_e64 s0, 2, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v2, s0
	v_cmp_eq_u32_e64 s0, 3, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v3, s0
	v_cmp_eq_u32_e64 s0, 4, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v4, s0
	v_cmp_eq_u32_e64 s0, 5, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v5, s0
	v_cmp_eq_u32_e64 s0, 6, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v6, s0
	v_cmp_eq_u32_e64 s0, 7, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v7, s0
	v_cmp_eq_u32_e64 s0, 8, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v8, s0
	v_cmp_eq_u32_e64 s0, 9, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v9, s0
	v_cmp_eq_u32_e64 s0, 10, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v10, s0
	v_cmp_eq_u32_e64 s0, 11, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v11, s0
	v_cmp_eq_u32_e64 s0, 12, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v12, s0
	v_cmp_eq_u32_e64 s0, 13, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v13, s0
	v_cmp_eq_u32_e64 s0, 14, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v14, s0
	v_cmp_eq_u32_e64 s0, 15, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v15, s0
	v_cmp_eq_u32_e64 s0, 16, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v16, s0
	v_cmp_eq_u32_e64 s0, 17, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v17, s0
	v_cmp_eq_u32_e64 s0, 18, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v18, s0
	v_cmp_eq_u32_e64 s0, 19, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v19, s0
	v_cmp_eq_u32_e64 s0, 20, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v20, s0
	v_cmp_eq_u32_e64 s0, 21, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v21, s0
	v_cmp_eq_u32_e64 s0, 22, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v22, s0
	v_cmp_eq_u32_e64 s0, 23, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v23, s0
	v_cmp_eq_u32_e64 s0, 24, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v24, s0
	v_cmp_eq_u32_e64 s0, 25, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v25, s0
	v_cmp_eq_u32_e64 s0, 26, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v26, s0
	v_cmp_eq_u32_e64 s0, 27, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v27, s0
	v_cmp_eq_u32_e64 s0, 28, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v28, s0
	v_cmp_eq_u32_e64 s0, 29, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v43, v43, v29, s0
	v_cmp_eq_u32_e64 s0, 30, v42
	s_wait_alu 0xf1ff
	v_cndmask_b32_e64 v43, v43, v30, s0
	v_cmp_eq_u32_e64 s0, 31, v42
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e64 v42, v43, v31, s0
	v_lshrrev_b32_e32 v41, v41, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v41, 1, v41
	v_cmpx_eq_u32_e32 1, v41
	s_cbranch_execz .LBB16_36
; %bb.38:                               ;   in Loop: Header=BB16_37 Depth=2
	flat_load_u16 v41, v[38:39]
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v41, 0, v41
	flat_store_b16 v[38:39], v41
	s_branch .LBB16_36
.LBB16_39:                              ; %.loopexit
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z7k_desymILi1024EEvPKhPKjPK5bdesci
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 288
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 72
		.amdhsa_next_free_sgpr 45
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 27
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z7k_desymILi1024EEvPKhPKjPK5bdesci,"axG",@progbits,_Z7k_desymILi1024EEvPKhPKjPK5bdesci,comdat
.Lfunc_end16:
	.size	_Z7k_desymILi1024EEvPKhPKjPK5bdesci, .Lfunc_end16-_Z7k_desymILi1024EEvPKhPKjPK5bdesci
                                        ; -- End function
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.num_vgpr, 72
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.num_agpr, 0
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.numbered_sgpr, 45
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.num_named_barrier, 0
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.private_seg_size, 0
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.uses_vcc, 1
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.uses_flat_scratch, 0
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.has_dyn_sized_stack, 0
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.has_recursion, 0
	.set _Z7k_desymILi1024EEvPKhPKjPK5bdesci.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3424
; TotalNumSgprs: 47
; NumVgprs: 72
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 8
; NumSGPRsForWavesPerEU: 47
; NumVGPRsForWavesPerEU: 72
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.section	.text._Z7k_desymILi4096EEvPKhPKjPK5bdesci,"axG",@progbits,_Z7k_desymILi4096EEvPKhPKjPK5bdesci,comdat
	.protected	_Z7k_desymILi4096EEvPKhPKjPK5bdesci ; -- Begin function _Z7k_desymILi4096EEvPKhPKjPK5bdesci
	.globl	_Z7k_desymILi4096EEvPKhPKjPK5bdesci
	.p2align	8
	.type	_Z7k_desymILi4096EEvPKhPKjPK5bdesci,@function
_Z7k_desymILi4096EEvPKhPKjPK5bdesci:    ; @_Z7k_desymILi4096EEvPKhPKjPK5bdesci
; %bb.0:
	s_clause 0x1
	s_load_b32 s2, s[0:1], 0x2c
	s_load_b32 s3, s[0:1], 0x18
	s_wait_kmcnt 0x0
	s_and_b32 s2, s2, 0xffff
	s_delay_alu instid0(SALU_CYCLE_1)
	v_mad_co_u64_u32 v[0:1], null, ttmp9, s2, v[0:1]
	s_mov_b32 s2, exec_lo
	v_cmpx_gt_i32_e64 s3, v0
	s_cbranch_execz .LBB17_37
; %bb.1:
	s_clause 0x1
	s_load_b64 s[4:5], s[0:1], 0x10
	s_load_b128 s[0:3], s[0:1], 0x0
	v_lshlrev_b32_e32 v4, 2, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshlrev_b64_e32 v[4:5], 2, v[4:5]
	s_wait_kmcnt 0x0
	v_mad_co_i64_i32 v[6:7], null, v0, 40, s[4:5]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v4, vcc_lo, s2, v4
	v_add_co_ci_u32_e64 v5, null, s3, v5, vcc_lo
	s_mov_b32 s3, 0
	s_mov_b32 s2, exec_lo
	s_clause 0x2
	global_load_b128 v[0:3], v[6:7], off
	global_load_b32 v20, v[6:7], off offset:16
	global_load_b96 v[8:10], v[6:7], off offset:24
	global_load_b128 v[4:7], v[4:5], off
	s_wait_loadcnt 0x3
	v_mul_lo_u32 v11, v3, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_lt_i32_e32 0, v11
	s_cbranch_execz .LBB17_4
; %bb.2:                                ; %.lr.ph.preheader
	v_dual_mov_b32 v12, 0 :: v_dual_add_nc_u32 v11, 31, v11
	s_mov_b32 s4, 0
	s_delay_alu instid0(VALU_DEP_1)
	v_lshrrev_b32_e32 v11, 5, v11
.LBB17_3:                               ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(VALU_DEP_1)
	v_add_nc_u32_e32 v11, -1, v11
	scratch_store_b32 off, v12, s4
	s_wait_alu 0xfffe
	s_add_co_i32 s4, s4, 4
	v_cmp_eq_u32_e32 vcc_lo, 0, v11
	s_or_b32 s3, vcc_lo, s3
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s3
	s_cbranch_execnz .LBB17_3
.LBB17_4:                               ; %Flow190
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	s_wait_loadcnt 0x1
	v_mul_lo_u32 v11, v10, v1
	v_ashrrev_i32_e32 v1, 31, v0
	s_mov_b32 s4, 0
	s_mov_b32 s3, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
	v_ashrrev_i32_e32 v12, 31, v11
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b64_e32 v[11:12], 1, v[11:12]
	v_cmpx_lt_i32_e32 0, v20
	s_cbranch_execz .LBB17_29
; %bb.5:                                ; %.preheader100.lr.ph
	s_wait_loadcnt 0x0
	v_add_co_u32 v21, s2, s0, v4
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v22, null, s1, 0, s2
	v_add_co_u32 v23, s2, s0, v5
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v24, null, s1, 0, s2
	v_add_co_u32 v25, s2, s0, v6
	v_add_co_u32 v27, s0, s0, v7
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v26, null, s1, 0, s2
	v_add_co_ci_u32_e64 v28, null, s1, 0, s0
	v_add_co_u32 v17, s1, v0, v11
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v18, null, v1, v12, s1
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v13, 0
	s_delay_alu instid0(VALU_DEP_3)
	v_add_co_u32 v29, s1, v8, v17
	v_dual_mov_b32 v5, 0 :: v_dual_mov_b32 v6, 0
	v_dual_mov_b32 v14, 0 :: v_dual_mov_b32 v15, 0
	v_cmp_lt_i32_e64 s0, 0, v2
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v16, 0
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v30, null, v9, v18, s1
	v_cmp_lt_i32_e32 vcc_lo, 0, v3
	s_branch .LBB17_8
.LBB17_6:                               ; %Flow185
                                        ;   in Loop: Header=BB17_8 Depth=1
	s_or_b32 exec_lo, exec_lo, s6
.LBB17_7:                               ; %Flow186
                                        ;   in Loop: Header=BB17_8 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s5
	v_cmp_gt_i32_e64 s1, 2, v20
	v_mov_b32_e32 v20, v31
	s_or_b32 s4, s1, s4
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execz .LBB17_29
.LBB17_8:                               ; %.preheader100
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB17_12 Depth 2
                                        ;       Child Loop BB17_18 Depth 3
	v_add_nc_u32_e32 v31, -1, v20
	s_and_saveexec_b32 s5, vcc_lo
	s_cbranch_execz .LBB17_7
; %bb.9:                                ; %.lr.ph125
                                        ;   in Loop: Header=BB17_8 Depth=1
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e64 v32, v31, 1
	v_dual_mov_b32 v17, 0 :: v_dual_mov_b32 v34, 0
	v_mov_b32_e32 v33, 0
	s_mov_b32 s6, 0
	s_mov_b32 s7, 0
	s_branch .LBB17_12
.LBB17_10:                              ; %Flow183
                                        ;   in Loop: Header=BB17_12 Depth=2
	s_or_b32 exec_lo, exec_lo, s9
.LBB17_11:                              ; %Flow184
                                        ;   in Loop: Header=BB17_12 Depth=2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_wait_alu 0xfffe
	s_add_co_i32 s7, s7, 1
	v_add_nc_u32_e32 v17, v17, v10
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s1, s7, v3
	s_or_b32 s6, s1, s6
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB17_6
.LBB17_12:                              ;   Parent Loop BB17_8 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB17_18 Depth 3
	s_and_saveexec_b32 s8, s0
	s_cbranch_execz .LBB17_11
; %bb.13:                               ; %.lr.ph112.preheader
                                        ;   in Loop: Header=BB17_12 Depth=2
	v_ashrrev_i32_e32 v18, 31, v17
	v_mov_b32_e32 v35, v2
	s_mov_b32 s9, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64_e32 v[18:19], 1, v[17:18]
	v_add_co_u32 v18, s1, v29, v18
	s_wait_alu 0xf1ff
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e64 v19, null, v30, v19, s1
	s_branch .LBB17_18
.LBB17_14:                              ; %Flow179
                                        ;   in Loop: Header=BB17_18 Depth=3
	s_or_b32 exec_lo, exec_lo, s12
	v_add_co_u32 v13, s1, v13, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v14, null, 0, v14, s1
.LBB17_15:                              ; %Flow180
                                        ;   in Loop: Header=BB17_18 Depth=3
	s_or_b32 exec_lo, exec_lo, s11
	v_add_co_u32 v6, s1, v6, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v7, null, 0, v7, s1
.LBB17_16:                              ; %Flow181
                                        ;   in Loop: Header=BB17_18 Depth=3
	s_or_b32 exec_lo, exec_lo, s10
.LBB17_17:                              ;   in Loop: Header=BB17_18 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	v_add_nc_u32_e32 v35, -1, v35
	v_add_co_u32 v18, s2, v18, 2
	v_add_nc_u32_e32 v33, 1, v33
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v19, null, 0, v19, s2
	v_cmp_eq_u32_e64 s1, 0, v35
	s_or_b32 s9, s1, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s9
	s_cbranch_execz .LBB17_10
.LBB17_18:                              ; %.lr.ph112
                                        ;   Parent Loop BB17_8 Depth=1
                                        ;     Parent Loop BB17_12 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	v_and_b32_e32 v36, 31, v33
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 0, v36
	s_cbranch_execz .LBB17_20
; %bb.19:                               ;   in Loop: Header=BB17_18 Depth=3
	v_lshrrev_b64 v[37:38], 3, v[4:5]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v37, s1, v21, v37
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v38, null, v22, v38, s1
	global_load_u8 v34, v[37:38], off
	v_and_b32_e32 v37, 7, v4
	v_add_co_u32 v4, s1, v4, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v5, null, 0, v5, s1
	s_wait_loadcnt 0x0
	v_bfe_u32 v34, v34, v37, 1
.LBB17_20:                              ;   in Loop: Header=BB17_18 Depth=3
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s2
	flat_load_u16 v37, v[18:19]
	s_mov_b32 s2, exec_lo
	s_wait_loadcnt_dscnt 0x0
	v_bfe_i32 v38, v37, 0, 16
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v38, v20, v38
	v_cmpx_ne_u32_e32 0, v38
	s_wait_alu 0xfffe
	s_xor_b32 s2, exec_lo, s2
	s_cbranch_execz .LBB17_24
; %bb.21:                               ;   in Loop: Header=BB17_18 Depth=3
	v_lshrrev_b64 v[38:39], 3, v[15:16]
	s_mov_b32 s10, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v38, s1, v27, v38
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v39, null, v28, v39, s1
	global_load_u8 v36, v[38:39], off
	v_and_b32_e32 v38, 7, v15
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v36, v38, v36
	v_and_b32_e32 v36, 1, v36
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v36
	s_cbranch_execz .LBB17_23
; %bb.22:                               ;   in Loop: Header=BB17_18 Depth=3
	v_or_b32_e32 v36, v37, v32
	flat_store_b16 v[18:19], v36
.LBB17_23:                              ; %Flow178
                                        ;   in Loop: Header=BB17_18 Depth=3
	s_or_b32 exec_lo, exec_lo, s10
	v_add_co_u32 v15, s1, v15, 1
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v16, null, 0, v16, s1
                                        ; implicit-def: $vgpr36
.LBB17_24:                              ; %Flow182
                                        ;   in Loop: Header=BB17_18 Depth=3
	s_wait_alu 0xfffe
	s_and_not1_saveexec_b32 s2, s2
	s_cbranch_execz .LBB17_17
; %bb.25:                               ;   in Loop: Header=BB17_18 Depth=3
	s_mov_b32 s10, exec_lo
	v_cmpx_ne_u32_e32 0, v34
	s_cbranch_execz .LBB17_16
; %bb.26:                               ;   in Loop: Header=BB17_18 Depth=3
	v_lshrrev_b64 v[37:38], 3, v[6:7]
	s_mov_b32 s11, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_co_u32 v37, s1, v23, v37
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v38, null, v24, v38, s1
	global_load_u8 v37, v[37:38], off
	v_and_b32_e32 v38, 7, v6
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v37, v38, v37
	v_and_b32_e32 v37, 1, v37
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v37
	s_cbranch_execz .LBB17_15
; %bb.27:                               ;   in Loop: Header=BB17_18 Depth=3
	v_lshrrev_b64 v[37:38], 3, v[13:14]
	s_mov_b32 s12, exec_lo
	flat_store_b16 v[18:19], v32
	v_add_co_u32 v37, s1, v25, v37
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v38, null, v26, v38, s1
	global_load_u8 v37, v[37:38], off
	v_and_b32_e32 v38, 7, v13
	s_wait_loadcnt 0x0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v37, v38, v37
	v_and_b32_e32 v37, 1, v37
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 1, v37
	s_cbranch_execz .LBB17_14
; %bb.28:                               ;   in Loop: Header=BB17_18 Depth=3
	v_ashrrev_i32_e32 v37, 5, v33
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v37, 2, v37
	scratch_load_b32 v38, v37, off
	s_wait_loadcnt 0x0
	v_lshl_or_b32 v36, 1, v36, v38
	scratch_store_b32 v37, v36, off
	s_branch .LBB17_14
.LBB17_29:                              ; %Flow188
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s3
	v_cmp_lt_i32_e32 vcc_lo, 0, v3
	s_mov_b32 s2, 0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB17_37
; %bb.30:                               ; %.lr.ph145
	s_wait_loadcnt 0x0
	v_add_co_u32 v6, vcc_lo, v8, v11
	v_ashrrev_i32_e32 v5, 31, v10
	v_mov_b32_e32 v4, v10
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v7, null, v9, v12, vcc_lo
	v_add_co_u32 v0, vcc_lo, v6, v0
	v_mov_b32_e32 v9, 0
	v_lshlrev_b64_e32 v[4:5], 1, v[4:5]
	s_wait_alu 0xfffd
	v_add_co_ci_u32_e64 v1, null, v7, v1, vcc_lo
	v_max_i32_e32 v8, 0, v2
	s_mov_b32 s3, 0
	v_cmp_lt_i32_e32 vcc_lo, 0, v2
	s_branch .LBB17_32
.LBB17_31:                              ; %Flow175
                                        ;   in Loop: Header=BB17_32 Depth=1
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s4
	s_add_co_i32 s3, s3, 1
	v_add_co_u32 v0, s1, v0, v4
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s3, v3
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v1, null, v1, v5, s1
	v_add_nc_u32_e32 v9, v9, v8
	s_delay_alu instid0(VALU_DEP_3)
	s_or_b32 s2, s0, s2
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB17_37
.LBB17_32:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB17_35 Depth 2
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB17_31
; %bb.33:                               ; %.lr.ph140.preheader
                                        ;   in Loop: Header=BB17_32 Depth=1
	v_dual_mov_b32 v7, v1 :: v_dual_mov_b32 v6, v0
	s_mov_b32 s5, 0
	s_mov_b32 s6, 0
	s_branch .LBB17_35
.LBB17_34:                              ;   in Loop: Header=BB17_35 Depth=2
	s_wait_alu 0xfffe
	s_or_b32 exec_lo, exec_lo, s1
	s_add_co_i32 s6, s6, 1
	v_add_co_u32 v6, s1, v6, 2
	s_wait_alu 0xfffe
	v_cmp_eq_u32_e64 s0, s6, v2
	s_wait_alu 0xf1ff
	v_add_co_ci_u32_e64 v7, null, 0, v7, s1
	s_or_b32 s5, s0, s5
	s_wait_alu 0xfffe
	s_and_not1_b32 exec_lo, exec_lo, s5
	s_cbranch_execz .LBB17_31
.LBB17_35:                              ; %.lr.ph140
                                        ;   Parent Loop BB17_32 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	s_wait_alu 0xfffe
	v_add_nc_u32_e32 v10, s6, v9
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 5, v10
	v_lshlrev_b32_e32 v11, 2, v11
	scratch_load_b32 v11, v11, off
	s_wait_loadcnt 0x0
	v_lshrrev_b32_e32 v10, v10, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v10, 1, v10
	v_cmpx_eq_u32_e32 1, v10
	s_cbranch_execz .LBB17_34
; %bb.36:                               ;   in Loop: Header=BB17_35 Depth=2
	flat_load_u16 v10, v[6:7]
	s_wait_loadcnt_dscnt 0x0
	v_sub_nc_u16 v10, 0, v10
	flat_store_b16 v[6:7], v10
	s_branch .LBB17_34
.LBB17_37:
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z7k_desymILi4096EEvPKhPKjPK5bdesci
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 528
		.amdhsa_kernarg_size 288
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 40
		.amdhsa_next_free_sgpr 13
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_inst_pref_size 14
		.amdhsa_round_robin_scheduling 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z7k_desymILi4096EEvPKhPKjPK5bdesci,"axG",@progbits,_Z7k_desymILi4096EEvPKhPKjPK5bdesci,comdat
.Lfunc_end17:
	.size	_Z7k_desymILi4096EEvPKhPKjPK5bdesci, .Lfunc_end17-_Z7k_desymILi4096EEvPKhPKjPK5bdesci
                                        ; -- End function
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.num_vgpr, 40
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.num_agpr, 0
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.numbered_sgpr, 13
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.num_named_barrier, 0
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.private_seg_size, 528
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.uses_vcc, 1
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.uses_flat_scratch, 0
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.has_dyn_sized_stack, 0
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.has_recursion, 0
	.set _Z7k_desymILi4096EEvPKhPKjPK5bdesci.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1704
; TotalNumSgprs: 15
; NumVgprs: 40
; ScratchSize: 528
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 15
; NumVGPRsForWavesPerEU: 40
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 1
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.section	.AMDGPU.gpr_maximums,"",@progbits
	.set amdgpu.max_num_vgpr, 0
	.set amdgpu.max_num_agpr, 0
	.set amdgpu.max_num_sgpr, 0
	.text
	.type	__hip_cuid_e23f35c6d5c11c4b,@object ; @__hip_cuid_e23f35c6d5c11c4b
	.section	.bss,"aw",@nobits
	.globl	__hip_cuid_e23f35c6d5c11c4b
__hip_cuid_e23f35c6d5c11c4b:
	.byte	0                               ; 0x0
	.size	__hip_cuid_e23f35c6d5c11c4b, 1

	.ident	"AMD clang version 22.0.0git (/startdir/rocm-llvm f58b06dce1f9c15707c5f808fd002e18c2accf7e)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __hip_cuid_e23f35c6d5c11c4b
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .offset:         8
        .size:           4
        .value_kind:     by_value
      - .offset:         12
        .size:           4
        .value_kind:     by_value
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         36
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         40
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         44
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         46
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         48
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         50
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         52
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         54
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         96
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 288
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z12k_quant_rectPsiiiiii
    .private_segment_fixed_size: 0
    .sgpr_count:     12
    .sgpr_spill_count: 0
    .symbol:         _Z12k_quant_rectPsiiiiii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     4
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           384
        .value_kind:     by_value
      - .offset:         416
        .size:           4
        .value_kind:     by_value
      - .offset:         420
        .size:           4
        .value_kind:     by_value
      - .offset:         424
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         428
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         432
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         436
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         438
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         440
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         442
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         444
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         446
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         464
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         472
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         480
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         488
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 680
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z15k_dwt_fwd_splitPKsPsiiii3sprii
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z15k_dwt_fwd_splitPKsPsiiii3sprii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     15
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           384
        .value_kind:     by_value
      - .offset:         416
        .size:           4
        .value_kind:     by_value
      - .offset:         420
        .size:           4
        .value_kind:     by_value
      - .offset:         424
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         428
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         432
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         436
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         438
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         440
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         442
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         444
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         446
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         464
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         472
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         480
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         488
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 680
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z15k_dwt_inv_splitPKsPsiiii3sprii
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z15k_dwt_inv_splitPKsPsiiii3sprii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     15
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         40
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         48
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         56
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         64
        .size:           8
        .value_kind:     global_buffer
      - .offset:         72
        .size:           4
        .value_kind:     by_value
      - .offset:         80
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         84
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         88
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         92
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         94
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         96
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         98
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         100
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         102
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         120
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         128
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         136
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         144
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 336
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z5k_encPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     19
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         40
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         48
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         56
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         64
        .size:           8
        .value_kind:     global_buffer
      - .offset:         72
        .size:           4
        .value_kind:     by_value
      - .offset:         80
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         84
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         88
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         92
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         94
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         96
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         98
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         100
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         102
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         120
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         128
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         136
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         144
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 336
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z9k_enc_rcpPK6gtab_tPKhPKjS5_PKtS5_S5_PhPji.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     18
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         40
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         48
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         56
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         64
        .size:           8
        .value_kind:     global_buffer
      - .offset:         72
        .size:           4
        .value_kind:     by_value
      - .offset:         80
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         84
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         88
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         92
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         94
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         96
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         98
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         100
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         102
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         120
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         128
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         136
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         144
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 336
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii
    .private_segment_fixed_size: 0
    .sgpr_count:     16
    .sgpr_spill_count: 0
    .symbol:         _Z5k_decPKhPKjS2_PKtPhS2_S2_PK6dtab_tPii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     20
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
      - .offset:         48
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         52
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         60
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         62
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         64
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         66
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         68
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         70
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         112
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 304
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z5k_symPK5sdescPKjPhS3_Pjii
    .private_segment_fixed_size: 0
    .sgpr_count:     31
    .sgpr_spill_count: 0
    .symbol:         _Z5k_symPK5sdescPKjPhS3_Pjii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     31
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .offset:         16
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 20
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z9k_offsetsPKjPji
    .private_segment_fixed_size: 0
    .sgpr_count:     10
    .sgpr_spill_count: 0
    .symbol:         _Z9k_offsetsPKjPji.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     2
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         40
        .size:           8
        .value_kind:     global_buffer
      - .offset:         48
        .size:           4
        .value_kind:     by_value
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         60
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         64
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         68
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         70
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         72
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         74
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         76
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         78
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         112
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         120
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 312
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z6k_packPKhPKjS2_PhS2_Pji
    .private_segment_fixed_size: 0
    .sgpr_count:     10
    .sgpr_spill_count: 0
    .symbol:         _Z6k_packPKhPKjS2_PhS2_Pji.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     9
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         48
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         52
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         60
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         62
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         64
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         66
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         68
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         70
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         112
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 304
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z6k_histPKhPKjS2_PKtPii
    .private_segment_fixed_size: 272
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z6k_histPKhPKjS2_PKtPii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     9
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
      - .offset:         24
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         28
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         36
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         38
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         40
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         42
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         44
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         46
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         64
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         88
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 280
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z6k_poolPKiPiii
    .private_segment_fixed_size: 0
    .sgpr_count:     12
    .sgpr_spill_count: 0
    .symbol:         _Z6k_poolPKiPiii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     39
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  write_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         44
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         48
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         52
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         54
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         56
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         58
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         60
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         62
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         104
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 296
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z6k_normPKiS0_Ptiii
    .private_segment_fixed_size: 272
    .sgpr_count:     13
    .sgpr_spill_count: 0
    .symbol:         _Z6k_normPKiS0_Ptiii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     91
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         48
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         52
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         60
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         62
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         64
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         66
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         68
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         70
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         112
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 304
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z8k_unpackPKhPKjS2_PhS2_i
    .private_segment_fixed_size: 0
    .sgpr_count:     10
    .sgpr_spill_count: 0
    .symbol:         _Z8k_unpackPKhPKjS2_PhS2_i.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     14
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .offset:         8
        .size:           4
        .value_kind:     by_value
      - .offset:         16
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         20
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         24
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         28
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         30
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         32
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         34
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         36
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         38
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         56
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         64
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         80
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 272
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z10k_block_mbP5bdesci
    .private_segment_fixed_size: 0
    .sgpr_count:     9
    .sgpr_spill_count: 0
    .symbol:         _Z10k_block_mbP5bdesci.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     14
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .offset:         8
        .size:           4
        .value_kind:     by_value
      - .actual_access:  write_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         28
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         36
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         38
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         40
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         42
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         44
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         46
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         64
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         88
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 280
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z7k_newlyPK5bdesciPj
    .private_segment_fixed_size: 0
    .sgpr_count:     13
    .sgpr_spill_count: 0
    .symbol:         _Z7k_newlyPK5bdesciPj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     20
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         36
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         40
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         44
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         46
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         48
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         50
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         52
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         54
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         96
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 288
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z9k_desym_wPKhPKjPK5bdesci
    .private_segment_fixed_size: 0
    .sgpr_count:     21
    .sgpr_spill_count: 0
    .symbol:         _Z9k_desym_wPKhPKjPK5bdesci.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     55
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         36
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         40
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         44
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         46
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         48
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         50
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         52
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         54
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         96
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 288
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z7k_desymILi1024EEvPKhPKjPK5bdesci
    .private_segment_fixed_size: 0
    .sgpr_count:     47
    .sgpr_spill_count: 0
    .symbol:         _Z7k_desymILi1024EEvPKhPKjPK5bdesci.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     72
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .actual_access:  read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .actual_access:  read_only
        .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         36
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         40
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         44
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         46
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         48
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         50
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         52
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         54
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         96
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 288
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z7k_desymILi4096EEvPKhPKjPK5bdesci
    .private_segment_fixed_size: 528
    .sgpr_count:     15
    .sgpr_spill_count: 0
    .symbol:         _Z7k_desymILi4096EEvPKhPKjPK5bdesci.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     40
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1201
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
