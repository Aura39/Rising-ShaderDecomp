float4 g_Param;
float4x4 g_WorldViewProjMatrix;
float4 g_ofs_pos;
float4 g_r_spd;
float4 g_spd;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord1 : TEXCOORD1;
	float4 psize : PSIZE;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float r2;
	r0.xyz = g_ofs_pos.xyz + i.position.xyz;
	r1.xyz = g_r_spd.xyz;
	r1.xyz = r1.xyz * i.texcoord.xyz + g_spd.xyz;
	r0.xyz = r1.xyz * g_Param.xxx + r0.xyz;
	r0.xyz = frac(r0.xyz);
	r0.w = 1;
	r1.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	r2.x = 1 / r1.w;
	r1.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	r1.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	r1.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	r0.xy = r2.xx * r1.xy;
	o.position = r1;
	r0.z = 1 / r1.z;
	r0.z = r0.z * g_Param.w;
	r0.z = max(r0.z, 0);
	r0.z = min(r0.z, 64);
	o.texcoord1.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	o.texcoord1.z = g_Param.y;
	o.texcoord1.w = r0.z;
	o.psize = r0.z;

	return o;
}
