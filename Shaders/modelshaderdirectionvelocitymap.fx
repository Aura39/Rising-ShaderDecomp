float4 g_TargetUvParam;

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
	o.position = i.position.xyxw * float4(2, 2, 0, 1) + float4(1, 1, 1, 0);

	return o;
}
