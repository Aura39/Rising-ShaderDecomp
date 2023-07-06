float g_FloorData;
float g_FloorOffset;
float4x4 g_WorldMatrix;
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
	float texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float2 r0;
	o.position.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = 1 / g_FloorOffset.x;
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.y = r0.y + -g_FloorData.x;
	r0.x = r0.y * r0.x + -1;
	r0.y = (r0.y < g_FloorOffset.x) ? 1 : 0;
	o.texcoord1 = r0.y * r0.x + 1;
	o.texcoord = i.texcoord.xy;

	return o;
}
