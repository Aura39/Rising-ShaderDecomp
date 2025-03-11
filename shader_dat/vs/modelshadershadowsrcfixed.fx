float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProjection : register(c28);
float4x4 g_World : register(c16);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
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
	r0.x = dot(i.position, transpose(g_World)[0]);
	r0.y = dot(i.position, transpose(g_World)[1]);
	r0.z = dot(i.position, transpose(g_World)[2]);
	r0.w = dot(i.position, transpose(g_World)[3]);
	o.position.x = dot(r0, transpose(g_ShadowViewProjection)[0]);
	o.position.y = dot(r0, transpose(g_ShadowViewProjection)[1]);
	o.position.z = dot(r0, transpose(g_ShadowViewProjection)[2]);
	o.position.w = dot(r0, transpose(g_ShadowViewProjection)[3]);
	o.texcoord1.x = dot(r0, transpose(g_ShadowView)[0]);
	o.texcoord1.y = dot(r0, transpose(g_ShadowView)[1]);
	o.texcoord1.z = dot(r0, transpose(g_ShadowView)[2]);
	o.texcoord = i.texcoord.xy;
	o.texcoord1.w = 200;

	return o;
}
