float4 g_BlurParam;

struct PS_IN
{
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float2 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float3 r0;
	float r1;
	r0.x = 1 / i.texcoord7.z;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.z = 1 / i.texcoord7.w;
	r0.xy = i.texcoord7.xy * r0.zz + -r0.xy;
	r1.x = 0.5;
	o.color.xy = r0.xy * g_BlurParam.xy + r1.xx;
	o.color.zw = 0;
	o.color1 = i.texcoord3 * float4(0.5, 0.5, 0.5, 1) + float4(0.5, 0.5, 0.5, 0);

	return o;
}
