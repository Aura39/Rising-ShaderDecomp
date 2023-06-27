float4 g_MatrialColorVs;
float4x4 g_Tmp;
float4x4 g_WorldViewProjMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	o.position.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	r0.zw = transpose(g_Tmp)[2].zw;
	o.texcoord.z = r0.z + -1;
	o.texcoord.w = r0.w * g_MatrialColorVs.y;
	o.texcoord.xy = g_MatrialColorVs.wx * i.texcoord.xy;

	return o;
}
