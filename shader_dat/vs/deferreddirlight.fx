float4x4 g_ProjMtx;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	r0.x = 1 / transpose(g_ProjMtx)[0].x;
	r0.y = 1 / transpose(g_ProjMtx)[1].y;
	r0.zw = i.texcoord.xy * float2(2, -2) + float2(2, -2);
	o.texcoord1.xy = r0.xy * r0.zw;
	o.position = i.position * float4(2, 2, 1, 1) + float4(1, 1, 0, 0);
	o.texcoord = i.texcoord.xy;
	o.texcoord1.z = -1;

	return o;
}
