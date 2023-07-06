float4 g_Param;
float4x4 g_WorldViewProjMatrix;
float4 g_ofs_pos;
float4 g_r_spd;
float4 g_spd;

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
	float3 r2;
	float4 r3;
	float2 r4;
	r0.x = i.texcoord.w * 6.28;
	r1.x = g_Param.x;
	r0.x = r1.x * g_spd.y + r0.x;
	r0.x = r0.x * 0.15915494 + 0.5;
	r0.x = frac(r0.x);
	r0.x = r0.x * 6.2831855 + -3.1415927;
	sincos(r0.x, r1.y, r1.y);
	r0.x = i.position.w * 3.14;
	r0.x = r1.y * g_spd.x + r0.x;
	r0.x = r0.x * 0.15915494 + 0.5;
	r0.x = frac(r0.x);
	r0.x = r0.x * 6.2831855 + -3.1415927;
	sincos(r0.xx, r1.xy, r1.xy);
	r0.x = g_ofs_pos.y * i.position.z + g_ofs_pos.x;
	r0.yz = g_r_spd.xy * i.texcoord1.xy + g_r_spd.zw;
	r0.x = r0.y * g_Param.x + r0.x;
	r0.y = r0.z * g_Param.x;
	r2.xz = r1.yx * r0.xx;
	r0.xz = (0 >= i.texcoord.xy) ? 1 : 0;
	r0.xz = r0.xz * 2 + -1;
	r1.zw = -1;
	r3.xy = (r1.zz >= g_spd.zw) ? 1 : 0;
	r4.xy = lerp(1, r0.xz, r3.xy);
	r0.x = g_ofs_pos.w * i.texcoord.z + r1.w;
	r0.xz = r4.xy * r0.xx;
	r0.xz = r0.xz * g_Param.zw;
	r0.w = frac(i.texcoord2.w);
	r0.w = -r0.w + i.texcoord2.w;
	color.x = r0.w;
	r3.yz = r0.xz * -1;
	o.texcoord = float2(0, 1);
	r3.x = -r1.x * r3.y;
	r3.w = r1.y * r3.y;
	r0.x = g_Param.x * g_Param.x;
	r0.x = r0.x * g_Param.y;
	r0.x = r0.x * 0.5 + r0.y;
	r2.y = g_ofs_pos.z * i.position.y + r0.x;
	r0.xyz = r2.xyz + r3.xzw;
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);

	return o;
}
