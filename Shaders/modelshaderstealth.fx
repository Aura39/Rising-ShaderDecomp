sampler Color_1_sampler;
sampler RefractMap_sampler;
float4 g_refractHosei;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(Color_1_sampler, i.texcoord);
	r1 = r0.w + -g_refractHosei.z;
	clip(r1);
	r0.xy = r0.xy + -0.5;
	o.w = r0.w;
	r0.z = 1 / i.texcoord8.w;
	r0.zw = r0.zz * i.texcoord8.xy;
	r1.xy = r0.zw * 0.5 + 0.5;
	r1.z = -r1.y + 1;
	r0.xy = r0.xy * 0.08 + r1.xz;
	r0.xy = r0.xy + g_refractHosei.xy;
	r0 = tex2D(RefractMap_sampler, r0);
	o.xyz = r0.xyz * 0.9;

	return o;
}
