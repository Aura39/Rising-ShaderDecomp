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
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float3 r1;
	r0.xyz = g_ofs_pos.xyz + i.position.xyz;
	r1.xyz = g_r_spd.xyz;
	r1.xyz = r1.xyz * i.texcoord.xyz + g_spd.xyz;
	r0.xyz = r1.xyz * g_Param.xxx + r0.xyz;
	r0.xyz = frac(r0.xyz);
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	o.texcoord = i.texcoord.xy;

	return o;
}
