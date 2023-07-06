float4 g_GravVec;
float4 g_Param;
float4x4 g_RotMatrix;
float4x4 g_WorldViewProjMatrix;
float4 g_alpha_param;
float4 g_r_pos;
float4 g_r_spd;
float4 g_spd;
float4 g_z_rot_param;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
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
	r0.zw = float2(0.5, -0.5);
	r0.x = -r0.w + g_r_spd.w;
	r0.x = (r0.x == 0) ? 1 : 0;
	r0.y = r0.w + -g_r_spd.w;
	r0.y = 1 / r0.y;
	r1.x = abs(g_r_spd.w);
	r1.yz = i.texcoord2.xy * i.texcoord2.xy;
	r1.y = r1.y * i.texcoord2.x;
	r1.z = g_Param.y * -r1.z + r0.w;
	r2.x = g_Param.x;
	r1.y = r1.y * -g_alpha_param.z + r2.x;
	r1.y = max(r1.y, 0);
	r2.x = pow(r1.x, r1.y);
	r1.x = -r2.x + 1;
	r1.w = r1.x * -r0.y + r1.y;
	r0.y = r0.y * r1.x;
	r0.x = r0.x * r1.w + r0.y;
	r2.xyz = g_r_spd.xyz;
	r2.xyz = r2.xyz * i.texcoord.xyz + g_spd.xyz;
	r2.xyz = r0.xxx * r2.xyz;
	r2.xyz = i.position.xyz * g_r_pos.xyz + r2.xyz;
	r0.x = r1.y * r1.y;
	r0.y = (r1.y >= 0.001) ? 1 : 0;
	r1.xyw = r0.xxx * g_GravVec.xyz + r2.xyz;
	r0.x = (r0.z >= g_r_pos.w) ? 1 : 0;
	r2.xy = (0 >= i.texcoord.xy) ? 1 : 0;
	r2.xy = r2.xy * 2 + -1;
	r3.x = lerp(1, r2.x, r0.x);
	r3.y = r1.z * r3.x;
	r0.x = (r0.z >= g_z_rot_param.w) ? 1 : 0;
	r3.w = lerp(1, r2.y, r0.x);
	r3.xz = r1.zz * r3.ww;
	r2.xyz = r3.xyz * g_Param.wzw;
	r0.x = frac(i.texcoord2.w);
	r0.z = -r0.x + i.texcoord2.w;
	r0.x = r0.x * 4;
	color.x = r0.z;
	r2.xyz = r2.xyz * float3(-0.5, 0.5, -0.5);
	r2.xyz = r0.yyy * r2.xyz;
	r0.y = g_z_rot_param.z * i.position.w + g_z_rot_param.y;
	r0.y = r0.y * g_Param.x;
	r0.z = g_z_rot_param.x * i.texcoord.w;
	r0.y = r0.y * 6.28 + r0.z;
	r0.y = r0.y * 0.15915494 + 0.5;
	r0.y = frac(r0.y);
	r0.y = r0.y * 6.2831855 + -3.1415927;
	sincos(r0.yy, r3.xy, r3.xy);
	r2.xzw = r2.xyz * r3.yyx;
	r3.x = r2.y * -r3.x + r2.x;
	r3.y = r2.w + r2.z;
	r3.zw = 0;
	r2.x = dot(r3.xyww, transpose(g_RotMatrix)[0]);
	r2.y = dot(r3.xyww, transpose(g_RotMatrix)[1]);
	r2.z = dot(r3, transpose(g_RotMatrix)[2]);
	r1.xyz = r1.xyw + r2.xyz;
	r1.w = 1;
	o.position.x = dot(r1, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r1, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r1, transpose(g_WorldViewProjMatrix)[2]);
	r0.y = dot(r1, transpose(g_WorldViewProjMatrix)[3]);
	r0.z = r0.y + -g_alpha_param.x;
	o.position.w = r0.y;
	r0.y = 1 / g_alpha_param.y;
	r0.y = r0.y * r0.z;
	r0.z = i.texcoord2.z * -i.texcoord2.z + 1;
	r0.z = r0.z * -g_alpha_param.w + r0.w;
	o.texcoord1.w = r0.z * r0.y;
	r0.y = frac(r0.x);
	r0.x = -r0.y + r0.x;
	r0.z = 0;
	o.texcoord.x = r0.x * 0.25 + r0.z;
	o.texcoord.y = 1;
	o.texcoord1.xyz = 1;

	return o;
}
