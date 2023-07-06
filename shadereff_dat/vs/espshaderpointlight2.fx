float4x4 g_WorldViewProjMatrix;

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
	float r1;
	r0.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	r0.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	r1.x = 1 / r0.w;
	o.texcoord1.xy = r0.xy * r1.xx;
	r0.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position = r0;
	o.texcoord1.zw = r0.zw;
	o.texcoord = i.texcoord.xy;

	return o;
}
