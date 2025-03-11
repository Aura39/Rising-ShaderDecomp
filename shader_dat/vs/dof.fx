float g_ProjZ : register(c190);
float4 g_TargetUvParam : register(c194);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	o.texcoord = g_TargetUvParam.xy + i.texcoord.xy;
	o.position.xyw = i.position.xyw * float3(2, 2, 0) + float3(1, 1, 0);
	o.position.z = g_ProjZ.x;

	return o;
}
