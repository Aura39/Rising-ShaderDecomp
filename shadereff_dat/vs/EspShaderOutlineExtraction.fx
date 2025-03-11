float4x4 g_WorldViewProjMatrix : register(c24);

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(float4 position : POSITION)
{
	VS_OUT o;

	float4 r0;
	r0.x = dot(position, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(position, transpose(g_WorldViewProjMatrix)[1]);
	r0.z = dot(position, transpose(g_WorldViewProjMatrix)[2]);
	r0.w = dot(position, transpose(g_WorldViewProjMatrix)[3]);
	o.position = r0;
	o.texcoord = r0;

	return o;
}
