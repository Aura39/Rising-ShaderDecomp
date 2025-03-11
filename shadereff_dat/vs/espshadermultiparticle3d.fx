float4 g_Param : register(c185);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_ofs_pos : register(c187);
float4 g_r_spd : register(c189);
float4 g_spd : register(c188);

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
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.xyz = g_ofs_pos.xyz + i.position.xyz;
	r1.xyz = g_r_spd.xyz;
	r1.xyz = r1.xyz * i.texcoord.xyz + g_spd.xyz;
	r0.xyz = r1.xyz * g_Param.xxx + r0.xyz;
	r0.w = i.position.w * 0.49974653 + 0.5;
	r0 = frac(r0);
	r0.w = r0.w * 6.2831855 + -3.1415927;
	sincos(r0.ww, r1.xy, r1.xy);
	r0.w = frac(i.texcoord2.w);
	r0.w = -r0.w + i.texcoord2.w;
	color.x = r0.w;
	r1.zw = g_Param.zw;
	r2.zw = r1.zw * -0.01;
	o.texcoord = 0;
	r2.xy = r1.xy * r2.zz;
	r0.xyz = r0.xyz + r2.xwy;
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);

	return o;
}
