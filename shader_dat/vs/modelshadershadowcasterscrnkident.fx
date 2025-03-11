float g_DentRate : register(c190);
float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProjection : register(c28);
float4x4 g_World : register(c16);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 normal : NORMAL;
	float4 color : COLOR;
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
	r0.x = -0.5 + i.color.y;
	r0.xyz = r0.xxx * i.normal.xyz;
	r0.xyz = r0.xyz * g_DentRate.xxx;
	r0.xyz = r0.xyz * -2 + i.position.xyz;
	r0.w = i.position.w;
	r1.x = dot(r0, transpose(g_World)[0]);
	r1.y = dot(r0, transpose(g_World)[1]);
	r1.z = dot(r0, transpose(g_World)[2]);
	r1.w = dot(r0, transpose(g_World)[3]);
	o.position.x = dot(r1, transpose(g_ShadowViewProjection)[0]);
	o.position.y = dot(r1, transpose(g_ShadowViewProjection)[1]);
	o.position.z = dot(r1, transpose(g_ShadowViewProjection)[2]);
	o.position.w = dot(r1, transpose(g_ShadowViewProjection)[3]);
	o.texcoord1.x = dot(r1, transpose(g_ShadowView)[0]);
	o.texcoord1.y = dot(r1, transpose(g_ShadowView)[1]);
	o.texcoord1.z = dot(r1, transpose(g_ShadowView)[2]);
	o.texcoord = i.texcoord.xy;
	o.texcoord1.w = 200;

	return o;
}
