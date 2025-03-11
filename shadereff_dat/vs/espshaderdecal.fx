float4x4 g_WorldViewMatrix : register(c185);
float4x4 g_WorldViewProjMatrix : register(c24);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float3 r0;
	float4 r1;
	o.position.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	r0.xyz = float3(0, -1, 1);
	r1.w = dot(r0.xxyz, transpose(g_WorldViewMatrix)[3]);
	r1.x = dot(r0.xxyz, transpose(g_WorldViewMatrix)[0]);
	r1.y = dot(r0.xxyz, transpose(g_WorldViewMatrix)[1]);
	r1.z = dot(r0.xxyz, transpose(g_WorldViewMatrix)[2]);
	r0.x = dot(r1, r1);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = r0.xxx * r1.xyz;
	o.texcoord1 = r0.xyz * 0.5 + 0.5;
	o.texcoord = i.texcoord.xy;

	return o;
}
