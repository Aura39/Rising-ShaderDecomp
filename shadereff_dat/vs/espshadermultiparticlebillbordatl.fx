float4 g_Param : register(c185);
float4x4 g_RotMatrix : register(c40);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_alpha_param : register(c190);
float4 g_ofs_pos : register(c187);
float4 g_r_spd : register(c189);
float4 g_sin_dist_param : register(c192);
float4 g_sin_time_param : register(c44);
float4 g_spd : register(c188);
float4 g_z_rot_param : register(c191);

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
	float4 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.xyz = g_r_spd.xyz;
	r0.xyz = r0.xyz * i.texcoord.xyz + g_spd.xyz;
	r1.x = g_Param.x;
	r1.xyz = r1.xxx * g_sin_time_param.xyz + i.texcoord2.xyz;
	r1.xyz = r1.xyz * 0.99949306 + 0.5;
	r1.xyz = frac(r1.xyz);
	r1.xyz = r1.xyz * 6.2831855 + -3.1415927;
	sincos(r1.x, r2.y, r2.y);
	r2.xzw = g_ofs_pos.xyz + i.texcoord1.xyz;
	r3.x = r2.y * g_sin_dist_param.x + r2.x;
	sincos(r1.y, r4.y, r4.y);
	sincos(r1.z, r5.y, r5.y);
	r3.z = r5.y * g_sin_dist_param.z + r2.w;
	r3.y = r4.y * g_sin_dist_param.y + r2.z;
	r0.xyz = r0.xyz * g_Param.xxx + r3.xyz;
	r0.w = g_z_rot_param.z * i.texcoord.w + g_z_rot_param.y;
	r0.w = r0.w * g_Param.x;
	r1.x = g_z_rot_param.x * i.position.w;
	r0.w = r0.w * 6.28 + r1.x;
	r0.w = r0.w * 0.15915494 + 0.5;
	r0 = frac(r0);
	r0.w = r0.w * 6.2831855 + -3.1415927;
	sincos(r0.ww, r1.xy, r1.xy);
	r1.zw = -1;
	r0.w = (r1.z >= g_alpha_param.w) ? 1 : 0;
	r2.xy = (0 >= i.texcoord.xy) ? 1 : 0;
	r2.xy = r2.xy * 2 + -1;
	r3.x = lerp(1, r2.x, r0.w);
	r0.w = g_ofs_pos.w * i.texcoord.z + r1.w;
	r3.y = r3.x * r0.w;
	r1.z = (r1.z >= g_z_rot_param.w) ? 1 : 0;
	r3.w = lerp(1, r2.y, r1.z);
	r3.xz = r0.ww * r3.ww;
	r2.xyz = r3.xyz * g_Param.wzw;
	r0.w = frac(i.texcoord2.w);
	r1.z = -r0.w + i.texcoord2.w;
	r0.w = r0.w * 4;
	color.x = r1.z;
	r2.xyz = r2.xyz * -1;
	r1.yzw = r1.yyx * r2.xyz;
	r2.x = r2.y * -r1.x + r1.y;
	r2.y = r1.w + r1.z;
	r2.zw = 0;
	r1.x = dot(r2.xyww, transpose(g_RotMatrix)[0]);
	r1.y = dot(r2.xyww, transpose(g_RotMatrix)[1]);
	r1.z = dot(r2, transpose(g_RotMatrix)[2]);
	r1.xyz = r0.xyz + r1.xyz;
	r1.w = 1;
	o.position.x = dot(r1, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r1, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r1, transpose(g_WorldViewProjMatrix)[2]);
	r1.x = dot(r1, transpose(g_WorldViewProjMatrix)[3]);
	r1.yzw = r0.xyz + -1;
	r2.x = 1 / g_alpha_param.x;
	r1.yzw = -r1.yzw * r2.xxx;
	r0.xyz = r0.xyz * r2.xxx;
	r1.y = min(r1.z, r1.y);
	r1.y = min(r1.w, r1.y);
	r0.x = min(r0.y, r0.x);
	r0.x = min(r0.z, r0.x);
	r0.x = r1.y * r0.x;
	r0.y = r1.x + -g_alpha_param.y;
	o.position.w = r1.x;
	r0.z = 1 / g_alpha_param.z;
	r0.y = r0.z * r0.y;
	o.texcoord1.w = r0.y * r0.x;
	r0.x = frac(r0.w);
	r0.x = -r0.x + r0.w;
	r0.z = 0;
	o.texcoord.x = r0.x * 0.25 + r0.z;
	o.texcoord.y = 1;
	o.texcoord1.xyz = 1;

	return o;
}
