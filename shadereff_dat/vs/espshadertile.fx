float4x4 g_WorldViewProjMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord7 : TEXCOORD7;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord7 : TEXCOORD7;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	o.position.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	o.texcoord = i.texcoord.xy;
	o.texcoord7 = i.texcoord7;

	return o;
}
