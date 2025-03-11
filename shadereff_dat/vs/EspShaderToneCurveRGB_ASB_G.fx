float4 g_MatrialColor : register(c184);
float4x4 g_WorldViewProjMatrix : register(c24);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	o.texcoord1 = g_MatrialColor * i.texcoord1;
	r0.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	o.position = r0;
	o.texcoord2 = r0;
	o.texcoord = i.texcoord.xy;

	return o;
}
