float g_ShadowFarInv;
float4x4 g_ShadowView;
float4x4 g_ShadowViewProjection;
float4x4 g_World;

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
	float4 r1;
	r0.x = dot(i.position, transpose(g_World)[0]);
	r0.y = dot(i.position, transpose(g_World)[1]);
	r0.z = dot(i.position, transpose(g_World)[2]);
	r0.w = dot(i.position, transpose(g_World)[3]);
	o.position.x = dot(r0, transpose(g_ShadowViewProjection)[0]);
	o.position.y = dot(r0, transpose(g_ShadowViewProjection)[1]);
	o.position.z = dot(r0, transpose(g_ShadowViewProjection)[2]);
	o.position.w = dot(r0, transpose(g_ShadowViewProjection)[3]);
	r1.x = dot(r0, transpose(g_ShadowView)[0]);
	r1.y = dot(r0, transpose(g_ShadowView)[1]);
	r1.z = dot(r0, transpose(g_ShadowView)[2]);
	r1.w = dot(r0, transpose(g_ShadowView)[3]);
	o.texcoord1 = r1 * g_ShadowFarInv.x;
	o.texcoord = i.texcoord.xy;

	return o;
}
