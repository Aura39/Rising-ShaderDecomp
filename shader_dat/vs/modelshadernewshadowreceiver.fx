float4x4 g_Proj : register(c4);
float4x4 g_WorldViewProj : register(c24);

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

	o.position.x = dot(i.position, transpose(g_WorldViewProj)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProj)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProj)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProj)[3]);
	o.texcoord1.x = i.texcoord.x * 2 + -1;
	o.texcoord1.y = i.texcoord.y * -2 + 1;
	o.texcoord1.z = 1 / transpose(g_Proj)[0].x;
	o.texcoord1.w = 1 / transpose(g_Proj)[1].y;
	o.texcoord = i.texcoord.xy;

	return o;
}
