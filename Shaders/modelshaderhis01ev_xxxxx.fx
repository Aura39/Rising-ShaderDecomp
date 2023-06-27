sampler Color_1_sampler;
float4 HologramBaseColor;
float4 HologramVelvetColor;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float4 lightpos;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.8;
	clip(r1);
	r1.xy = -r0.yy + r0.xz;
	r0.w = max(abs(r1.x), abs(r1.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.xz = (r0.ww >= 0) ? r0.yy : r0.xz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r0.w = r2.x * i.texcoord2.w;
	r1.xyz = r0.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.w = dot(lightpos.xyz, r2.xyz);
	r1.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = r0.w + -r1.x;
	r0.w = r0.w + 1;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r1.xyz, r2.xyz);
	r0.w = r0.w * 255 + 0.5;
	r1.x = frac(r0.w);
	r0.w = r0.w + -r1.x;
	r0.w = r0.w * -0.003921569 + 1;
	r0.w = log2(r0.w);
	r1.x = r0.w * HologramVelvetColor.w;
	r0.w = r0.w * HologramBaseColor.w;
	r0.w = exp2(r0.w);
	r0.w = -r0.w + 1;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r0.w = exp2(r1.x);
	r1.xyz = r0.www * HologramVelvetColor.xyz;
	r0.xyz = r0.xyz * HologramBaseColor.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
