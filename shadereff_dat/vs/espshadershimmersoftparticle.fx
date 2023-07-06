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
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	r0.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	o.position = r0;
	o.texcoord = i.texcoord.xy;
	o.texcoord1 = r0;
	o.texcoord2.zw = r0.zw;
	r0.z = 1 / r0.w;
	r0.xy = r0.zz * r0.xy;
	r0.xy = r0.xy * 0.5 + 0.5;
	o.texcoord2.xy = r0.xy * float2(1, -1) + float2(0, 1);

	return o;
}
