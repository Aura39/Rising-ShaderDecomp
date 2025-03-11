float4 g_Param : register(c185);
float4x4 g_RotMatrix : register(c40);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_ofs_pos : register(c187);
float4 g_r_spd : register(c189);
float4 g_spd : register(c188);

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
	float3 r1;
	float3 r2;
	float2 r3;
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
	r1.xz = r1.yx * r0.xx;
	r0.x = g_Param.x * g_Param.x;
	r0.xy = r0.xz * g_Param.yx;
	r0.x = r0.x * 0.5 + r0.y;
	r1.y = g_ofs_pos.z * i.position.y + r0.x;
	r0.xy = (0 >= i.texcoord.xy) ? 1 : 0;
	r0.xy = r0.xy * 2 + -1;
	r0.zw = -1;
	r2.xy = (r0.zz >= g_spd.zw) ? 1 : 0;
	r3.xy = lerp(1, r0.xy, r2.xy);
	r0.x = g_ofs_pos.w * i.texcoord.z + r0.w;
	r0.xy = r3.xy * r0.xx;
	r0.xy = r0.xy * g_Param.zw;
	r0.z = frac(i.texcoord2.w);
	r0.z = -r0.z + i.texcoord2.w;
	color.x = r0.z;
	r0.xy = r0.xy * -1;
	o.texcoord = float2(0, 1);
	r0.zw = 0;
	r2.x = dot(r0.xyww, transpose(g_RotMatrix)[0]);
	r2.y = dot(r0.xyww, transpose(g_RotMatrix)[1]);
	r2.z = dot(r0, transpose(g_RotMatrix)[2]);
	r0.xyz = r1.xyz + r2.xyz;
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);

	return o;
}
