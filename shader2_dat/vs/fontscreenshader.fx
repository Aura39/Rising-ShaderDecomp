float4 g_Color : register(c62);
float2 g_HalfPixel : register(c63);
float4x4 g_ViewProjMatrix : register(c54);
float4x4 g_WorldMatrix : register(c58);
float2 g_addPos : register(c64);
float3 g_param : register(c65);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float4 color : COLOR;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float r1;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	o.position.w = dot(r0, transpose(g_ViewProjMatrix)[3]);
	r1.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	r0.x = dot(r0, transpose(g_ViewProjMatrix)[1]);
	r0.x = r0.x + g_HalfPixel.y;
	r0.y = r0.x + g_addPos.y;
	r0.z = r1.x + g_HalfPixel.x;
	r0.x = r0.z + g_addPos.x;
	r0.zw = r0.xy * float2(0.5, -0.5) + 0.5;
	o.position.xy = r0.xy;
	o.texcoord1 = r0.zw + -g_HalfPixel.xy;
	o.color = g_Color * i.color;
	o.position.z = 0;
	o.texcoord = i.texcoord.xy;
	o.texcoord2 = g_param.xyz;

	return o;
}
