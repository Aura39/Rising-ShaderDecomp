float4 g_RenderParam;
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
	float2 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float2 r1;
	o.position.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	r0.zw = g_RenderParam.zw;
	r0.xy = r0.zw * 0.25 + 0.5;
	r0.z = 1 / g_RenderParam.x;
	r1.x = r0.z + r0.z;
	r0.z = 1 / g_RenderParam.y;
	r1.y = r0.z + r0.z;
	o.texcoord.zw = r1.xy * -r0.xy + i.texcoord.xy;
	o.texcoord1 = r1.xy;
	o.texcoord.xy = i.texcoord.xy;

	return o;
}
