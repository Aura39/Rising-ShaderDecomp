float4 g_Gravity;
float4 g_Param;
float4x4 g_RotMatrix;
float4x4 g_WorldViewProjMatrix;
float4 g_ofs_pos;
float4 g_r_spd;
float4 g_spd;
float4 g_z_rot_param;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float3 r4;
	r0.xy = i.texcoord1.zw * 6.28;
	r1.x = g_Param.x;
	r0.xy = r1.xx * g_r_spd.ww + r0.xy;
	r0.xy = r0.xy * 0.15915494 + 0.5;
	r0.xy = frac(r0.xy);
	r0.xy = r0.xy * 6.2831855 + -3.1415927;
	sincos(r0.x, r2.y, r2.y);
	sincos(r0.y, r3.y, r3.y);
	r0.x = i.position.w * 3.14;
	r0.x = r2.y * g_r_spd.z + r0.x;
	r0.x = r0.x * 0.15915494 + 0.5;
	r0.x = frac(r0.x);
	r0.x = r0.x * 6.2831855 + -3.1415927;
	sincos(r0.xx, r2.xy, r2.xy);
	r0.xzw = float3(-1, -1, 0);
	r0.x = r0.x + g_spd.y;
	r0.x = (r0.x == 0) ? 1 : 0;
	r0.y = abs(g_spd.y);
	r1.y = i.texcoord.w * i.texcoord.w;
	r1.y = r1.y * i.texcoord.w;
	r1.x = r1.y * -g_spd.x + r1.x;
	r1.x = max(r1.x, 0);
	r2.z = pow(r0.y, r1.x);
	r0.y = -r2.z + 1;
	r1.y = r0.w + -g_spd.y;
	r1.y = 1 / r1.y;
	r1.z = r0.y * -r1.y + r1.x;
	r0.y = r0.y * r1.y;
	r0.x = r0.x * r1.z + r0.y;
	r0.y = g_ofs_pos.y * i.position.z + g_ofs_pos.x;
	r1.y = g_r_spd.y * i.texcoord2.x + g_r_spd.x;
	r0.x = r1.y * r0.x + r0.y;
	r1.yz = r2.yx * r0.xx;
	r0.y = i.texcoord2.y * 6.28;
	r0.y = r3.y * g_r_spd.z + r0.y;
	r0.y = r0.y * 0.15915494 + 0.5;
	r0.y = frac(r0.y);
	r0.y = r0.y * 6.2831855 + -3.1415927;
	sincos(r0.yy, r2.xy, r2.xy);
	r0.y = r1.x * r1.x;
	r1.x = (r1.x >= 0.001) ? 1 : 0;
	r3.xyz = r0.yyy * g_Gravity.xyz;
	r4.xz = r1.yz * r2.xx + r3.xz;
	r4.y = r0.x * r2.y + r3.y;
	r0.xyz = (r0.zzz >= g_spd.wzw) ? 1 : 0;
	r1.yzw = (0 >= i.texcoord.yxy) ? 1 : 0;
	r1.yzw = r1.yzw * 2 + -1;
	r2.xyz = -r1.wzw + 1;
	r0.xyz = r0.xyz * r2.xyz + r1.yzw;
	r1.y = i.texcoord2.z * i.texcoord2.z;
	r0.w = g_ofs_pos.w * -r1.y + r0.w;
	r0.xyz = r0.xyz * r0.www;
	r0.xyz = r0.xyz * g_Param.wzw;
	r0.w = frac(i.texcoord2.w);
	r1.y = -r0.w + i.texcoord2.w;
	r0.w = r0.w * 4;
	color.x = r1.y;
	r0.xyz = r0.xyz * -1;
	r0.xyz = r1.xxx * r0.xyz;
	r1.x = g_z_rot_param.z * i.position.w + g_z_rot_param.y;
	r1.x = r1.x * g_Param.x;
	r1.y = g_z_rot_param.x * i.texcoord.z;
	r1.x = r1.x * 6.28 + r1.y;
	r1.x = r1.x * 0.15915494 + 0.5;
	r1.x = frac(r1.x);
	r1.x = r1.x * 6.2831855 + -3.1415927;
	sincos(r1.xx, r2.xy, r2.xy);
	r1.xyz = r0.xyz * r2.yyx;
	r2.x = r0.y * -r2.x + r1.x;
	r2.y = r1.z + r1.y;
	r2.zw = 0;
	r0.x = dot(r2.xyww, transpose(g_RotMatrix)[0]);
	r0.y = dot(r2.xyww, transpose(g_RotMatrix)[1]);
	r0.z = dot(r2, transpose(g_RotMatrix)[2]);
	r1.xyz = r0.xyz + r4.xyz;
	r1.w = 1;
	o.position.x = dot(r1, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r1, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r1, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r1, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = frac(r0.w);
	r0.x = -r0.x + r0.w;
	r0.z = 0;
	o.texcoord.x = r0.x * 0.25 + r0.z;
	o.texcoord.y = 1;

	return o;
}
