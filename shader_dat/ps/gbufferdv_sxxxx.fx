float4 g_BlurParam : register(c184);
samplerCUBE g_CubeSampler : register(s4);
float4 g_cubeParam : register(c42);

struct PS_IN
{
	float3 texcoord2 : TEXCOORD2;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color3 : COLOR3;
	float4 color : COLOR;
	float4 color2 : COLOR2;
	float4 color1 : COLOR1;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float2 r1;
	r0.x = 1 / i.texcoord8.w;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.z = 1 / i.texcoord7.w;
	r0.xy = i.texcoord7.xy * r0.zz + -r0.xy;
	r1.xy = float2(1, 0.5);
	o.color3.xy = r0.xy * g_BlurParam.xy + r1.yy;
	r0 = tex2D(g_CubeSampler, i.texcoord2);
	r0.w = r1.x + g_cubeParam.z;
	r0.xyz = r0.www * r0.xyz;
	o.color.xyz = r0.xyz;
	o.color2.xyz = r0.xyz;
	o.color.w = 1;
	o.color1 = 0;
	o.color2.w = 0;
	o.color3.zw = 0;

	return o;
}
