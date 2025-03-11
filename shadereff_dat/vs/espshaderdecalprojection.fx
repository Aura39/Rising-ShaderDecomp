float4x4 g_WorldViewMatrix : register(c188);
float4x4 g_WorldViewProjMatrix : register(c24);

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

VS_OUT main(float4 position : POSITION)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0.xy = float2(0, 1);
	r1.w = dot(r0.xxyy, transpose(g_WorldViewMatrix)[3]);
	r1.x = dot(r0.xxyy, transpose(g_WorldViewMatrix)[0]);
	r1.y = dot(r0.xxyy, transpose(g_WorldViewMatrix)[1]);
	r1.z = dot(r0.xxyy, transpose(g_WorldViewMatrix)[2]);
	r0.x = dot(r1, r1);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = r0.xxx * r1.xyz;
	o.texcoord1 = r0.xyz * 0.5 + 0.5;
	r0.x = dot(position, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(position, transpose(g_WorldViewProjMatrix)[1]);
	r0.z = dot(position, transpose(g_WorldViewProjMatrix)[2]);
	r0.w = dot(position, transpose(g_WorldViewProjMatrix)[3]);
	o.position = r0;
	o.texcoord = r0;

	return o;
}
